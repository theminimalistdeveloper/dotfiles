#!/bin/bash
# ticket-setup.sh — Create a git worktree branch and open a tmux session for a ticket
#
# Usage: ./ticket-setup.sh TICKET-123
#
# 1. Verifies the current directory is a git repo with worktree support
# 2. Creates a worktree branch named after the ticket
# 3. Opens a new tmux session:
#    - Window 1: neovim
#    - Window 2: opencode with workflow orchestrator agent

set -euo pipefail

TICKET="${1:-}"

if [[ -z "$TICKET" ]]; then
  echo "Error: No ticket name provided."
  echo "Usage: $0 TICKET-123"
  exit 1
fi

# --- Sanity checks ---

if ! git rev-parse --git-dir > /dev/null 2>&1; then
  echo "Error: Not inside a git repository."
  exit 1
fi

# The git worktree base directory (parent of all worktrees).
# We assume the current repo is the main worktree.
WORKTREE_BASE="$(git rev-parse --show-toplevel)"

# Check that git supports worktrees (should be a bare or normal repo).
# We'll use the top-level dir name + ticket for the branch and worktree path.
REPO_NAME="$(basename "$WORKTREE_BASE")"
BRANCH="$TICKET"
WORKTREE_PATH="${WORKTREE_BASE}-${TICKET}"

# --- Create the worktree ---

if [[ -d "$WORKTREE_PATH" ]]; then
  echo "Worktree directory '$WORKTREE_PATH' already exists — switching to it."
  # Try to check out the branch in the existing worktree
  cd "$WORKTREE_PATH"
  git checkout "$BRANCH" 2>/dev/null || true
else
  echo "Creating worktree branch '$BRANCH' at '$WORKTREE_PATH'..."
  git worktree add -b "$BRANCH" "$WORKTREE_PATH"
  cd "$WORKTREE_PATH"
fi

# --- Create tmux session ---

SESSION_NAME="ticket-${TICKET}"

if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  echo "Tmux session '$SESSION_NAME' already exists — attaching."
  tmux attach-session -t "$SESSION_NAME"
  exit 0
fi

# Create a new session with one window (nvim will open first)
tmux new-session -d -s "$SESSION_NAME" -c "$WORKTREE_PATH" -n nvim

# Window 1: neovim
tmux send-keys -t "${SESSION_NAME}:1" "nvim" Enter

# Window 2: opencode with the workflow orchestrator agent
tmux new-window -t "$SESSION_NAME" -n opencode -c "$WORKTREE_PATH"
tmux send-keys -t "${SESSION_NAME}:2" "opencode --agent workflow-orchestrator --prompt 'Do ticket ${TICKET}'" Enter

# Switch to the first window and attach
tmux select-window -t "${SESSION_NAME}:1"
tmux attach-session -t "$SESSION_NAME"
echo "Done."

