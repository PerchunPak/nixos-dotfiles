set -ex
if [ ! -d "$HOME/dev/python-template" ]; then
	git clone https://github.com/PerchunPak/python-template ~/dev/python-template

	cd ~/dev/python-template
	nix-shell -p python3Packages.virtualenv --run 'python -m virtualenv .venv'
	source .venv/bin/activate
	pip install cruft lice setuptools
else
	cd ~/dev/python-template
	git pull
fi
