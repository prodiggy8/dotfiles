#!/usr/bin/env bash
set -euo pipefail

DIRS=(
    "$HOME/Documents"
    "$HOME/Downloads"
)

FZF_THEME=(
    --color=bw
    --height=100%
    --margin=0,0,0,0
    --layout=reverse
    --info=hidden
    --no-hscroll
)

open_viewer() {
    setsid -f flatpak run com.github.ahrm.sioyek "$1" >/dev/null 2>&1
}

list_documents() {
    fdfind . "${DIRS[@]}" \
        --max-depth=2 \
        --extension=djvu \
        --extension=epub \
        --extension=pdf \
        --absolute-path \
        | sort -uf \
        | while IFS= read -r path; do
            [[ -n "$path" ]] || continue
            printf '%s\t%s\n' "${path##*/}" "$path"
        done
}

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected_row="$(
        list_documents \
            | fzf "${FZF_THEME[@]}" \
                --delimiter=$'\t' \
                --with-nth=1 \
                --nth=1
    )"

    [[ -n "$selected_row" ]] || exit 0
    IFS=$'\t' read -r _display_name selected <<< "$selected_row"
fi

[[ -n "$selected" ]] || exit 0

open_viewer "$selected"

if [[ -n "${TMUX:-}" ]]; then
    tmux display-message "Opened: ${selected##*/}"
fi
