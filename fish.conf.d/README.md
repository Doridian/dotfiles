# fish.conf.d

## Structure

The structure of this directory (all folders are optional!) is as follows (`./` represents this directory):

```bash
# Loaded in all non-interactive shell sessions
./non-interactive/
# Loaded in all local (non-SSH) non-interactive shell sessions
./non-interactive/local/
# Loaded in all remote (SSH) non-interactive shell sessions
./non-interactive/remote/

# Loaded in all interactive shell sessions
./interactive/
# Loaded in all local (non-SSH) interactive shell sessions
./interactive/local/
# Loaded in all remote (SSH) interactive shell sessions
./interactive/remote/

# Loaded in all shell sessions
./
# Loaded in all local (non-SSH) shell sessions
./local
# Loaded in all remote (SSH) shell sessions
./remote
```
