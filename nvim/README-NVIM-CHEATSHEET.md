# Neovim Cheatsheet - Mac-Friendly Edition

## 🎯 **Key Notation Guide**

### **Mac Keyboard → Neovim Notation:**

- **Command (⌘)** = `<D-` (D for "Diamond")
- **Option (⌥)** = `<M-` (M for "Meta")
- **Control (⌃)** = `<C-` (C for "Control")
- **Shift (⇧)** = `<S-` (S for "Shift")
- **Function (Fn)** = `<F-` (F for "Function")

### **Common Examples:**

- `<D-z>` = Command + z (undo)
- `<C-v>` = Control + v (visual block mode)
- `<S-v>` = Shift + v (visual line mode)
- `<M-v>` = Option + v

---

## 🖱️ **Selection & Visual Mode**

### **OS-Like Selection (Insert Mode):**

- `<S-Left>` - Select left
- `<S-Right>` - Select right
- `<S-Up>` - Select up
- `<S-Down>` - Select down
- `<S-PageUp>` - Select page up
- `<S-PageDown>` - Select page down

### **Visual Mode Shortcuts:**

- `<leader>vv` - Visual mode (character-wise)
- `<leader>vl` - Visual line mode
- `<leader>vb` - Visual block mode

### **Quick Selection:**

- `<leader>vw` - Select word
- `<leader>vl` - Select line
- `<leader>vp` - Select paragraph

---

## 📝 **Word-Wrap Keymaps**

### **Basic Word-Wrap:**

- `<leader>ww` - Word-wrap current line
- `<leader>wwp` - Word-wrap paragraph
- `<leader>wwip` - Word-wrap inner paragraph
- `<leader>wwa` - Word-wrap entire file
- `<leader>wws` - Smart word-wrap (context-aware)

### **Range Word-Wrap:**

- `<leader>wwr` - Word-wrap range (interactive)
- `<leader>ww5` - Word-wrap 5 lines
- `<leader>ww10` - Word-wrap 10 lines
- `<leader>wwf` - Word-wrap from cursor to end
- `<leader>wwb` - Word-wrap from beginning to cursor

### **Visual Mode Word-Wrap:**

- `<leader>ww` (visual mode) - Word-wrap selection

---

## 🔄 **Undo/Redo (Mac-Friendly)**

### **Command Key Shortcuts:**

- `<D-z>` - Undo
- `<D-r>` - Redo

### **Traditional Neovim:**

- `u` - Undo
- `<C-r>` - Redo

---

## 📋 **Copy/Paste (Mac-Friendly)**

### **Command Key Shortcuts:**

- `<D-c>` - Copy
- `<D-v>` - Paste

### **Traditional Neovim:**

- `y` - Yank (copy)
- `p` - Paste
- `"+y` - Copy to system clipboard
- `"+p` - Paste from system clipboard

---

## 🪟 **Window Management**

### **Splits:**

- `<leader>sv` - Split window vertically
- `<leader>sh` - Split window horizontally
- `<leader>se` - Make splits equal size
- `<leader>sx` - Close current split

### **Tabs:**

- `<leader>to` - Open new tab
- `<leader>tx` - Close current tab
- `<leader>tn` - Go to next tab
- `<leader>tp` - Go to previous tab
- `<leader>tf` - Open current buffer in new tab

---

## 🔍 **Search & Navigation**

### **Search:**

- `<leader>nh` - Clear search highlights
- `/` - Search forward
- `?` - Search backward
- `n` - Next search result
- `N` - Previous search result

### **Navigation:**

- `h,j,k,l` - Move left, down, up, right
- `w` - Next word
- `b` - Previous word
- `0` - Beginning of line
- `$` - End of line
- `gg` - Beginning of file
- `G` - End of file

---

## 📝 **Editing**

### **Insert Mode:**

- `i` - Insert before cursor
- `a` - Insert after cursor
- `I` - Insert at beginning of line
- `A` - Insert at end of line
- `o` - Insert new line below
- `O` - Insert new line above

### **Delete:**

- `x` - Delete character under cursor
- `dd` - Delete line
- `dw` - Delete word
- `d$` - Delete to end of line

### **Change:**

- `cw` - Change word
- `cc` - Change line
- `c$` - Change to end of line

---

## 🎯 **Context-Aware Word-Wrap**

The smart word-wrap (`<leader>wws`) automatically detects:

### **Markdown Files (.md, .mdx, .mdc):**

- ✅ Formats paragraphs normally
- ❌ Skips code blocks (```)
- ✅ Handles lists and headers

### **Docx Files:**

- ✅ Formats paragraphs normally
- ❌ Skips lists (bullet points, numbered lists)
- ✅ Preserves special formatting

### **Other Files:**

- ✅ Uses default paragraph formatting
- ✅ Respects 130-character limit

---

## 🚀 **Quick Reference**

### **Most Used:**

- `<leader>ww` - Word-wrap current line
- `<leader>wwp` - Word-wrap paragraph
- `<leader>wws` - Smart word-wrap
- `<D-z>` - Undo
- `<D-r>` - Redo
- `<leader>vv` - Visual mode
- `<leader>vl` - Visual line mode
- `<leader>vb` - Visual block mode

### **Remember:**

- **Leader key = Space**
- **Command (⌘) = `<D-`**
- **Control = `<C-`**
- **Shift = `<S-`**
- **Option = `<M-`**

---

## 🔧 **Troubleshooting**

### **If keymaps don't work:**

1. Check if terminal supports the key combination
2. Verify the keymap is loaded (`:map <leader>ww`)
3. Check for conflicts with other plugins

### **If word-wrap doesn't work:**

1. Ensure file is not a config file
2. Check if file has Git merge conflicts
3. Verify textwidth is set to 130

### **If selection doesn't work:**

1. Make sure you're in the right mode
2. Try using `<leader>vv` to enter visual mode
3. Use OS-like shortcuts in insert mode
