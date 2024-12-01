# Note - 2024 Q4

[&#8592; Prev](./2024-Q2.md)

## 2024-12-01 - OSV Scannerについて

[OSV Scanner](https://osv.dev/#use-vulnerability-scanner)を使ってみたが、結構いい感じに使える。GitHubのDependabot alertsを使わないとまともな脆弱性チェックができない状況が終わったかもしれない。まあGoogleが提供しているのでvendor依存な状況は変わらないが、一歩まえに進んだ感じ。正直今までは手間が多すぎて、とりあえずGitHubのrepoにつっこんでた。

```bash
go install github.com/google/osv-scanner/cmd/osv-scanner@v1
osv-scanner -r path/to/dir
```

## 2024-11-29 - Makeのhelpの見直し

markdown形式で出力したくてMakefileのhelpを見直した。もしかしたら10年ぶりぐらいかも。

```make
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
none:;
```

出力は以下な感じになる。prettierで整形してREADME.mdに貼る感じ。

```bash
make | npx prettier --stdin-filepath foo.md
| Target                             | Description                                           |
| ---------------------------------- | ----------------------------------------------------- |
| codegen-gitignore                  | regenerates .gitignore from .gitignore.d/\*.gitignore |
| download-gitignore-CMake           |
| download-gitignore-Dart            |
| download-gitignore-Go              |
| download-gitignore-Gradle          |
| download-gitignore-Java            |
| download-gitignore-Maven           |
| download-gitignore-Node            |
| download-gitignore-Python          |
| download-gitignore-Rust            |
| download-gitignore-Terraform       |
| download-gitignore-global-Archives |
| download-gitignore-global-Backup   |
| download-gitignore-global-GPG      |
| download-gitignore-global-Linux    |
| download-gitignore-global-Windows  |
| download-gitignore-global-Xcode    |
| download-gitignore-global-macOS    |
| download-gitignores                | downloads .gitignore files from github/gitignore      |
| fix                                | fix all md files                                      |
```

ほぼ以下を参考にした。

- https://stackoverflow.com/a/26339924
- https://stackoverflow.com/a/65243296
