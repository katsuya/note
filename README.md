# Note

## 2024-06-14 - Yubikeyの買い替え

もうプライベートのyubikeyは8年前のやつなのでそろそろ買い換えることにした。よう8年も壊れなかったな。backup用も含めると2本いるんだが、円安の影響で1本あたり11,600 円する。高いな。gpgやsshの秘密鍵を入れてるから、どうしても高いmultiple protocol対応のシリーズじゃないと使えないんだよな。 https://ykey.yubion.com/products/yubikey-5c-nfc

新しいfirmwareは5.7で、passkey用のslotが25から100まで増えてた。これなら実用に耐えれるかな。device-bound passkeysを使う人が増えそう。 https://www.yubico.com/blog/now-available-for-purchase-yubikey-5-series-and-security-key-series-with-new-5-7-firmware/

> - **Expanded passkey and passwordless storage capabilities** – accommodating up to 100 device-bound passkeys (up from 25), 64 OATH seeds (up from 32), 24 PIV certificates, and 2 OTP seeds at once for a total of 190 credentials.

どうでもいいが、google playの翻訳が盛大に間違えてた。報告する方法がわからないの放置することに。使ってるのiphoneだからごめんね。

![](IMG_1856.png)

## 2024-06-14 - ニコニコのランサムウェアについて

https://x.com/sigekun/status/1801495357496693048?s=12 によるとどうやらランサムウェアらしい。一度汚染されると復旧時間がかかるのはわかる。bitbankとかはSumo Logic入れてるらしいが、同じことが起こったらすべてのオペレーションに対してaudit logが存在してそこから逆算とかできるのかな。

今後Webサービス運営のコストは上がりそうだな。どうでもいいが、個人的にgoogleのsecurity operation platformの https://chronicle.security/ とかは触ってみたいな。

## 2024-06-14 - ジョガーパンツについて

Nikeのテックフリースのジョガーパンツを5年以上愛用しているんだが、もう高くなりすぎて手が出なくなってしまった。Nikeは16000円で、ユニクロは3000円。まえは8000円とかだったのに。。。ちょっと安いっぽいのだがユニクロかな。

ちなみに今までは、トップスはユニクロ、ボトムスはNike、靴はオニヅカタイガー、時計はG-SHOCKという感じだったんだった。ユニクロのボトムスは安っぽいんだよな。まだ迷っている。

## 2024-06-13 - Transaction Cost Theory

スキマバイトは、導入する企業から見ると人材の調達に関して `内部調達コスト > 外部調達コスト` になったってことだと思う。自前で採用して教育するコストが高くなってしまったのか、テクノロジーの発展や価値観の変化でshotの労働者を集めるコストが低くなったのか、その両方かわからないが。

> 具体的には、「取引費用理論」は、外部市場での取引に伴うコスト（例えば、契約交渉、監督、実行のコスト）と、企業内部での取引に伴うコスト（例えば、組織管理、調整のコスト）を考慮して、どちらが効率的かを評価します。この理論に基づくと、外部と内部のコストの差によって、企業は自らの境界を決定し、どの活動を内部で行い、どの活動を外部に委託するかを判断します。

ソフトウェア開発でも同様で、チームメンバーで作ったら2ヶ月、すでに作ったことがある人がやったら2週間みたいな機能の実装者は外部調達したくなる。外部調達の方法は様々だが、適切な役員がいない会社ほど外部調達コストがあがる。チームの組成能力がたかい人は、そういうときにright personを引っ張ってこれるからな。right personは手を動かさなくてもよくて、pitfallを教えてくれるだけで実装コストは半分になるだろう。

ジョブマーケットがもうちょっと機能したら、お金を出したらright personを調達コスト低く引っ張ってこれるようになるんだろうか。半たんにセキュリティや内部統制の基準がどんどんあがるから、なかなかそうはならない気がするが。AI Agentはその辺をうまくやってくれるかもしれない。

## 2024-06-13 - swiftのactorについて

