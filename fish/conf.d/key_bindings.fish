# Simple key bindings to override Oh My Fish's problematic ones
# This prevents the infinite loop in __original_fish_user_key_bindings

# Basic Fish key bindings
bind \cr 'commandline -f repaint'
bind \cl 'clear; commandline -f repaint'

# Override any Oh My Fish key bindings that might cause issues
function fish_user_key_bindings
    # Do nothing - this prevents Oh My Fish from trying to set up key bindings
end
