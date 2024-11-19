SHELL=/bin/bash -eo pipefail

list:
	@LC_ALL=C $(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | \
		awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | \
		sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'

codegen_gitignore:
	for i in .gitignore.d/*.gitignore; do \
		{ echo "## $$i START"; cat $$i; echo "## $$i END"; }; \
		done > .gitignore;

download_gitignore:
	for i in Archives Backup GPG Linux macOS Windows Xcode VisualStudioCode JetBrains; do \
		curl -sSL https://raw.githubusercontent.com/github/gitignore/main/Global/$$i.gitignore > .gitignore.d/$$i.gitignore; \
		done
	for i in Java CMake Maven Gradle Node Python Rust Terraform Go Dart; do \
		curl -sSL https://raw.githubusercontent.com/github/gitignore/main/$$i.gitignore > .gitignore.d/$$i.gitignore; \
		done
