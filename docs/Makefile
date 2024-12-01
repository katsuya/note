include ./Makefile.shared

fix:
	@# Help: fix all md files
	npx prettier '*.md' --write
	npx textlint '*.md' --fix

GITIGNORES = Java CMake Maven Gradle Node Python Rust Terraform Go Dart
GITIGNORES_GLOBAL = Archives \
						 Backup \
						 GPG \
						 Linux \
						 macOS \
						 Windows \
						 Xcode
GITIGNORE_URL = https://raw.githubusercontent.com/github/gitignore/main

codegen-gitignore: download-gitignores
	@# Help: regenerates .gitignore from .gitignore.d/*.gitignore
	for i in $$(ls .gitignore.d/*.gitignore | grep -v Local); do \
		{ echo "## $$i START"; cat "$$i"; echo "## $$i END"; }; \
		done > .gitignore;
	{ i=.gitignore.d/Local.gitignore; echo "## $$i START"; cat "$$i"; echo "## $$i END"; } >> .gitignore

download-gitignores: $(GITIGNORES:%=download-gitignore-%) $(GITIGNORES_GLOBAL:%=download-gitignore-global-%)
	@# Help: downloads .gitignore files from github/gitignore

$(GITIGNORES:%=download-gitignore-%): download-gitignore-%:
	curl -sSL "$(GITIGNORE_URL)/$*.gitignore" > ".gitignore.d/$*.gitignore"

$(GITIGNORES_GLOBAL:%=download-gitignore-global-%): download-gitignore-global-%:
	curl -sSL "$(GITIGNORE_URL)/Global/$*.gitignore" > ".gitignore.d/$*.gitignore"
