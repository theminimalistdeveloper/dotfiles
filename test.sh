#!/usr/bin/env bash
#
# test.sh - Dotfiles validation script
#
# Validates configurations by checking for broken symlinks, missing dependencies,
# and linting errors in shell scripts and Lua files.
#
# Usage: ./test.sh

set -euo pipefail

# ==============================================================================
# GLOBALS
# ==============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="$HOME/.dotfiles-test.log"
OS_TYPE=""

# ==============================================================================
# OUTPUT HELPERS
# ==============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

print_header() {
    echo -e "\n${BOLD}${BLUE}═══════════════════════════════════════════${NC}"
    echo -e "${BOLD}  $1${NC}"
    echo -e "${BOLD}${BLUE}═══════════════════════════════════════════${NC}\n"
}

print_step() {
    echo -e "\n${BOLD}[$1] $2${NC}"
}

print_success() {
    echo -e "  ${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "  ${RED}✗${NC} $1"
}

print_warning() {
    echo -e "  ${YELLOW}⚠${NC} $1"
}

print_info() {
    echo -e "  ${BLUE}→${NC} $1"
}

# ==============================================================================
# LOGGING
# ==============================================================================

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

init_log() {
    echo "" >> "$LOG_FILE"
    echo "========================================" >> "$LOG_FILE"
    log "Dotfiles test started"
    log "OS: $(uname -s) $(uname -m)"
    log "Script dir: $SCRIPT_DIR"
}

# ==============================================================================
# SYSTEM DETECTION
# ==============================================================================

detect_os() {
    case "$(uname -s)" in
        Darwin)
            OS_TYPE="macos"
            print_success "OS: macOS ($(uname -m))"
            log "Detected OS: macOS ($(uname -m))"
            ;;
        Linux)
            if [[ -f /etc/arch-release ]]; then
                OS_TYPE="arch"
                print_success "OS: Arch Linux ($(uname -m))"
                log "Detected OS: Arch Linux ($(uname -m))"
            else
                OS_TYPE="linux"
                print_success "OS: Linux ($(uname -m))"
                log "Detected OS: Linux ($(uname -m))"
            fi
            ;;
        *)
            print_error "Unsupported OS: $(uname -s)"
            log "ERROR: Unsupported OS: $(uname -s)"
            exit 1
            ;;
    esac
}

# ==============================================================================
# VALIDATION FUNCTIONS
# ==============================================================================

check_symlinks() {
    print_step "1/4" "Checking for broken symlinks"
    local broken_symlinks=0

    while IFS= read -r -d '' symlink; do
        if [[ ! -e "$symlink" ]]; then
            print_error "Broken symlink: $symlink"
            log "Broken symlink: $symlink"
            ((broken_symlinks++))
        fi
    done < <(find "$HOME" -type l -print0 2>/dev/null)

    if [[ $broken_symlinks -eq 0 ]]; then
        print_success "No broken symlinks found"
        log "No broken symlinks found"
    else
        print_error "Found $broken_symlinks broken symlink(s)"
        log "Found $broken_symlinks broken symlink(s)"
        return 1
    fi
}

check_dependencies() {
    print_step "2/4" "Checking dependencies"
    local missing_dependencies=0
    local dependencies=(
        "stow"
        "zsh"
        "neovim"
        "tmux"
        "git"
        "ripgrep"
        "fzf"
    )

    # Add platform-specific dependencies
    case "$OS_TYPE" in
        macos)
            dependencies+=("ghostty")
            ;;
        arch|linux)
            dependencies+=("sway" "i3" "waybar" "tofi" "swaylock")
            ;;
    esac

    for dep in "${dependencies[@]}"; do
        if ! command -v "$dep" &>/dev/null; then
            print_error "Missing dependency: $dep"
            log "Missing dependency: $dep"
            ((missing_dependencies++))
        fi
    done

    if [[ $missing_dependencies -eq 0 ]]; then
        print_success "All dependencies are installed"
        log "All dependencies are installed"
    else
        print_error "Found $missing_dependencies missing dependency(ies)"
        log "Found $missing_dependencies missing dependency(ies)"
        return 1
    fi
}

lint_shell_scripts() {
    print_step "3/4" "Linting shell scripts"
    local lint_errors=0

    if ! command -v shellcheck &>/dev/null; then
        print_warning "shellcheck not installed, skipping shell script linting"
        log "shellcheck not installed, skipping shell script linting"
        return 0
    fi

    while IFS= read -r -d '' script; do
        if ! shellcheck "$script"; then
            ((lint_errors++))
        fi
    done < <(find "$SCRIPT_DIR" -type f -name "*.sh" -print0 2>/dev/null)

    if [[ $lint_errors -eq 0 ]]; then
        print_success "No shell script linting errors found"
        log "No shell script linting errors found"
    else
        print_error "Found $lint_errors shell script(s) with linting errors"
        log "Found $lint_errors shell script(s) with linting errors"
        return 1
    fi
}

lint_lua_files() {
    print_step "4/4" "Linting Lua files"
    local lint_errors=0

    if ! command -v luacheck &>/dev/null; then
        print_warning "luacheck not installed, skipping Lua linting"
        log "luacheck not installed, skipping Lua linting"
        return 0
    fi

    while IFS= read -r -d '' lua_file; do
        if ! luacheck "$lua_file"; then
            ((lint_errors++))
        fi
    done < <(find "$SCRIPT_DIR/nvim" -type f -name "*.lua" -print0 2>/dev/null)

    if [[ $lint_errors -eq 0 ]]; then
        print_success "No Lua linting errors found"
        log "No Lua linting errors found"
    else
        print_error "Found $lint_errors Lua file(s) with linting errors"
        log "Found $lint_errors Lua file(s) with linting errors"
        return 1
    fi
}

# ==============================================================================
# MAIN
# ==============================================================================

main() {
    init_log
    print_header "Dotfiles Validation"

    # Step 1: System detection
    detect_os

    # Step 2: Check for broken symlinks
    check_symlinks || true

    # Step 3: Check dependencies
    check_dependencies || true

    # Step 4: Lint shell scripts
    lint_shell_scripts || true

    # Step 5: Lint Lua files
    lint_lua_files || true

    echo ""
    print_info "Test log saved to: $LOG_FILE"
}

main