[competition](https://ai.google.dev/competition) に応募するためにiphone appを作っているんだが、swiftの [actor](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency#Actors) はすごいな。

classの代わりにactorという識別子で以下を宣言すると、メンバー変数へのwriteが必ずatomicになる。さらに１度measurementsをreadしてからmaxをwriteするようなコードも途中でawaitしなければatomicになる。これはすごい。

ここでcontext switchが入って変数の値がぶっ壊れてたらどうしようとか悩まずに、synchronousなコードと同じように書けるのはすごいな。今まで他の言語ではmessage passingっぽい方法を導入してconcurrentなコードをかいていたがそれもいらない。

```swift
actor TemperatureLogger {
    let label: String
    var measurements: [Int]
    private(set) var max: Int

    init(label: String, measurement: Int) {
        self.label = label
        self.measurements = [measurement]
        self.max = measurement
    }
}
```

## 2024-06-12 - 業務委託先の探し方

もう一つ業務委託をふやしたいのとマージン払うのが面倒なので、簡単なツールを作ってみた。フローは以下な感じ。

- 主要なATSの求人ページを以下のようなsite指定で検索する。
- 検索結果をplaywrightでスクレイピングし簡単に正規化する。
	- ["site:https://herp.careers/v1/ 業務委託 ソフトウェア"](https://www.google.co.jp/search?q=site%3Ahttps%3A%2F%2Fherp.careers%2Fv1%2F+%E6%A5%AD%E5%8B%99%E5%A7%94%E8%A8%97+%E3%82%BD%E3%83%95%E3%83%88%E3%82%A6%E3%82%A7%E3%82%A2&hl=ja&lr=lang_ja)
	- ["site:https://hrmos.co/pages/ 業務委託 ソフトウェア"](https://www.google.co.jp/search?q=site%3Ahttps%3A%2F%2Fhrmos.co%2Fpages%2F+%E6%A5%AD%E5%8B%99%E5%A7%94%E8%A8%97+%E3%82%BD%E3%83%95%E3%83%88%E3%82%A6%E3%82%A7%E3%82%A2)
	- ["site:https://open.talentio.com/ 業務委託 ソフトウェア"](https://www.google.co.jp/search?q=site%3Ahttps%3A%2F%2Fopen.talentio.com%2F+%E6%A5%AD%E5%8B%99%E5%A7%94%E8%A8%97+%E3%82%BD%E3%83%95%E3%83%88%E3%82%A6%E3%82%A7%E3%82%A2)
- 最後にLLMをかます

別の立場になると、求人ページにちゃんと詳細な給料が書いてあるのがいかに大事かがわかる。応相談は単純にめんどくさい。正社員の場合はエモがものすごい大事だが、業務委託の場合は傭兵として扱ってほしい。

B向けのAI Agentばかりを思考してきたが、C向けのエージェントもわんちゃんある気がするな。あとどうでもいいがHERPさんとHRMOSさんは本業のお客さんなので、talentioを蹴散らしてもっと伸びてほしい。

## 2024-06-12 - CVEの発行

業務委託先でOSSのやばめの脆弱性を見つけたので連絡してもらった。結果的にCVEは発行しないらしい。ユーザーには個別に連絡するそうだ。

微妙かと思ったが一周回っていい気がしてきた。超エンプラ向けのソフトウェアなので使用者が限られているし。まあデカくなると漏れなく通知するのは無理だろうな。

## 2024-06-11 - 事業をやるタイミング

休み時間中の雑談で社長に「なぜリクルートがスキマバイトの領域を取れなかったのか」とシンプルな投げかけをしたら、リクルートは https://shotworks.jp/ というサービスで参入していたが時期を誤って一回失敗したらしい。タイミーの話を聞いたときもショットワークスじゃんって思ったらしい。

身をもって感じているがタイミングというのは本当に大事。まあタイミングにはいろいろな変数が次元圧縮されていて、それを分解できる能力をもっているか、常に現場に出て空気で掴むか、そのへんが大事なのかな。あと金があれば沖にいて待つか。

## 2024-06-11 - 最近のフリーランス事情

最近は夜間土日は否の仕事が増えているらしい。企業側がコミュニケーションコストの観点で同期的に作業できることを期待している。

あと、権限の問題でSREの仕事は少ないらしい。正直、適切にdevとprodでアカウントを分けているなら、あまり権限の問題は起こらないと思うんだが。あと、6000円/hの案件がボリューム的に1番多いらしい。エージェントを通すとマージンは多分20%ぐらいだろうな。

## 2024-06-10 - マネーフォワード ビジネスカードを契約してみる

個人事業主の経費を計算することがめんどくさいので契約してみる。すべて経費になるものはビジネスカードで決済するのがいいんだが、家事按分する必要がある勘定科目の場合はどっちのカードで決済するのがいいんだろうか。

応募したらすぐに審査が通った。デフォルトで枠がかなりでかいな。

## 2024-06-10 - Appleのクリップボードの共有について

macとiphoneでクリップボードをshareしたい。[102430](https://support.apple.com/ja-jp/102430) によると、ちゃんとやるにはApple IDをmacとiphoneで同じにしないといけないらしい。基本仕事用とプライベートでアカウントわけているのでむりだな。

共有したいのはだいたいcredential系の一時データなんだが、ベストな方法がわからないな。googleのpassword managerか、appleが新しく出すやつを必ず通したほうがいいのかもしれない。yubikeyの空いているslotに一時的に書き込んで、iphoneにNFT経由で送るとか簡単にできたら最高だが。耐タンパ性のないslotとかなさそうだな。

## 2024-06-10 - メモ書きをはじめてみた

何年ぶりかわからないがObsidianを使って始めてみる。そろそろ認知が落ちてくるだろうから書くことを目的にはじめる。

本当はメンテとかめんどいのでXでやりたいが、XがAPI経由での自分のtweetの取得にお金がかかるのでしょうがない。iphoneとたまにmacで気軽にかけて、かつデータがexportできて検索できれば何でもいいんだが。
