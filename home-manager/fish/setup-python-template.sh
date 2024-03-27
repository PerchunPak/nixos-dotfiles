if [ ! -d '~/dev/python-template' ]; then
	git clone https://github.com/PerchunPak/python-template ~/dev/python-template

	cd ~/dev/python-template
	python -m venv .venv
	source .venv/bin/activate
	pip install cruft lice setuptools
else
	cd ~/dev/python-template
	git pull
fi
