# GoFish
# A small wrapper for managing golang workspaces

# Namespace can be defined with set -x GOFISH_NAMESPACE
# Current shell use name is the default
if not set -q GOFISH_NAMESPACE
    set -g GOFISH_NAMESPACE $USER
end

alias goon acgoworkspace
alias gooff degoworkspace

function mkgoworkspace --description "Create a new golang Workspace"
    if [ (count $argv) -lt 1 ]
        echo "You need to specify a workspace name"
        return 1
    end

    set workspace_name $argv[1]

    set src_path "src/$GOFISH_NAMESPACE/$workspace_name"

    # creating standard directories
    mkdir "bin"
    mkdir -p $src_path
    mkdir "pkg"

    touch "$src_path/main.go"

    acgoworkspace $workspace_name
end

function acgoworkspace --description "Activate a Go Workspace"
    if [ (count $argv) -lt 1 ]
        echo "You need to specify a workspace name"
        return 1
    end

    set -g GOPATH $PWD
end

function degoworkspace --description "Deactivate a go workspace"
    if set -q GOPATH
        set -e GOPATH
    end
end
