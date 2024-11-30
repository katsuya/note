SHELL = /bin/bash -eo pipefail

.SUFFIXES =

.DEFAULT = help

.PHONY: help none
help:
	$(MAKE) -pRrq -f none 2>/dev/null | \
		awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | \
		sort | egrep -v -e '^[^[:alnum:]]' -e none -e '^$@$$'
none: ;

GITIGNORES = Java CMake Maven Gradle Node Python Rust Terraform Go Dart
GITIGNORES_GLOBAL = Archives \
						 Backup \
						 GPG \
						 Linux \
						 macOS \
						 Windows \
						 Xcode \
						 VisualStudioCode \
						 JetBrains
GITIGNORE_URL = https://raw.githubusercontent.com/github/gitignore/main

codegen-gitignore: download-gitignores
	for i in $$(ls .gitignore.d/*.gitignore | grep -v Local); do \
		{ echo "## $$i START"; cat "$$i"; echo "## $$i END"; }; \
		done > .gitignore;
	{ i=.gitignore.d/Local.gitignore; echo "## $$i START"; cat "$$i"; echo "## $$i END"; } >> .gitignore

download-gitignores: $(GITIGNORES:%=download-gitignore-%) $(GITIGNORES_GLOBAL:%=download-gitignore-global-%)

$(GITIGNORES:%=download-gitignore-%): download-gitignore-%:
	curl -sSL "$(GITIGNORE_URL)/$*.gitignore" > ".gitignore.d/$*.gitignore"

$(GITIGNORES_GLOBAL:%=download-gitignore-global-%): download-gitignore-global-%:
	curl -sSL "$(GITIGNORE_URL)/Global/$*.gitignore" > ".gitignore.d/$*.gitignore"
