#!/usr/bin/env fish

cd (dirname (status --current-filename))

function _server_update -a server
	set -l gitremote "server-$server"

	git remote add $gitremote "$server:~/dotfiles"
	or git remote set-url $gitremote "$server:~/dotfiles"

	git push $gitremote main
	ssh $server -- /bin/sh -c "'cd ~/dotfiles && git reset --hard'"
end

function _server_init -a server
	if _server_update $server
		return 0
	end

	ssh $server -- /bin/sh -c "'rm -rf ~/dotfiles && mkdir -p ~/dotfiles && cd ~/dotfiles && git init && git config receive.denyCurrentBranch ignore'"
	or return 1

	_server_update $server
end

for server in (cat ./machines/servers.txt)
	_server_init $server
end

