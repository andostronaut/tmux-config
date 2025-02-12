#!/bin/bash

# Default theme if none is provided
DEFAULT_THEME="tokyonight"

# Parse command line arguments for the theme parameter
while getopts "t:" opt; do
    case $opt in
        t)
            THEME_NAME="$OPTARG"
            ;;
        *)
            echo "Usage: $0 -t theme_name"
            exit 1
            ;;
    esac
done

# If no theme is provided, use the default theme
THEME_NAME="${THEME_NAME:-$DEFAULT_THEME}"

# Define repository paths
REPO_DIR="$(pwd)"
BUILD_DIR="$REPO_DIR/build"
CONF_DIR="$REPO_DIR/conf.d"
THEME_DIR="$REPO_DIR/themes"
BUILD_CONF="$BUILD_DIR/.tmux.conf"

# Ensure the build directory exists
mkdir -p "$BUILD_DIR"

# Start writing the base configuration
cat <<EOF > "$BUILD_CONF"
# Define the absolute path manually
set -g @tmux-config-dir "\$HOME/.config/tmux"
set -g default-terminal "screen-256color"

EOF

# Append all configurations from conf.d/
echo "# Loading configuration files from conf.d" >> "$BUILD_CONF"
for conf_file in "$CONF_DIR"/*.conf; do
    echo "# Sourcing $(basename "$conf_file")" >> "$BUILD_CONF"
    cat "$conf_file" >> "$BUILD_CONF"
    echo "" >> "$BUILD_CONF"
done

# Check if the selected theme file exists
THEME_FILE_PATH="$THEME_DIR/$THEME_NAME.conf"

if [ -f "$THEME_FILE_PATH" ]; then
    echo "# Applying theme: $THEME_NAME" >> "$BUILD_CONF"
    cat "$THEME_FILE_PATH" >> "$BUILD_CONF"
    echo "" >> "$BUILD_CONF"
else
    echo "Error: Theme file $THEME_FILE_PATH not found!"
    exit 1
fi

# Append the final settings
cat <<EOF >> "$BUILD_CONF"
# remove delay for exiting insert mode with ESC in Neovim
set -sg escape-time 10

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
EOF

# Completion message
echo "✅ TMUX configuration has been built successfully!"
echo "📂 Location: $BUILD_CONF"
echo "📋 To use it, copy it with:"
echo "  cp $BUILD_CONF ~/.config/tmux/.tmux.conf"
