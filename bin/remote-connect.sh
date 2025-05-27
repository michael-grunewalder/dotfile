#!/usr/bin/env zsh

CONFIG_FILE="$HOME/.config/remote-servers/servers.conf"

if [[ ! -f "$CONFIG_FILE" ]]; then
    mkdir -p "$HOME/.config/remote-servers"
    cat > "$CONFIG_FILE" <<EOF
# Format: GROUP:user@host.domain.com[:LABEL]
# Example entries:
Work:admin@server1.work.com:Production Server
Work:user@server2.work.com:Testing Server
Home:pi@raspberrypi.local:Raspberry Pi
Private:user@personal-server.com
EOF
    echo "Configuration file created at $CONFIG_FILE"
    echo "Please edit it with your servers and run this script again."
    exit 0
fi

select_group() {
    local groups
    groups=$(grep -v "^#" "$CONFIG_FILE" | cut -d':' -f1 | sort | uniq)
    echo "$groups\n---\nMaintain Servers\nExit" | \
        fzf --prompt="Select group: " --height=40% --layout=reverse --border
}

select_server() {
    local group="$1"
    local servers_with_labels=""
    while IFS=: read -r grp addr label; do
        [[ "$grp" == "$group" ]] || continue
        local display_name="${label:-$addr}"
        servers_with_labels+="$display_name | $addr"$'\n'
    done < <(grep -v "^#" "$CONFIG_FILE")
    echo "${servers_with_labels}---\nBack to groups" | \
        fzf --prompt="Select server from $group: " --height=40% --layout=reverse --border
}

while true; do
    selected_group=$(select_group)
    [[ -z "$selected_group" || "$selected_group" == "Exit" ]] && echo "Exiting..." && exit 0

    if [[ "$selected_group" == "Maintain Servers" ]]; then
        ${EDITOR:-vim} "$CONFIG_FILE"
        continue  # reload config and show group selection again
    fi

    while true; do
        selected_server_line=$(select_server "$selected_group")
        [[ -z "$selected_server_line" || "$selected_server_line" == "Back to groups" ]] && break

        # Extract the address part
        selected_server=$(echo "$selected_server_line" | awk -F' \\| ' '{print $2}')
        [[ -z "$selected_server" ]] && continue

        echo "Connecting to $selected_server..."
        ssh "$selected_server"
        exit 0
    done
done

