SHELL = /bin/bash -eo pipefail

.SUFFIXES =

.DEFAULT = help

.PHONY: help none
help:
	@printf "%-40s | %s\n" "Target" "Description"
	@printf "%-40s | %s\n" "---" "---"
	@LC_ALL=C $(MAKE) -pRrq none 2>/dev/null | \
		awk -v RS= -F: '/(^|\n)# Files(\n|$$)/,/(^|\n)# Finished Make data base/{ if ($$1 !~ "^[#.]") { print $$1 }}' | \
		sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$' -e none | \
		xargs -I _ $(SHELL) -c 'printf "%-40s | " _; $(MAKE) _ -nB | (grep -i "^# Help:" || echo "") | tail -1 | sed "s/^# Help: //g"'
none: ;
