#!/bin/bash
# ═══════════════════════════════════════════════════════════
#  Pomodoro Timer for Polybar
#  Usage: pomodoro.sh [display|start|stop|pause|resume|
#         accept-focus|skip-focus|skip-short-pause|
#         skip-long-pause|menu]
# ═══════════════════════════════════════════════════════════

# ── Defaults (override via config-pomodoro.ini) ──────────
DEFAULT_FOCUS_DURATION_MINUTES=20
DEFAULT_SHORT_PAUSE_DURATION_MINUTES=5
DEFAULT_LONG_PAUSE_DURATION_MINUTES=15
DEFAULT_CYCLES_UNTIL_LONG_PAUSE=4

DEFAULT_EMOJI_STOPPED="⏹️"
DEFAULT_EMOJI_PAUSED="⏸️"
DEFAULT_EMOJI_FOCUS="🧠"
DEFAULT_EMOJI_SHORT_PAUSE="🍵"
DEFAULT_EMOJI_LONG_PAUSE="💤"
DEFAULT_EMOJI_AWAITING="🔔"

DEFAULT_TEXT_STOPPED="Stopped"
DEFAULT_TEXT_AWAITING="Ready?"

DEFAULT_COLOR_STOPPED="#D79921"
DEFAULT_COLOR_RUNNING="#A89984"
DEFAULT_COLOR_PAUSED="#D79921"
DEFAULT_COLOR_AWAITING="#D79921"
DEFAULT_COLOR_MENU_DOT="#A89984"

# ── Paths ────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="${SCRIPT_DIR}/config-pomodoro.ini"
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/pomodoro"
STATE_FILE="${CACHE_DIR}/state"

SOUND_ENTER_FOCUS="${SCRIPT_DIR}/enter_focus.mp3"
SOUND_ENTER_SHORT_PAUSE="${SCRIPT_DIR}/enter_short_pause.mp3"
SOUND_ENTER_LONG_PAUSE="${SCRIPT_DIR}/enter_long_pause.mp3"
SOUND_PROMPT_FOCUS="${SCRIPT_DIR}/prompt_focus_start.mp3"

# ── Load configuration ───────────────────────────────────
load_config() {
    # Apply defaults
    focus_duration_minutes=$DEFAULT_FOCUS_DURATION_MINUTES
    short_pause_duration_minutes=$DEFAULT_SHORT_PAUSE_DURATION_MINUTES
    long_pause_duration_minutes=$DEFAULT_LONG_PAUSE_DURATION_MINUTES
    cycles_until_long_pause=$DEFAULT_CYCLES_UNTIL_LONG_PAUSE

    emoji_stopped=$DEFAULT_EMOJI_STOPPED
    emoji_paused=$DEFAULT_EMOJI_PAUSED
    emoji_focus=$DEFAULT_EMOJI_FOCUS
    emoji_short_pause=$DEFAULT_EMOJI_SHORT_PAUSE
    emoji_long_pause=$DEFAULT_EMOJI_LONG_PAUSE
    emoji_awaiting=$DEFAULT_EMOJI_AWAITING

    text_stopped=$DEFAULT_TEXT_STOPPED
    text_awaiting=$DEFAULT_TEXT_AWAITING

    color_stopped=$DEFAULT_COLOR_STOPPED
    color_running=$DEFAULT_COLOR_RUNNING
    color_paused=$DEFAULT_COLOR_PAUSED
    color_awaiting=$DEFAULT_COLOR_AWAITING
    color_menu_dot=$DEFAULT_COLOR_MENU_DOT

    # Override from config file
    if [[ -f "$CONFIG_FILE" ]]; then
        while IFS='=' read -r key value; do
            [[ "$key" =~ ^[[:space:]]*# ]] && continue
            [[ -z "$key" ]] && continue
            key="${key%%[[:space:]]}"
            key="${key##[[:space:]]}"
            value="${value%%[[:space:]]}"
            value="${value##[[:space:]]}"
            [[ "$key" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]] || continue
            printf -v "$key" '%s' "$value"
        done < "$CONFIG_FILE"
    fi
}

# ── State management ─────────────────────────────────────
load_state() {
    current_state="stopped"
    current_phase="focus"
    current_cycle_count=0
    phase_started_timestamp=0
    remaining_seconds=0

    if [[ -f "$STATE_FILE" ]]; then
        source "$STATE_FILE"
    fi
}

save_state() {
    mkdir -p "$CACHE_DIR"
    local tmp="${STATE_FILE}.tmp.$$"
    cat > "$tmp" <<EOF
current_state=${current_state}
current_phase=${current_phase}
current_cycle_count=${current_cycle_count}
phase_started_timestamp=${phase_started_timestamp}
remaining_seconds=${remaining_seconds}
EOF
    mv -f "$tmp" "$STATE_FILE"
}

# ── Sound playback ───────────────────────────────────────
play_sound() {
    local file="$1"
    [[ -f "$file" ]] || return 0
    if command -v mpv &>/dev/null; then
        mpv --no-video --no-terminal "$file" &>/dev/null & disown
    elif command -v paplay &>/dev/null; then
        paplay "$file" &>/dev/null & disown
    fi
}

# ── Helpers ──────────────────────────────────────────────
get_phase_duration_seconds() {
    case "$1" in
        focus)       echo $(( focus_duration_minutes * 60 )) ;;
        short_pause) echo $(( short_pause_duration_minutes * 60 )) ;;
        long_pause)  echo $(( long_pause_duration_minutes * 60 )) ;;
    esac
}

