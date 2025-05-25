# Download the script
curl -sSL -o setup_script.sh https://raw.githubusercontent.com/michael-grunewalder/dotfile/main/.config/bootstrap/setup_macbook.sh

# Review the script
less setup_script.sh

# Set execution permissions
chmod +x setup_script.sh

# Set environment variables (if needed)
export GITHUB_TOKEN="your token here"

# Run the script
./setup_script.sh
