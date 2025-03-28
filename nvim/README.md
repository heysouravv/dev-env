```markdown:README.md
# VSCode to Neovim Migration Guide

A comprehensive guide for developers transitioning from VSCode to Neovim.

## Table of Contents
- [Basic Navigation](#basic-navigation)
- [Text Editing](#text-editing)
- [File Operations](#file-operations)
- [Search and Replace](#search-and-replace)
- [Multiple Cursors and Selection](#multiple-cursors-and-selection)
- [Code Navigation](#code-navigation)
- [Window Management](#window-management)
- [Essential Vim Concepts](#essential-vim-concepts)
- [Common Workflows](#common-workflows)
- [Pro Tips](#pro-tips)
- [Learning Path](#learning-path)

## Basic Navigation

| VSCode | Neovim | Action |
|--------|--------|--------|
| Arrow keys | `h j k l` | Move cursor (←↓↑→) |
| `Ctrl+G` | `gg` | Go to first line |
| `Ctrl+G` | `G` | Go to last line |
| `Home` | `0` | Go to start of line |
| `End` | `$` | Go to end of line |
| `Ctrl+F` | `/` | Find in file |
| `Ctrl+→` | `w` | Move forward by word |
| `Ctrl+←` | `b` | Move backward by word |

## Text Editing

| VSCode | Neovim | Action |
|--------|--------|--------|
| `Ctrl+X` | `dd` | Cut line |
| `Ctrl+C` | `yy` | Copy line |
| `Ctrl+V` | `p` | Paste after cursor |
| - | `P` | Paste before cursor |
| `Ctrl+Z` | `u` | Undo |
| `Ctrl+Y` | `Ctrl+R` | Redo |
| `Ctrl+/` | `gcc` | Comment line |

## File Operations

| VSCode | Neovim | Action |
|--------|--------|--------|
| `Ctrl+P` | `<space>ff` | Quick file open |
| `Ctrl+B` | `<space>e` | Toggle file explorer |
| `Ctrl+W` | `:q` | Close current file |
| `Ctrl+S` | `:w` | Save file |
| `Ctrl+Shift+S` | `:w filename` | Save as |

## Search and Replace

| VSCode | Neovim | Action |
|--------|--------|--------|
| `Ctrl+F` | `/` | Find in file |
| `Ctrl+H` | `:%s/old/new/g` | Replace in file |
| `Ctrl+Shift+F` | `<space>fg` | Find in files |

## Multiple Cursors and Selection

| VSCode | Neovim | Action |
|--------|--------|--------|
| `Ctrl+D` | `*` | Select next occurrence |
| `Ctrl+L` | `V` | Select line |
| `Shift+Alt+↓` | `yyp` | Duplicate line |

## Code Navigation

| VSCode | Neovim | Action |
|--------|--------|--------|
| `F12` | `gd` | Go to definition |
| `Alt+F12` | `K` | Peek definition |
| `Shift+F12` | `gr` | Find references |
| `Ctrl+Space` | `<C-Space>` | Trigger suggestion |
| `F2` | `<space>rn` | Rename symbol |

## Window Management

| VSCode | Neovim | Action |
|--------|--------|--------|
| `Ctrl+\` | `:vsp` | Split vertically |
| `Ctrl+K Ctrl+\` | `:sp` | Split horizontally |
| `Ctrl+Tab` | `<C-w>w` | Switch window |

## Essential Vim Concepts

| Command | Action |
|---------|--------|
| `i` | Enter insert mode |
| `v` | Enter visual mode |
| `V` | Enter visual line mode |
| `ESC` | Return to normal mode |
| `:` | Enter command mode |

## Common Workflows

### Opening Files
```
1. <space>e    - Open file explorer
2. <space>ff   - Fuzzy find files
3. <space>fg   - Search in files
4. <space>fb   - Browse open buffers
```

### Code Editing
```
1. gd          - Go to definition
2. K           - Show documentation
3. <space>ca   - Code actions
4. <space>rn   - Rename symbol
5. <space>f    - Format code
```

## Pro Tips

### Starting with Insert Mode
When beginning with Neovim, you can stay in insert mode (similar to VSCode):
- Press `i` when you start editing
- Press `ESC` when you want to execute commands

### Learning in Phases
1. **Phase 1**: Basic editing (hjkl, i, ESC, :w, :q)
2. **Phase 2**: Efficient movement (w, b, 0, $, gg, G)
3. **Phase 3**: Text objects (diw, ci", yi])
4. **Phase 4**: Advanced features (macros, registers)

### Essential Practice
- Use 'vimtutor' in terminal to learn basics
- Disable arrow keys to force hjkl usage
- Practice one new command each day

### Key Concepts
- ESC gets you back to normal mode
- Most commands follow a pattern: [number][command][motion]
- Use '.' to repeat last change

## Learning Path

### Week 1
- Basic movement (hjkl)
- Insert mode (i, a)
- Save and quit (:w, :q)
- Copy/paste (y, p)

### Week 2
- Word movement (w, b, e)
- Line operations (dd, yy)
- Find in file (/, ?)
- Basic LSP features (gd, K)

### Week 3
- Text objects (iw, i", i])
- Multiple windows (<C-w> commands)
- File navigation (telescope)
- Code completion

## Additional Resources

- Run `:Tutor` in Neovim for interactive tutorial
- Visit [Neovim Documentation](https://neovim.io/doc/)
- Practice at [Vim Adventures](https://vim-adventures.com/)
- Watch [ThePrimeagen's Neovim videos](https://www.youtube.com/c/ThePrimeagen)

## Configuration

The complete Neovim configuration can be found in the `init.lua` file in this repository.

## Contributing

Feel free to submit issues and enhancement requests!

## License

MIT License - feel free to use this guide for any purpose!
```