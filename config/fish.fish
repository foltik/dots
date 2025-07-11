# Fix defaults
set -U fish_greeting ""
bind --erase --preset alt-e
# Vars
set -x TERM xterm-256color
set -x VISUAL nvim

# Hooks
starship init fish | .
direnv hook fish | .

alias ls="exa"
alias ll="exa -lh"
alias lla="exa -lah"
alias llt="exa -lah --sort time"
alias lt="exa -lTh"

abbr -a e nvim
abbr -a y yazi

abbr -a rsync rsync -Pavzr

abbr -a cc cargo check
abbr -a cb cargo build
abbr -a cr cargo run --
abbr -a cbr cargo build -r
abbr -a cbr cargo run -r --

abbr -a g git
abbr -a gs git status
abbr -a gc git switch
abbr -a gcc git switch -c
abbr -a gcd git branch -D
abbr -a gd git diff
abbr -a gds git diff --staged
abbr -a ga git add
abbr -a gr git reset --hard
abbr -a gr1 git reset --hard HEAD~1
abbr -a grs1 git reset --soft HEAD~1
abbr -a gf git pull
abbr -a gff git fetch
abbr -a gp git push
abbr -a gl git log
abbr -a gl1 git log -n1
abbr -a gl3 git log -n3
abbr -a gcm git commit -m
abbr -a gcf git commit --fixup
abbr -a gca git commit --amend --no-edit
abbr -a gb git rebase
abbr -a gbi git rebase -i
abbr -a gbc git rebase --continue
abbr -a gu git restore --staged
abbr -a gy git stash -u
abbr -a gyp git stash pop
abbr -a gyl git stash list
abbr -a gys git stash show -p

# Reload config
function reload
    ~/code/dots/bootstrap.sh
    for config in ~/.config/fish/**/*.fish
        . $config
    end
end

# Find process
set ps_cols "pid,user,start,command"
function pg
    ps x -o $ps_cols | head -n1
    ps x -o $ps_cols | rg -v rg | rg $argv
end
# Kill process
function pk
    ps x | rg -v rg | rg $argv | awk '{print $1}' | xargs kill
end

# Fasd
function _fasd -e fish_postexec
    if test $status -eq 0
        set input (fasd --sanitize "$argv")
        set input (string replace '~' $HOME "$input")
        fasd --proc (string split ' ' $input)
    end
end
function z
    set dir (fasd -dlR $argv | head -n 1)
    test -z $dir && return
    test -d $dir && cd $dir
end