format_time() {
    local secs=$1
    (( secs < 0 )) && secs=0
    printf "%02d:%02d" $(( secs / 60 )) $(( secs % 60 ))
}

# Build the polybar output line
# Args: emoji text text_color [click_action_for_emoji_and_text]
# Emojis are wrapped in %{T2} to use JoyPixels (font-1) at the correct size.
output_line() {
    local emoji="$1" text="$2" text_color="$3" click_action="$4"
    local menu_cmd="${SCRIPT_DIR}/pomodoro.sh menu"
    local dot="%{A1:${menu_cmd}:}%{A3:${menu_cmd}:}%{F${color_menu_dot}}•%{F-}%{A}%{A}"
    local prefix="%{T2}🍅%{T-}"
    local styled_emoji="%{T2}${emoji}%{T-}"

    if [[ -n "$click_action" ]]; then
        echo "%{A1:${click_action}:}${prefix} ${styled_emoji} %{F${text_color}}${text}%{F-}%{A} ${dot}"
    else
        echo "${prefix} ${styled_emoji} %{F${text_color}}${text}%{F-} ${dot}"
    fi
}

# ── Subcommands ──────────────────────────────────────────

cmd_display() {
    load_config
    load_state

    # Stopped — early exit
    if [[ "$current_state" == "stopped" ]]; then
        output_line "$emoji_stopped" "$text_stopped" "$color_stopped"
        save_state
        return
    fi

    # Paused — early exit
    if [[ "$current_state" == "paused" ]]; then
        local time_str
        time_str=$(format_time "$remaining_seconds")
        output_line "$emoji_paused" "$time_str" "$color_paused"
        save_state
        return
    fi

    # Awaiting focus — play prompt, show clickable "Ready?"
    if [[ "$current_state" == "awaiting_focus" ]]; then
        play_sound "$SOUND_PROMPT_FOCUS"
        local accept_cmd="${SCRIPT_DIR}/pomodoro.sh accept-focus"
        output_line "$emoji_awaiting" "$text_awaiting" "$color_awaiting" "$accept_cmd"
        save_state
        return
    fi

    # Running — compute remaining time
    local now duration elapsed remaining
    now=$(date +%s)
    duration=$(get_phase_duration_seconds "$current_phase")
    elapsed=$(( now - phase_started_timestamp ))
    remaining=$(( duration - elapsed ))

    if (( remaining >= 0 )); then
        # Phase still active — show countdown
        local time_str emoji
        time_str=$(format_time "$remaining")
        case "$current_phase" in
            focus)       emoji="$emoji_focus" ;;
            short_pause) emoji="$emoji_short_pause" ;;
            long_pause)  emoji="$emoji_long_pause" ;;
        esac
        remaining_seconds=$remaining
        output_line "$emoji" "$time_str" "$color_running"
        save_state
        return
    fi

    # Phase expired (remaining < 0) — advance
    case "$current_phase" in
        focus)
            # Increment cycle count, transition to pause
            current_cycle_count=$(( current_cycle_count + 1 ))
            local old_duration=$duration
            if (( current_cycle_count >= cycles_until_long_pause )); then
                current_phase="long_pause"
                play_sound "$SOUND_ENTER_LONG_PAUSE"
            else
                current_phase="short_pause"
                play_sound "$SOUND_ENTER_SHORT_PAUSE"
            fi
            # Use precise timestamp to avoid drift
            phase_started_timestamp=$(( phase_started_timestamp + old_duration ))
            duration=$(get_phase_duration_seconds "$current_phase")
            elapsed=$(( now - phase_started_timestamp ))
            remaining=$(( duration - elapsed ))
            remaining_seconds=$remaining
            local time_str emoji
            time_str=$(format_time "$remaining")
            case "$current_phase" in
                short_pause) emoji="$emoji_short_pause" ;;
                long_pause)  emoji="$emoji_long_pause" ;;
            esac
            output_line "$emoji" "$time_str" "$color_running"
            save_state
            ;;
        short_pause|long_pause)
            # Pause ended — enter awaiting_focus
            if [[ "$current_phase" == "long_pause" ]]; then
                current_cycle_count=0
            fi
            current_state="awaiting_focus"
            current_phase="focus"
            remaining_seconds=0
            play_sound "$SOUND_PROMPT_FOCUS"
            local accept_cmd="${SCRIPT_DIR}/pomodoro.sh accept-focus"
            output_line "$emoji_awaiting" "$text_awaiting" "$color_awaiting" "$accept_cmd"
            save_state
            ;;
    esac
}

