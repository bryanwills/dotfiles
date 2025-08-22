# Fish tool initialization configuration
# Migrated from Zsh configuration

# Source environment files (Fish-compatible format)
if test -f ~/.keys/.env.openai
    # Fish can't source bash env files directly, so we'll handle this differently
    # The environment variables will be set in the main config.fish
end

# Note: NVM, rbenv, and other bash-based tools need special handling in Fish
# These will be configured separately or replaced with Fish-native alternatives

# Initialize local environment (if it's Fish-compatible)
if test -f $HOME/.local/bin/env
    # Check if it's a Fish-compatible script
    if head -n 1 $HOME/.local/bin/env | grep -q "fish"
        source $HOME/.local/bin/env
    end
end

# Initialize mise (replaces asdf) - Fish-compatible
if test -f $HOME/.local/bin/mise
    eval (mise activate fish)
end

# Initialize zoxide - Fish-compatible
if test -f $HOME/.config/zoxide/init.fish
    source $HOME/.config/zoxide/init.fish
end
