#!/bin/bash

# Default configurations
DEFAULT_THEME="tokyonight"
DEFAULT_OUTPUT="build/.tmux.conf"

# Parse command line arguments
while getopts "t:o:" opt; do
    case $opt in
        t)
            THEME_NAME="$OPTARG"
            ;;
        o)
            if [[ "$OPTARG" == "root" ]]; then
                OUTPUT_PATH="$HOME/.tmux.conf"
            else
                OUTPUT_PATH="$OPTARG"
            fi
            ;;
        *)
            echo "Usage: $0 [-t theme_name] [-o output_path]"
            exit 1
            ;;
    esac
done

# Set defaults if parameters are not provided
THEME_NAME="${THEME_NAME:-$DEFAULT_THEME}"
OUTPUT_PATH="${OUTPUT_PATH:-$DEFAULT_OUTPUT}"

# Define repository paths
REPO_DIR="$(pwd)"
BUILD_DIR="$(dirname "$OUTPUT_PATH")"
CONF_DIR="$REPO_DIR/conf.d"
THEME_DIR="$REPO_DIR/themes"
BUILD_CONF="$BUILD_DIR/.tmux.conf"

# Ensure the build directory exists (if not root)
if [[ "$OUTPUT_PATH" != "$HOME/.tmux.conf" ]]; then
    mkdir -p "$BUILD_DIR"
fi

# Start writing the base configuration
cat <<EOF > "$BUILD_CONF"
# Define the absolute path manually
set -g @tmux-config-dir "\$HOME/.config/tmux"
set -g default-terminal "screen-256color"

EOF

# Append all configurations from conf.d/
echo "# Loading configuration files from conf.d" >> "$OUTPUT_PATH"
for conf_file in "$CONF_DIR"/*.conf; do
    echo "# Sourcing $(basename "$conf_file")" >> "$OUTPUT_PATH"
    cat "$conf_file" >> "$OUTPUT_PATH"
    echo "" >> "$OUTPUT_PATH"
done

# Check if the selected theme file exists
THEME_FILE_PATH="$THEME_DIR/$THEME_NAME.conf"

if [ -f "$THEME_FILE_PATH" ]; then
    echo "# Applying theme: $THEME_NAME" >> "$OUTPUT_PATH"
    cat "$THEME_FILE_PATH" >> "$OUTPUT_PATH"
    echo "" >> "$OUTPUT_PATH"
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
echo "📂 Location: $OUTPUT_PATH"

