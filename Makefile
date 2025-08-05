
all: build install

build: build-pkg build-docs

build-pkg:
	dune build

build-docs:
	dune build @doc

install: install-docs

install-docs:
	install _build/default/_doc/_html/atutils/* /var/www/html/atUtils



