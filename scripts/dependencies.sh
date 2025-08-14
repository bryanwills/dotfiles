#!/bin/bash

# Dependencies checker for Bryan's dotfiles
# This script checks for required applications and tools

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}================================${NC}"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if application is installed
app_installed() {
    local app="$1"
    if [[ -d "/Applications/$app.app" ]] || [[ -d "$HOME/Applications/$app.app" ]]; then
        return 0
    else
        return 1
    fi
}

# Check for Homebrew
check_homebrew() {
    if ! command_exists brew; then
        print_error "Homebrew is not installed."
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # Add Homebrew to PATH for M1/M2 Macs
        if [[ $(uname -m) == "arm64" ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi

        print_status "Homebrew installed successfully!"
    else
        print_status "Homebrew is already installed."
    fi
}

# Define required applications and their installation methods
declare -A REQUIRED_APPS=(
    # Terminal emulators
    ["kitty"]="brew install --cask kitty"
    ["ghostty"]="brew install --cask ghostty"
    ["iterm2"]="brew install --cask iterm2"

    # Shell and terminal tools
    ["zsh"]="brew install zsh"
    ["tmux"]="brew install tmux"
    ["fish"]="brew install fish"

    # File managers and navigation
    ["nnn"]="brew install nnn"
    ["ranger"]="brew install ranger"
    ["yazi"]="brew install yazi"
    ["eza"]="brew install eza"
    ["bat"]="brew install bat"
    ["btop"]="brew install btop"
    ["htop"]="brew install htop"
    ["neofetch"]="brew install neofetch"

    # Development tools
    ["git"]="brew install git"
    ["gh"]="brew install gh"
    ["curl"]="brew install curl"
    ["wget"]="brew install wget"

    # Programming languages and tools
    ["node"]="brew install node"
    ["npm"]="brew install npm"
    ["pnpm"]="npm install -g pnpm"
    ["cargo"]="curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
    ["uv"]="curl -LsSf https://astral.sh/uv/install.sh | sh"
    ["mise"]="curl https://mise.run | sh"

    # Version control and development
    ["chezmoi"]="brew install chezmoi"
    ["zoxide"]="brew install zoxide"

    # System utilities
    ["gnupg"]="brew install gnupg"
    ["postgresql"]="brew install postgresql@14"
    ["flutter"]="brew install --cask flutter"

    # Network and security tools
    ["naabu"]="brew install naabu"
    ["wireshark"]="brew install --cask wireshark"
    ["filezilla"]="brew install --cask filezilla"
    ["rclone"]="brew install rclone"

    # Text editors and IDEs
    ["nvim"]="brew install neovim"
    ["zed"]="brew install --cask zed"
    ["cursor"]="brew install --cask cursor"
    ["vscode"]="brew install --cask visual-studio-code"

    # Productivity tools
    ["obsidian"]="brew install --cask obsidian"
    ["joplin"]="brew install --cask joplin"
    ["raycast"]="brew install --cask raycast"

    # System customization
    ["sketchybar"]="brew install sketchybar"
    ["ueberzugpp"]="brew install ueberzugpp"

    # Other tools
    ["humanlog"]="brew install humanlog"
    ["envman"]="brew install envman"
    ["simple-update-notifier"]="npm install -g simple-update-notifier"
)

# Define applications that need manual installation or special handling
declare -A MANUAL_APPS=(
    ["spf"]="Superfile - Install manually from https://github.com/lyndeno/superfile"
    ["superfile"]="Superfile - Install manually from https://github.com/lyndeno/superfile"
    ["contour"]="Contour Terminal - Install manually from https://github.com/contour-terminal/contour"
    ["crossnote"]="Crossnote - Install manually from https://github.com/0xGG/crossnote"
    ["claude"]="Claude Desktop - Install manually from https://claude.ai"
    ["flipperdevices.com"]="Flipper Zero - Install manually from https://flipperzero.one"
    ["gcloud"]="Google Cloud CLI - Install manually from https://cloud.google.com/sdk/docs/install"
    ["xbuild"]="Xamarin Build Tools - Install manually from Microsoft"
    ["powershell"]="PowerShell - Install manually from Microsoft"
    ["chrome"]="Google Chrome - Install manually from https://www.google.com/chrome/"
    ["browseruse"]="Browser usage tracking - Custom script"
    ["dotfiles"]="Dotfiles management - Custom setup"
    ["posting"]="Posting tools - Custom scripts"
    ["configstore"]="Config store - Custom setup"
    ["open code"]="Open code tools - Custom setup"
    ["tmux-powerline"]="Tmux powerline - Install via git clone"
    ["bin"]="Custom binaries - Custom setup"
    ["bpytop"]="Bpytop - Install via pip: pip install bpytop"
)

# Check for required applications
check_required_apps() {
    local missing_apps=()
    local manual_apps=()

    print_header "Checking Required Applications"

    for app in "${!REQUIRED_APPS[@]}"; do
        if command_exists "$app" || app_installed "$app"; then
            print_status "$app is installed."
        else
            print_warning "$app is not installed."
            missing_apps+=("$app")
        fi
    done

    # Check manual apps
    for app in "${!MANUAL_APPS[@]}"; do
        if command_exists "$app" || app_installed "$app"; then
            print_status "$app is installed."
        else
            print_warning "$app is not installed."
            manual_apps+=("$app")
        fi
    done

    # Return results
    echo "${missing_apps[@]}" > /tmp/missing_apps.txt
    echo "${manual_apps[@]}" > /tmp/manual_apps.txt
}

# Install missing applications
install_missing_apps() {
    local missing_apps_file="/tmp/missing_apps.txt"

    if [[ ! -f "$missing_apps_file" ]]; then
        print_error "Missing apps file not found. Run check_required_apps first."
        return 1
    fi

    local missing_apps=($(cat "$missing_apps_file"))

    if [[ ${#missing_apps[@]} -eq 0 ]]; then
        print_status "All required applications are already installed!"
        return 0
    fi

    print_header "Installing Missing Applications"
    echo "The following applications need to be installed:"
    for app in "${missing_apps[@]}"; do
        echo "  - $app"
    done

    read -p "Install all missing applications? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_error "Installation cancelled."
        return 1
    fi

    for app in "${missing_apps[@]}"; do
        if [[ -n "${REQUIRED_APPS[$app]}" ]]; then
            print_status "Installing $app..."
            eval "${REQUIRED_APPS[$app]}"
            print_status "$app installed successfully!"
        fi
    done
}

# Show manual installation instructions
show_manual_instructions() {
    local manual_apps_file="/tmp/manual_apps.txt"

    if [[ ! -f "$manual_apps_file" ]]; then
        return 0
    fi

    local manual_apps=($(cat "$manual_apps_file"))

    if [[ ${#manual_apps[@]} -eq 0 ]]; then
        return 0
    fi

    print_header "Manual Installation Required"
    echo "The following applications need to be installed manually:"
    echo ""

    for app in "${manual_apps[@]}"; do
        if [[ -n "${MANUAL_APPS[$app]}" ]]; then
            echo "  - $app: ${MANUAL_APPS[$app]}"
        fi
    done

    echo ""
    print_warning "Please install these applications manually before proceeding."
}

# Main function
main() {
    print_header "Dependency Checker"

    # Check and install Homebrew
    check_homebrew

    # Check for required applications
    check_required_apps

    # Install missing applications
    install_missing_apps

    # Show manual installation instructions
    show_manual_instructions

    print_header "Dependency Check Complete"
    print_status "All dependency checks completed!"
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
