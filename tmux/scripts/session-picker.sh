#!/usr/bin/env bash
# ~/dotfiles/tmux/scripts/session-picker.sh
#
# Custom TUI session picker. No fuzzy search.
#   ↑ / ↓  (or k / j)  navigate sessions
#   Enter               switch to the highlighted session
#   Esc / q / Ctrl-C    cancel

set -e

# --- GitHub Dark Dimmed colors ---
ESC=$'\033'
BOLD="${ESC}[1m"
FG="${ESC}[38;2;173;186;199m"       # #adbac7
MUTED="${ESC}[38;2;118;131;144m"    # #768390
BLUE="${ESC}[38;2;83;155;245m"      # #539bf5
YELLOW="${ESC}[38;2;198;144;38m"    # #c69026
SELECT="${ESC}[38;2;34;39;46;48;2;83;155;245m" # #22272e on #539bf5
RESET="${ESC}[0m"
HIDE_CURSOR="${ESC}[?25l"
SHOW_CURSOR="${ESC}[?25h"
CLEAR="${ESC}[2J"
MOVE_HOME="${ESC}[H"
CLEAR_LINE="${ESC}[2K"

# --- Build the items list ---
declare -a items          # S|id|name|path|attached or W|window_index|window_name|is_last
declare -a session_rows   # item indexes that are selectable

current_session=$(tmux display-message -p '#{session_id}')
default_selected_pos=0

tmp=$(mktemp)
trap 'rm -f "$tmp"; printf "%s" "$SHOW_CURSOR"' EXIT INT TERM

tmux list-sessions -F '#{session_id}	#{session_name}	#{pane_current_path}	#{?session_attached,1,0}' > "$tmp"

short_path() {
    local path="$1"
    printf '%s' "${path/#$HOME/~}"
}

base_label() {
    local path="$1" name="$2" base
    base="${path##*/}"
    [ -n "$base" ] && printf '%s' "$base" || printf '%s' "$name"
}

truncate() {
    local text="$1" max="$2"
    if [ "${#text}" -le "$max" ]; then
        printf '%s' "$text"
    elif [ "$max" -gt 1 ]; then
        printf '%s…' "${text:0:$((max - 1))}"
    fi
}

while IFS=$'\t' read -r id name path att; do
    [ "$id" = "$current_session" ] && default_selected_pos=${#session_rows[@]}
    session_rows+=("${#items[@]}")
    items+=("S|${id}|${name}|${path}|${att}")

    win_idx=0
    win_total=$(tmux list-windows -t "$id" 2>/dev/null | wc -l | tr -d ' ')
    while IFS=$'\t' read -r widx wname; do
        win_idx=$((win_idx + 1))
        is_last=0
        [ "$win_idx" -eq "$win_total" ] && is_last=1
        items+=("W|${widx}|${wname}|${is_last}")
    done < <(tmux list-windows -t "$id" -F '#{window_index}	#{window_name}' 2>/dev/null)
done < "$tmp"

session_total=${#session_rows[@]}
item_total=${#items[@]}
if [ "$session_total" -eq 0 ]; then
    printf '%s%sNo sessions found.\n' "$CLEAR" "$MOVE_HOME"
    sleep 1
    exit 1
fi

selected_pos=$default_selected_pos
scroll=0

# --- Draw ---
draw() {
    local selected="${session_rows[$selected_pos]}"
    local lines cols header_rows footer_rows viewport end i

    lines=$(tput lines 2>/dev/null || printf 24)
    cols=$(tput cols 2>/dev/null || printf 80)
    # Keep the old/stable viewport accounting from the working version, but
    # don't render the header/footer. Leaving slack avoids drawing into the
    # popup border/status area on some terminals, which can make the popup
    # flicker or immediately close.
    header_rows=1
    footer_rows=1
    viewport=$((lines - header_rows - footer_rows))
    [ "$viewport" -lt 5 ] && viewport=5

    # Keep selected row visible.
    if [ "$selected" -lt "$scroll" ]; then
        scroll="$selected"
    elif [ "$selected" -ge $((scroll + viewport)) ]; then
        scroll=$((selected - viewport + 1))
    fi

    end=$((scroll + viewport))
    [ "$end" -gt "$item_total" ] && end="$item_total"

    printf '%s%s' "$CLEAR" "$MOVE_HOME"

    [ "$scroll" -gt 0 ] && printf '%s  … earlier%s\n' "$MUTED" "$RESET"

    for ((i = scroll; i < end; i++)); do
        IFS='|' read -r type a b c d <<< "${items[$i]}"
        printf '%s' "$CLEAR_LINE"

        if [ "$type" = "S" ]; then
            local id="$a" name="$b" path="$c" att="$d" label spath row max_path
            label=$(base_label "$path" "$name")
            spath=$(short_path "$path")
            max_path=$((cols - 30))
            [ "$max_path" -lt 12 ] && max_path=12
            spath=$(truncate "$spath" "$max_path")

            if [ "$i" -eq "$selected" ]; then
                [ "$att" = "1" ] && att=" attached" || att=""
                row=$(printf '▸ %-4s %-18s %s%s' "$name" "$label" "$spath" "$att")
                printf ' %s%s%s%s\n' "$SELECT" "$BOLD" "$row" "$RESET"
            else
                [ "$att" = "1" ] && att=" ${YELLOW}attached${RESET}" || att=""
                printf '   %s%-4s%s %s%-18s%s %s%s%s%b\n' \
                    "$BLUE" "$name" "$RESET" "$FG" "$label" "$RESET" \
                    "$MUTED" "$spath" "$RESET" "$att"
            fi
        else
            local widx="$a" wname="$b" is_last="$c" branch='├─'
            [ "$is_last" = "1" ] && branch='└─'
            wname=$(truncate "$wname" $((cols - 16)))
            printf '        %s%s %-3s %s%s\n' "$MUTED" "$branch" "$widx" "$wname" "$RESET"
        fi
    done

    [ "$end" -lt "$item_total" ] && printf '%s  … more%s\n' "$MUTED" "$RESET"

    return 0
}

# --- Main loop ---
printf '%s' "$HIDE_CURSOR"
draw

while true; do
    IFS= read -rsn1 key 2>/dev/null || break
    case "$key" in
        $'\x1b')
            read -rsn1 -t 0.01 k1 2>/dev/null
            if [ -z "$k1" ]; then
                break
            fi
            read -rsn1 -t 0.01 k2 2>/dev/null
            case "$k1$k2" in
                '[A'|'OA') selected_pos=$(( (selected_pos - 1 + session_total) % session_total )); draw ;;
                '[B'|'OB') selected_pos=$(( (selected_pos + 1) % session_total )); draw ;;
            esac
            ;;
        '')
            IFS='|' read -r _ id _ <<< "${items[${session_rows[$selected_pos]}]}"
            tmux switch-client -t "$id"
            break
            ;;
        k|j)
            if [ "$key" = "k" ]; then
                selected_pos=$(( (selected_pos - 1 + session_total) % session_total ))
            else
                selected_pos=$(( (selected_pos + 1) % session_total ))
            fi
            draw
            ;;
        q|Q|$'\x03')
            break
            ;;
    esac
done

printf '%s' "$SHOW_CURSOR"
