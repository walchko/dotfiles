# My Dot Files

Just some dotfiles to help setup bash on macOS and Linux.

- macOS:
    - Allow homebrew shell: `sudo sh -c "echo $(which bash) >> /etc/shells"`
    - Change to homebrew shell: `chsh -s $(which bash)`
    - Show hidden files: command-shift-.
    - Save `brew` files: `brew bundle dump --describe`
    - Load files: `brew bundle --file brewfile`

- Usage: `ln -s bashrc ~/.profile`
    - Maybe change file name to `profile`?


## Other

- `git`
    - `git config --global core.editor "nano"`


# MIT License

*Copyright (c) 2016 Kevin J. Walchko*

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
