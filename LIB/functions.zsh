function install_functions() {
    echo
    read -k1 "install?Install related convenience functions? RECOMMENDED (y/n): "
    echo
    if [[ ! ${install} =~ ^[Yy]$ ]]; then
        return
    fi

    functions_dir=~/.devopschris/functions
    target_dir=$functions_dir/$1
    functions_list=($(ls functions))

    echo "Uninstalling previously existing functions..."
    unfunction -m '.*'

    echo Installing: ${functions_list}
    mkdir -p $target_dir
    cp -r functions/* $target_dir

    grep -qxF 'source ~/.devopschris/functions/activate' ~/.zshenv 2> /dev/null \
      || echo 'source ~/.devopschris/functions/activate' >> ~/.zshenv

    cat <<'EOF' >$functions_dir/activate
#!/usr/bin/env zsh
directory_list=($(ls -d ~/.devopschris/functions/*/))

fpath=($directory_list $fpath)

for dir_name in ${directory_list[@]}; do
  for app in $(ls $dir_name); do
    autoload $app
  done
done
EOF

    # Check if the script is not already sourced
    if [ "$ZSH_EVAL_CONTEXT" != "toplevel" ]; then
        echo "Sourcing the activation script automatically."
        # Source the activation script automatically
        source $functions_dir/activate
    else
        echo "To activate the functions in the current shell, run the following once this setup is finished:"
        echo
        echo '    source ~/.devopschris/functions/activate'
        echo
    fi

    echo "Functions have been installed and are now active in this shell."
}


# To add subscription to prompt... 
function add_azure_prompt_to_zshrc() {
    ZSHRC="$HOME/.zshrc"

    # Function and prompt to add
    function_text="function get_current_azure_subscription() {
        local sub_name=\$(az account show --query name -o tsv 2>/dev/null)
        if [[ -n \"\$sub_name\" ]]; then
            echo \"%{\$fg[blue]%}☁️ %{\$fg[magenta]%}\$sub_name%{\$fg[blue]%} ☁️ %{\$reset_color%}\"
        fi
    }"
    prompt_text="PROMPT+=\" %{\$fg[blue]%}\$(get_current_azure_subscription)\""

    # Function to check and add text to .zshrc
    function add_to_zshrc {
        local text="$1"
        local zshrc="$2"
        if ! grep -Fq "$text" "$zshrc"; then
            echo "$text" >> "$zshrc"
            echo "Added to .zshrc: $text"
        else
            echo "Already in .zshrc: $text"
        fi
    }

    add_to_zshrc "$function_text" "$ZSHRC"
    add_to_zshrc "$prompt_text" "$ZSHRC"

echo "\e[1;32mRun 'source $ZSHRC' to apply changes.\e[0m"

}