if status is-interactive
	if test -z "$SSH_CLIENT"
		export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-tpm-agent.sock"
	end

	alias tfi='tofu init -upgrade'
	alias tfip='tfi ; tfp'
	alias tfp='tofu plan -out tf.plan'
	alias tfa='tofu apply tf.plan ; rm tf.plan'

	alias gp='git push'
	alias gpl='git pull'
	alias gco='git checkout'
	alias grb='git rebase'
	alias gcm='git commit -m'
	alias gaa='git add --all'
end
