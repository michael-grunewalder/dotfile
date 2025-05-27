#!/usr/bin/env zsh

# Path to the configuration file
CONFIG_FILE="$HOME/.config/remote-servers/servers.conf"

# Check if config file exists
if [[ ! -f "$CONFIG_FILE" ]]; then
    mkdir -p "$HOME/.config/remote-servers"
    echo "# Format: GROUP:user@host.domain.com[:LABEL]" > "$CONFIG_FILE"
    echo "# Example entries:" >> "$CONFIG_FILE"
    echo "Work:admin@server1.work.com:Production Server" >> "$CONFIG_FILE"
    echo "Work:user@server2.work.com:Testing Server" >> "$CONFIG_FILE"
    echo "Home:pi@raspberrypi.local:Raspberry Pi" >> "$CONFIG_FILE"
    echo "Private:user@personal-server.com" >> "$CONFIG_FILE"
    echo "Configuration file created at $CONFIG_FILE"
    echo "Please edit it with your servers and run this script again."
    exit 0
fi

# Function to select a group
select_group() {
    # Extract unique groups
    groups=$(grep -v "^#" "$CONFIG_FILE" | cut -d':' -f1 | sort | uniq)

    # Add the maintenance and exit options at the bottom with a separator
    selected_group=$(echo "$groups\n---\nMaintain Servers\nExit" | fzf --prompt="Select group: " --height=40% --layout=reverse --border)

    # Check if maintenance option was selected
    if [[ "$selected_group" == "Maintain Servers" ]]; then
        ${EDITOR:-vim} "$CONFIG_FILE"
        # After editing, re-read the config file
        return 1 # Indicate that the config file was edited
    elif [[ "$selected_group" == "Exit" ]]; then
        return 2 # Indicate that the user wants to exit
    fi

    echo "$selected_group"
    return 0 # Indicate that a group was selected
}

# Function to select a server from a group
select_server() {
    local group=$1

    # Get servers for the selected group with their labels
    # Format each line as "LABEL or ADDRESS | ADDRESS"
    servers_with_labels=""
    while IFS=: read -r grp addr label; do
        if [[ "$grp" == "$group" ]]; then
            # If label exists, use it; otherwise use the address
            display_name="${label:-$addr}"
            servers_with_labels+="$display_name | $addr"$'\n'
        fi
    done < <(grep -v "^#" "$CONFIG_FILE")

    # Add a back option at the bottom
    selected_server_line=$(echo "${servers_with_labels}---\nBack to groups" | fzf --prompt="Select server from $group: " --height=40% --layout=reverse --border)

    # Check if back option was selected
    if [[ "$selected_server_line" == "Back to groups" ]]; then
        echo "Back to groups"
        return
    fi

    # Extract the actual server address from the selected line
    selected_server=$(echo "$selected_server_line" | awk -F' \\| ' '{print $2}')
    echo "$selected_server"
}

# Main loop to allow navigation between screens
while true; do
    # Select a group
    select_group
    local group_result=$?

    # If the config file was edited, re-run the select_group function
    if [[ $group_result -eq 1 ]]; then
        continue
    elif [[ $group_result -eq 2 ]]; then
        echo "Exiting..."
        exit 0
    fi

    selected_group=$(select_group)

    # Exit if no group was selected
    [[ -z "$selected_group" ]] && exit 0

    # Select a server from the group
    selected_server=$(select_server "$selected_group")

    # Exit if no server was selected
    [[ -z "$selected_server" ]] && exit 0

    # Check if back option was selected
    if [[ "$selected_server" == "Back to groups" ]]; then
        continue
    fi

    # Connect to the selected server
    echo "Connecting to $selected_server..."
    ssh "$selected_server"
    exit 0
done

