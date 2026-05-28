#!/usr/bin/env bash
#
# setup.sh - Dotfiles installation script
#
# Automates GNU Stow-based dotfiles deployment with platform detection,
# backup, dependency checking, and conflict resolution.
#
# Usage: ./setup.sh [OPTIONS]
#   --all            Install all platform-appropriate packages
#   --packages "..." Install specific packages (space-separated)
#   --restow         Re-stow packages (unstow then stow; useful after edits)
#   --unstow         Remove symlinks for selected packages
#   --dry-run        Preview changes without installing
#   --yes, -y        Skip all confirmations
#   --force          Overwrite existing configs (auto-backup conflicts)
#   --no-backup      Skip backup process
#   --help, -h       Show usage information

set -euo pipefail

# ==============================================================================
# GLOBALS
# ==============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
LOG_FILE="$HOME/.dotfiles-install.log"
OS_TYPE=""
DRY_RUN=false
INTERACTIVE=true
AUTO_YES=false
FORCE=false
NO_BACKUP=false
MODE="install"  # install | restow | unstow

MACOS_PACKAGES=(ghostty nvim tmux zsh scripts spaceship)
LINUX_PACKAGES=(ghostty i3 nvim scripts spaceship sway swaylock tmux tofi waybar zsh)
SELECTED_PACKAGES=()
INSTALLED_PACKAGES=()

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
    log "Dotfiles setup started"
    log "OS: $(uname -s) $(uname -m)"
    log "Script dir: $SCRIPT_DIR"
    log "Arguments: $*"
}

# ==============================================================================
# USAGE
# ==============================================================================

show_usage() {
    cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Dotfiles installation script using GNU Stow.

Options:
  --all              Install all platform-appropriate packages
  --packages "..."   Install specific packages (space-separated)
  --dry-run          Preview changes without installing
  --yes, -y          Skip all confirmations
  --force            Overwrite existing configs (auto-backup conflicts)
  --no-backup        Skip backup process
  --help, -h         Show this help message

Examples:
  $(basename "$0")                          # Interactive mode
  $(basename "$0") --all                    # Install all packages
  $(basename "$0") --packages "nvim tmux"   # Install specific packages
  $(basename "$0") --dry-run                # Preview what would happen
  $(basename "$0") --all --yes --force      # Full auto install

Available packages:
  macOS:  ${MACOS_PACKAGES[*]}
  Linux:  ${LINUX_PACKAGES[*]}
EOF
}

# ==============================================================================
# ARGUMENT PARSING
# ==============================================================================

parse_arguments() {
    local custom_packages=""

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --all)
                INTERACTIVE=false
                shift
                ;;
            --packages)
                INTERACTIVE=false
                custom_packages="$2"
                shift 2
                ;;
            --dry-run)
                DRY_RUN=true
                shift
                ;;
            --yes|-y)
                AUTO_YES=true
                shift
                ;;
            --force)
                FORCE=true
                shift
                ;;
            --no-backup)
                NO_BACKUP=true
                shift
                ;;
            --help|-h)
                show_usage
                exit 0
                ;;
            *)
                print_error "Unknown option: $1"
                show_usage
                exit 1
                ;;
        esac
    done

    if [[ -n "$custom_packages" ]]; then
        read -ra SELECTED_PACKAGES <<< "$custom_packages"
    fi
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

check_stow() {
    if command -v stow &>/dev/null; then
        print_success "Stow: installed ($(stow --version 2>&1 | head -1))"
        log "Stow found: $(command -v stow)"
        return 0
    else
        print_error "Stow: not installed"
        log "ERROR: Stow not found"
        echo ""
        echo "  Install GNU Stow first:"
        case "$OS_TYPE" in
            macos)
                echo "    brew install stow"
                ;;
            arch)
                echo "    sudo pacman -S stow"
                ;;
            *)
                echo "    sudo apt install stow   # Debian/Ubuntu"
                echo "    sudo dnf install stow   # Fedora"
                ;;
        esac
        echo ""
        exit 1
    fi
}

# ==============================================================================
# USER INTERACTION
# ==============================================================================

confirm() {
    local prompt="$1"
    local default="${2:-y}"

    if [[ "$AUTO_YES" == true ]]; then
        return 0
    fi

    if [[ "$default" == "y" ]]; then
        prompt="$prompt [Y/n]: "
    else
        prompt="$prompt [y/N]: "
    fi

    read -rp "  $prompt" answer
    answer="${answer:-$default}"

    case "$answer" in
        [Yy]*) return 0 ;;
        *) return 1 ;;
    esac
}

