#!/usr/bin/env bash

# Exit on error
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Starting development environment setup...${NC}"

# Check if running on macOS
if [[ $(uname) != "Darwin" ]]; then
    echo -e "${RED}This script is only for macOS${NC}"
    exit 1
fi

# Check for Homebrew and install if not present
if ! command -v brew &> /dev/null; then
    echo -e "${BLUE}Installing Homebrew...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install core dependencies
echo -e "${BLUE}Installing core dependencies...${NC}"
brew install \
    git \
    node \
    python3 \
    cmake \
    gcc \
    electron \
    jq

# Install yabai
echo -e "${BLUE}Installing yabai...${NC}"
brew install koekeishiya/formulae/yabai
brew services start yabai

# Install sketchybar
echo -e "${BLUE}Installing sketchybar...${NC}"
brew install FelixKratz/formulae/sketchybar
brew services start sketchybar

# Create necessary directories
echo -e "${BLUE}Creating config directories...${NC}"
mkdir -p ~/.config/yabai
mkdir -p ~/.config/sketchybar

# Copy configuration files
echo -e "${BLUE}Setting up configurations...${NC}"

# Setup yabai spaces
cat > ~/.config/yabai/create_spaces.sh << 'EOL'
#!/usr/bin/env sh

function setup_space {
    local idx="$1"
    local name="$2"
    local space=
    echo "setup space $idx : $name"
    
    space=$(yabai -m query --spaces --space "$idx")
    if [ -z "$space" ]; then
        yabai -m space --create
    fi
    
    yabai -m space "$idx" --label "$name"
}

# Initialize spaces
setup_space 1 communication
setup_space 2 daily
setup_space 3 coding
setup_space 4 classbro

sketchybar --trigger space_change --trigger windows_on_spaces
EOL

chmod +x ~/.config/yabai/create_spaces.sh

# Setup sketchybar config
mkdir -p ~/.config/sketchybar/plugins
mkdir -p ~/.config/sketchybar/items

# Install development tools
echo -e "${BLUE}Installing development tools...${NC}"
npm install -g electron-packager
npm install -g create-electron-app

# Final setup steps
echo -e "${BLUE}Running final setup steps...${NC}"

# Start services
echo -e "${BLUE}Starting services...${NC}"
~/.config/yabai/create_spaces.sh

# Set proper permissions
chmod -R 755 ~/.config/yabai
chmod -R 755 ~/.config/sketchybar

echo -e "${GREEN}Installation complete!${NC}"
echo -e "${BLUE}Please log out and log back in for all changes to take effect.${NC}" 