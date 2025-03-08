if test -z "$SSH_CLIENT"
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-tpm-agent.sock"
end