select_packages_interactive() {
    local available_packages=()

    case "$OS_TYPE" in
        macos)
            available_packages=("${MACOS_PACKAGES[@]}")
            ;;
        arch|linux)
            available_packages=("${LINUX_PACKAGES[@]}")
            ;;
    esac

    echo ""
    echo "  Available packages for ${OS_TYPE}:"
    echo ""
    for i in "${!available_packages[@]}"; do
        printf "    %2d. %s\n" "$((i + 1))" "${available_packages[$i]}"
    done
    echo ""

    read -rp "  Select packages (comma-separated numbers, or 'all'): " selection

    if [[ "$selection" == "all" ]]; then
        SELECTED_PACKAGES=("${available_packages[@]}")
    else
        IFS=',' read -ra indices <<< "$selection"
        for idx in "${indices[@]}"; do
            idx=$(echo "$idx" | tr -d ' ')
            if [[ "$idx" =~ ^[0-9]+$ ]] && ((idx >= 1 && idx <= ${#available_packages[@]})); then
                SELECTED_PACKAGES+=("${available_packages[$((idx - 1))]}")
            else
                print_warning "Invalid selection: $idx (skipping)"
            fi
        done
    fi

    if [[ ${#SELECTED_PACKAGES[@]} -eq 0 ]]; then
        print_error "No packages selected. Exiting."
        exit 1
    fi

    echo ""
    print_info "Selected: ${SELECTED_PACKAGES[*]}"
    log "Selected packages: ${SELECTED_PACKAGES[*]}"
}

# ==============================================================================
# BACKUP
# ==============================================================================

get_stow_targets() {
    local package="$1"
    local targets=()
    local pkg_dir="$SCRIPT_DIR/$package"

    while IFS= read -r -d '' file; do
        local relative="${file#"$pkg_dir"/}"
        local target="$HOME/$relative"
        if [[ -e "$target" && ! -L "$target" ]]; then
            targets+=("$target")
        elif [[ -L "$target" ]]; then
            local link_target
            link_target="$(readlink "$target" 2>/dev/null || true)"
            if [[ "$link_target" != *"$SCRIPT_DIR"* ]]; then
                targets+=("$target")
            fi
        fi
    done < <(find "$pkg_dir" -type f -not -name '.stow-local-ignore' -print0 2>/dev/null)

    printf '%s\n' "${targets[@]}"
}

find_conflicts() {
    local conflicts=()

    for package in "${SELECTED_PACKAGES[@]}"; do
        while IFS= read -r target; do
            [[ -n "$target" ]] && conflicts+=("$target")
        done < <(get_stow_targets "$package")
    done

    printf '%s\n' "${conflicts[@]}"
}

backup_configs() {
    local conflicts=()

    while IFS= read -r line; do
        [[ -n "$line" ]] && conflicts+=("$line")
    done < <(find_conflicts)

    if [[ ${#conflicts[@]} -eq 0 ]]; then
        print_success "No conflicting files found"
        log "No conflicts detected"
        return 0
    fi

    print_warning "Found ${#conflicts[@]} conflicting file(s):"
    for file in "${conflicts[@]}"; do
        echo "    - ${file/#$HOME/\~}"
    done
    echo ""

    if [[ "$NO_BACKUP" == true ]]; then
        print_info "Skipping backup (--no-backup)"
        log "Backup skipped (--no-backup flag)"
        return 0
    fi

    if [[ "$DRY_RUN" == true ]]; then
        print_info "Would backup to: ${BACKUP_DIR/#$HOME/\~}/"
        return 0
    fi

    if ! confirm "Create backup of conflicting files?"; then
        print_warning "Proceeding without backup"
        log "User declined backup"
        return 0
    fi

    mkdir -p "$BACKUP_DIR"

    for file in "${conflicts[@]}"; do
        local relative="${file#"$HOME"/}"
        local backup_path="$BACKUP_DIR/$relative"
        mkdir -p "$(dirname "$backup_path")"
        mv "$file" "$backup_path"
        log "Backed up: $file -> $backup_path"
    done

    echo "$(date '+%Y-%m-%d %H:%M:%S') - Backed up ${#conflicts[@]} file(s)" > "$BACKUP_DIR/backup.log"
    printf '%s\n' "${conflicts[@]}" >> "$BACKUP_DIR/backup.log"

    print_success "Backup created: ${BACKUP_DIR/#$HOME/\~}/"
    log "Backup complete: $BACKUP_DIR (${#conflicts[@]} files)"
}

# ==============================================================================
# STOW OPERATIONS
# ==============================================================================

stow_package() {
    local package="$1"
    local pkg_dir="$SCRIPT_DIR/$package"

    if [[ ! -d "$pkg_dir" ]]; then
        print_error "$package (directory not found)"
        log "ERROR: Package directory not found: $pkg_dir"
        return 1
    fi

    if [[ "$DRY_RUN" == true ]]; then
        local output
        output=$(stow -n -v "$package" 2>&1) || true
        print_success "$package (dry-run)"
        if [[ -n "$output" ]]; then
            echo "$output" | sed 's/^/      /'
        fi
        return 0
    fi

    local stow_output
    if stow_output=$(stow -v "$package" 2>&1); then
        print_success "$package"
        log "Stowed: $package"
        INSTALLED_PACKAGES+=("$package")
        return 0
    else
        if echo "$stow_output" | grep -q "existing target"; then
            handle_conflict "$package" "$stow_output"
            return $?
        else
            print_error "$package"
            echo "$stow_output" | sed 's/^/      /'
            log "ERROR: Failed to stow $package: $stow_output"
            return 1
        fi
    fi
}

handle_conflict() {
    local package="$1"
    local error_output="$2"

    print_warning "$package - conflict detected"
    echo "$error_output" | grep "existing target" | sed 's/^/      /'
    echo ""

    if [[ "$FORCE" == true ]]; then
        print_info "Force mode: backing up and overwriting"
        force_stow_package "$package"
        return $?
    fi

    echo "    Options:"
    echo "      1) Backup conflicting files and retry"
    echo "      2) Skip this package"
    echo "      3) Abort installation"
    echo ""
    read -rp "    Choose [1/2/3]: " choice

    case "$choice" in
        1)
            force_stow_package "$package"
            return $?
            ;;
        2)
            print_info "Skipping $package"
            log "Skipped package due to conflict: $package"
            return 0
            ;;
        3)
            print_error "Installation aborted by user"
            log "Installation aborted by user at conflict: $package"
            exit 1
            ;;
        *)
            print_error "Invalid choice. Skipping $package"
            return 0
            ;;
    esac
}

force_stow_package() {
    local package="$1"

    if [[ "$NO_BACKUP" != true ]]; then
        mkdir -p "$BACKUP_DIR"
        local conflicts
        conflicts=$(get_stow_targets "$package")
        while IFS= read -r file; do
            [[ -z "$file" ]] && continue
            local relative="${file#"$HOME"/}"
            local backup_path="$BACKUP_DIR/$relative"
            mkdir -p "$(dirname "$backup_path")"
            mv "$file" "$backup_path"
            log "Force backup: $file -> $backup_path"
        done <<< "$conflicts"
    fi

    # Remove symlinks that might point elsewhere
    local pkg_dir="$SCRIPT_DIR/$package"
    while IFS= read -r -d '' file; do
        local relative="${file#"$pkg_dir"/}"
        local target="$HOME/$relative"
        if [[ -L "$target" ]]; then
            rm "$target"
        fi
    done < <(find "$pkg_dir" -type f -not -name '.stow-local-ignore' -print0 2>/dev/null)

    if stow -v "$package" 2>&1; then
        print_success "$package (forced)"
        log "Force stowed: $package"
        INSTALLED_PACKAGES+=("$package")
        return 0
    else
        print_error "$package (force failed)"
        log "ERROR: Force stow failed for $package"
        return 1
    fi
}

stow_all_packages() {
    local failed=0

    for package in "${SELECTED_PACKAGES[@]}"; do
        if ! stow_package "$package"; then
            ((failed++))
        fi
    done

    return $failed
}

# ==============================================================================
# DEPENDENCY CHECKING
# ==============================================================================

check_dependencies() {
    local missing_packages=()
    local missing_manual=()

    # Check Oh My Zsh (for zsh package)
    if printf '%s\n' "${SELECTED_PACKAGES[@]}" | grep -qx "zsh"; then
        if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
            missing_manual+=("oh-my-zsh|zsh|sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\"")
        fi
    fi

    # Check TPM (for tmux package)
    if printf '%s\n' "${SELECTED_PACKAGES[@]}" | grep -qx "tmux"; then
        if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
            missing_manual+=("tpm|tmux|git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm")
        fi
    fi

    # Check Neovim version (for nvim package)
    if printf '%s\n' "${SELECTED_PACKAGES[@]}" | grep -qx "nvim"; then
        if ! command -v nvim &>/dev/null; then
            missing_packages+=("neovim")
        else
            local nvim_version
            nvim_version=$(nvim --version 2>/dev/null | head -1 | grep -oE '[0-9]+\.[0-9]+' | head -1)
            local nvim_minor
            nvim_minor=$(echo "$nvim_version" | cut -d. -f2)
            if [[ -n "$nvim_minor" ]] && ((nvim_minor < 10)); then
                print_warning "Neovim $nvim_version found, but 0.10+ is required"
                missing_packages+=("neovim")
            fi
        fi
    fi

    # Check tmux binary
    if printf '%s\n' "${SELECTED_PACKAGES[@]}" | grep -qx "tmux"; then
        if ! command -v tmux &>/dev/null; then
            missing_packages+=("tmux")
        fi
    fi

    # Check zsh binary
    if printf '%s\n' "${SELECTED_PACKAGES[@]}" | grep -qx "zsh"; then
        if ! command -v zsh &>/dev/null; then
            missing_packages+=("zsh")
        fi
    fi

    # Check git (needed for TPM and Oh My Zsh)
    if ! command -v git &>/dev/null; then
        missing_packages+=("git")
    fi

    # Check ripgrep (used in zsh FZF config)
    if printf '%s\n' "${SELECTED_PACKAGES[@]}" | grep -qx "zsh"; then
        if ! command -v rg &>/dev/null; then
            missing_packages+=("ripgrep")
        fi
    fi

    # Check fzf
    if ! command -v fzf &>/dev/null; then
        missing_packages+=("fzf")
    fi

    # Report findings
    if [[ ${#missing_packages[@]} -eq 0 && ${#missing_manual[@]} -eq 0 ]]; then
        print_success "All dependencies satisfied"
        log "All dependencies satisfied"
        return 0
    fi

    print_warning "Missing dependencies detected:"
    echo ""

    # System packages
    if [[ ${#missing_packages[@]} -gt 0 ]]; then
        local unique_packages
        unique_packages=($(printf '%s\n' "${missing_packages[@]}" | sort -u))

        if [[ "$DRY_RUN" == true ]]; then
            echo "  Would recommend installing:"
        else
            echo "  System packages to install:"
        fi

        for pkg in "${unique_packages[@]}"; do
            echo "    - $pkg"
        done
        echo ""

        case "$OS_TYPE" in
            macos)
                echo "  ${BOLD}brew install ${unique_packages[*]}${NC}"
                ;;
            arch)
                # Separate pacman and AUR packages
                local pacman_pkgs=()
                local aur_pkgs=()
                for pkg in "${unique_packages[@]}"; do
                    case "$pkg" in
                        neovim|tmux|zsh|git|ripgrep|fzf)
                            pacman_pkgs+=("$pkg")
                            ;;
                        *)
                            aur_pkgs+=("$pkg")
                            ;;
                    esac
                done
                if [[ ${#pacman_pkgs[@]} -gt 0 ]]; then
                    echo -e "  ${BOLD}sudo pacman -S ${pacman_pkgs[*]}${NC}"
                fi
                if [[ ${#aur_pkgs[@]} -gt 0 ]]; then
                    echo -e "  ${BOLD}yay -S ${aur_pkgs[*]}${NC}"
                fi
                ;;
            *)
                echo -e "  ${BOLD}sudo apt install ${unique_packages[*]}${NC}"
                ;;
        esac
        echo ""
    fi

    # Manual installations
    if [[ ${#missing_manual[@]} -gt 0 ]]; then
        echo "  Manual installations required:"
        echo ""
        for entry in "${missing_manual[@]}"; do
            IFS='|' read -r name required_by command <<< "$entry"
            echo "    $name (required by $required_by):"
            echo -e "    ${BOLD}$command${NC}"
            echo ""
        done
    fi

    log "Missing packages: ${missing_packages[*]:-none}"
    log "Missing manual deps: ${missing_manual[*]:-none}"
    return 0
}

# ==============================================================================
# DRY RUN
# ==============================================================================

dry_run_preview() {
    print_header "DRY RUN - No changes will be made"

    print_step "1/4" "System information"
    detect_os
    check_stow

    print_step "2/4" "Packages to install"
    for pkg in "${SELECTED_PACKAGES[@]}"; do
        if [[ -d "$SCRIPT_DIR/$pkg" ]]; then
            print_success "$pkg"
        else
            print_error "$pkg (not found)"
        fi
    done

    print_step "3/4" "Symlinks that would be created"
    for pkg in "${SELECTED_PACKAGES[@]}"; do
        if [[ -d "$SCRIPT_DIR/$pkg" ]]; then
            local output
            output=$(cd "$SCRIPT_DIR" && stow -n -v "$pkg" 2>&1) || true
            if [[ -n "$output" ]]; then
                echo "  $pkg:"
                echo "$output" | sed 's/^/    /'
            fi
        fi
    done

    print_step "4/4" "Dependency check"
    check_dependencies

    echo ""
    print_info "No changes were made. Remove --dry-run to proceed."
    log "Dry run completed"
}

# ==============================================================================
# MAIN
# ==============================================================================

main() {
    parse_arguments "$@"
    init_log "$@"

    # Dry run with pre-selected packages
    if [[ "$DRY_RUN" == true && ${#SELECTED_PACKAGES[@]} -eq 0 && "$INTERACTIVE" == false ]]; then
        detect_os
        case "$OS_TYPE" in
            macos) SELECTED_PACKAGES=("${MACOS_PACKAGES[@]}") ;;
            *) SELECTED_PACKAGES=("${LINUX_PACKAGES[@]}") ;;
        esac
        dry_run_preview
        exit 0
    fi

    print_header "Dotfiles Setup"

    # Step 1: System detection
    print_step "1/6" "Detecting system..."
    detect_os
    check_stow

    # Step 2: Package selection
    print_step "2/6" "Selecting packages..."

    if [[ ${#SELECTED_PACKAGES[@]} -gt 0 ]]; then
        # Packages were specified via --packages flag
        print_info "Packages specified: ${SELECTED_PACKAGES[*]}"
    elif [[ "$INTERACTIVE" == true ]]; then
        select_packages_interactive
    else
        # --all mode
        case "$OS_TYPE" in
            macos) SELECTED_PACKAGES=("${MACOS_PACKAGES[@]}") ;;
            *) SELECTED_PACKAGES=("${LINUX_PACKAGES[@]}") ;;
        esac
        print_info "Installing all packages: ${SELECTED_PACKAGES[*]}"
    fi

    # Validate packages exist
    local valid_packages=()
    for pkg in "${SELECTED_PACKAGES[@]}"; do
        if [[ -d "$SCRIPT_DIR/$pkg" ]]; then
            valid_packages+=("$pkg")
        else
            print_warning "Package '$pkg' not found, skipping"
            log "WARNING: Package not found: $pkg"
        fi
    done
    SELECTED_PACKAGES=("${valid_packages[@]}")

    if [[ ${#SELECTED_PACKAGES[@]} -eq 0 ]]; then
        print_error "No valid packages to install"
        exit 1
    fi

    # Dry run mode
    if [[ "$DRY_RUN" == true ]]; then
        dry_run_preview
        exit 0
    fi

    # Step 3: Backup
    print_step "3/6" "Checking for conflicts..."
    backup_configs

    # Step 4: Confirm
    if [[ "$AUTO_YES" != true ]]; then
        echo ""
        if ! confirm "Proceed with installation of ${#SELECTED_PACKAGES[@]} package(s)?"; then
            print_info "Installation cancelled"
            log "Installation cancelled by user"
            exit 0
        fi
    fi

    # Step 5: Stow packages
    print_step "4/6" "Installing packages..."
    cd "$SCRIPT_DIR"
    local failed
    failed=0
    stow_all_packages || failed=$?

    # Step 6: Check dependencies
    print_step "5/6" "Checking dependencies..."
    check_dependencies

    # Summary
    print_step "6/6" "Summary"
    echo ""
    if [[ ${#INSTALLED_PACKAGES[@]} -gt 0 ]]; then
        print_success "Installed ${#INSTALLED_PACKAGES[@]} package(s): ${INSTALLED_PACKAGES[*]}"
    fi
    if [[ $failed -gt 0 ]]; then
        print_warning "$failed package(s) had issues"
    fi

    echo ""
    echo "  Next steps:"
    echo "    1. Install any missing dependencies listed above"
    echo "    2. Restart your shell or run: source ~/.zshrc"
    echo "    3. For tmux plugins: press prefix + I inside tmux"
    echo ""

    log "Setup complete: ${#INSTALLED_PACKAGES[@]} installed, $failed failed"
    print_info "Log saved to: $LOG_FILE"
}

main "$@"