cmd_start() {
    load_config
    current_state="running"
    current_phase="focus"
    current_cycle_count=0
    phase_started_timestamp=$(date +%s)
    remaining_seconds=0
    save_state
    play_sound "$SOUND_ENTER_FOCUS"
}

cmd_stop() {
    current_state="stopped"
    current_phase="focus"
    current_cycle_count=0
    phase_started_timestamp=0
    remaining_seconds=0
    save_state
}

cmd_pause() {
    load_config
    load_state
    [[ "$current_state" == "running" ]] || return
    local now duration elapsed
    now=$(date +%s)
    duration=$(get_phase_duration_seconds "$current_phase")
    elapsed=$(( now - phase_started_timestamp ))
    remaining_seconds=$(( duration - elapsed ))
    (( remaining_seconds < 0 )) && remaining_seconds=0
    current_state="paused"
    save_state
}

cmd_resume() {
    load_config
    load_state
    [[ "$current_state" == "paused" ]] || return
    local now duration
    now=$(date +%s)
    duration=$(get_phase_duration_seconds "$current_phase")
    # Reconstruct timestamp so that (now - timestamp) = (duration - remaining)
    phase_started_timestamp=$(( now - (duration - remaining_seconds) ))
    current_state="running"
    remaining_seconds=0
    save_state
}

cmd_accept_focus() {
    load_config
    load_state
    [[ "$current_state" == "awaiting_focus" ]] || return
    current_state="running"
    current_phase="focus"
    phase_started_timestamp=$(date +%s)
    remaining_seconds=0
    save_state
    play_sound "$SOUND_ENTER_FOCUS"
}

cmd_skip_focus() {
    load_config
    load_state
    current_state="running"
    current_phase="focus"
    phase_started_timestamp=$(date +%s)
    remaining_seconds=0
    save_state
    play_sound "$SOUND_ENTER_FOCUS"
}

cmd_skip_short_pause() {
    load_config
    load_state
    current_state="running"
    current_phase="short_pause"
    phase_started_timestamp=$(date +%s)
    remaining_seconds=0
    save_state
    play_sound "$SOUND_ENTER_SHORT_PAUSE"
}

cmd_skip_long_pause() {
    load_config
    load_state
    current_state="running"
    current_phase="long_pause"
    current_cycle_count=0
    phase_started_timestamp=$(date +%s)
    remaining_seconds=0
    save_state
    play_sound "$SOUND_ENTER_LONG_PAUSE"
}

cmd_menu() {
    load_config
    load_state

    local options=()

    case "$current_state" in
        stopped)
            options+=("▶ Start")
            ;;
        running)
            options+=("⏸ Pause")
            options+=("⏹ Stop")
            ;;
        paused)
            options+=("▶ Resume")
            options+=("⏹ Stop")
            ;;
        awaiting_focus)
            options+=("▶ Start Focus")
            options+=("⏹ Stop")
            ;;
    esac

    options+=("⏭ Skip to Focus")
    options+=("⏭ Skip to Short Pause")
    options+=("⏭ Skip to Long Pause")

    if ! command -v dmenu &>/dev/null; then
        echo "dmenu not found" >&2
        return 1
    fi

    local choice
    choice=$(printf '%s\n' "${options[@]}" | dmenu -p "Pomodoro")

    case "$choice" in
        "▶ Start")                cmd_start ;;
        "⏸ Pause")                cmd_pause ;;
        "▶ Resume")               cmd_resume ;;
        "▶ Start Focus")          cmd_accept_focus ;;
        "⏹ Stop")                 cmd_stop ;;
        "⏭ Skip to Focus")        cmd_skip_focus ;;
        "⏭ Skip to Short Pause")  cmd_skip_short_pause ;;
        "⏭ Skip to Long Pause")   cmd_skip_long_pause ;;
    esac
}

# ── Main dispatch ────────────────────────────────────────
case "${1:-display}" in
    display)          cmd_display ;;
    start)            cmd_start ;;
    stop)             cmd_stop ;;
    pause)            cmd_pause ;;
    resume)           cmd_resume ;;
    accept-focus)     cmd_accept_focus ;;
    skip-focus)       cmd_skip_focus ;;
    skip-short-pause) cmd_skip_short_pause ;;
    skip-long-pause)  cmd_skip_long_pause ;;
    menu)             cmd_menu ;;
    *)                echo "Unknown command: $1" >&2; exit 1 ;;
esac
