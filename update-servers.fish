#!/usr/bin/env fish

cd (dirname (status --current-filename))

function _server_init -a gitremote server
	if git push $gitremote main
		return 0
	end

	ssh $server -- /bin/sh -c "'mkdir -p ~/dotfiles && git -C ~/dotfiles init && git -C ~/dotfiles receive.denyCurrentBranch ignore'"
	or return 1

	git push $gitremote main
end

for server in (cat ./machines/servers.txt)
	#set -l remote_home (ssh "$server" -- echo '$HOME')
        #echo "Home = $remote_home"

	set -l gitremote "server-$server"

	git remote add $gitremote "$server:~/dotfiles"
	or git remote set-url $gitremote "$server:~/dotfiles"

	_server_init $gitremote $server
end

