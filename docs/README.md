# Note - 2024 Q4

[&#8592; Prev](./2024-Q2.md)

## 2024-12-02 - 5年間の学び

5年間の学びをとおして、次は以下を強く意識してやる。

- 事業はマーケットとそこに入るタイミングがすべて。
- 本当のbunrningを創出できるまで、安価にtry and errorを高速にする。
  - 釣りと一緒。すぐバラシが起こる。
  - 仮説をたててとにかくお客さんと話し観察する。
- 得意でやらないといけないことの80%は、やらなくてもいいこと。
  - 得意だから細かいところまで気になる。でも、それは事業にインパクトがほぼない。
- 苦手でめんどくさいことの50%は、ほんとにやらないといけないこと。
  - 無理やりカレンダーに入れる。エンジニアだったら、お客さんと話し観察することに時間を使うなど。
- 毎日日報をかく。
  - 今日何をやったか、明日何をやるか、何を感じたかを書く。
  - 人間は記憶が不確か。自分のことは何もわかっておらず、実はサボっていることが多い。

## 2024-12-02 - Cloudflare One

これだけのZero Trust環境がこんな安価に手に入ってしまうのか。利便性とセキュリティを両立させるのはほんとに難しいが、Cloudflare Oneはそれを実現している。社員の行動を監視して、リスクスコアとかだしてくれる。まあ、全体的にroot証明書の管理をいじって、httpsのMITMで実現している機能が多く、もうグレート・ファイアウォールを何も否定できないな。突き詰めるとやってることは検閲だからな。

https://developers.cloudflare.com/cloudflare-one/insights/risk-score/#predefined-risk-behaviors

## 2024-12-01 - M&AのPMIが完了した

月末の着金をもってM&AのPMIが完了した。これでようやく一段落。新しい人生を歩める。しかし、思ったより大変だった。色々うちの事情を考慮すると大丈夫だろと高をくくっていたら、結局ギリギリになってしまった。

PMIは世のなかで1番燃えやすいプロジェクトの1つというのはよくわかった。1年ぐらい長引くケースがあるのもよくわかる。一般論だが、シンプルに関係する部署やロールが多すぎてめんどい。

## 2024-12-01 - 今Windowsが1番の開発環境かもしれない

Windows TerminalとWSL 2の組み合わせは最高かもしれない。何も不満がない。普通に特別な対応が入っていない素のLinux環境が手に入る。macOSはbrewとかbsd由来のcommandがクセがあるし、Linuxのラップトップ環境はセキュリティの問題で採用しにくい。唯一の不満は、Windowsは各メーカーのトラックパッドとキーボードが信じられないくらいしょぼい。それだけが不満かな。

あとどうでもいいが、WSL2でファイルサーバーのプロトコルとして、9Pが使われているのをしった。懐かしいPlan 9だよ。しかし9Pってそんなに軽量なのか。

> We’ve modified the WSL init daemon to initiate a 9P server. This server contains protocols that support Linux metadata, including permissions. A Windows service and driver that act as the client and talks to the 9P server (which is running inside of a WSL instance). Client and server communicate over AF_UNIX sockets, since WSL allows interop between a Windows application and a Linux application using AF_UNIX as described in this post.
>
> https://devblogs.microsoft.com/commandline/whats-new-for-wsl-in-windows-10-version-1903/

## 2024-12-01 - European Cyber Resilience Act (CRA)

CRAがpublishされていた。3年後から施行らしい。OSS開発者にsecurity-related processesを求めるのは結局変わらなかったのか。まだまだ揉めそうだな。

> On the legislative front, the big news is the European Cyber Resilience Act (CRA), which adds mandatory security requirements for all products sold there. By default, she said, vendors must perform a self-assessment of their compliance with those requirements, though products deemed important or critical require a higher degree of scrutiny. Vendors must offer security updates, free of charge, for a minimum support period of five years. They are required to fix vulnerabilities, including those introduced by dependencies incorporated into their products. There is also a requirement to exercise due diligence with incorporated software and to report security incidents.
>
> The CRA will likely be published in November, she said, and will go into full force three years later. The effect of this legislation on open-source projects has been the subject of a lot of conversation; that has resulted in numerous modifications to the CRA over time. There are protections in place for contributors to projects; the obligations land on those who monetize a project rather than those who contribute patches to it. "Stewards" that support open-source projects are also protected, but they are required to have security-related processes in place.
>
> [The top open-source security events in 2024 - LWN.net](https://lwn.net/Articles/996955/)

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

- [how-do-you-get-the-list-of-targets-in-a-makefile](https://stackoverflow.com/questions/4219255)
