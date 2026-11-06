# 法政大学 卒業論文・修士論文 LaTeX テンプレート

知能システム研究室（理工学部 経営システム工学科 / 大学院理工学研究科）

| 版 | フォルダ | 主な対象 | クラスオプション |
|---|---|---|---|
| 日本語版 | `ja/` | 卒業論文（学部） | `\documentclass[ja,bachelor]{hosei-thesis}` |
| 英語版 | `en/` | 修士論文（英語で執筆） | `\documentclass[en,master]{hosei-thesis}` |

言語（`ja` / `en`）と学位（`bachelor` / `master`）は独立したオプションなので，英語で書く学部生や日本語で書く修士学生にもそのまま対応できます．
学生向けの使い方は `ja/README.md`・`en/README.md` にあります．
`ja/`・`en/` は書き方と組版の**例付き版**です．章立てと必要なコメントだけの**起稿用**は `starter/ja/`・`starter/en/` にあり，それぞれ単独で利用できます．

## 使い方

- **知能システム研究室の学生**：指導教員が Overleaf のプロジェクトを用意して招待します．書き方は各フォルダの `README.md` を見てください．
- **それ以外の方**：[Releases](https://github.com/zi-ang-liu/hosei-thesis-template/releases/latest) から zip とサンプル PDF をダウンロードできます．
  zip は例付き版（`hosei-thesis-ja.zip`・`hosei-thesis-en.zip`）と起稿用（`*-starter.zip`）があり，
  Overleaf の New Project → Upload Project でそのままアップロードし，Compiler を **LuaLaTeX** にすれば使えます．
  Overleaf の無料プランはコンパイル時間の上限が 10 秒のため，タイムアウトすることがあります．その場合は手元の TeX Live でコンパイルしてください．

**English.** A LuaLaTeX template for bachelor's and master's theses at Hosei University, with Japanese and English versions.
Download the zip files and sample PDFs from [Releases](https://github.com/zi-ang-liu/hosei-thesis-template/releases/latest), and see [`en/README.md`](en/README.md) for usage.

## フォルダ構成

```
hosei-thesis-template/
├── LICENSE            ← MIT License
├── hosei-thesis.cls   ← クラスファイルの原本（編集はここだけ）
├── latexmkrc          ← ビルド設定の原本（LuaLaTeX + upBibTeX）
├── Makefile           ← ビルド・配布用
├── figure-sources/    ← サンプル図（数値実験の結果のグラフ）のソース（make figures）
├── ja/                ← 日本語版（そのまま Overleaf にアップロードできる単位）
│   ├── main.tex
│   ├── chapters/      ← 1 章 1 ファイル
│   ├── figures/
│   ├── references.bib
│   ├── README.md      ← 学生向けの使い方
│   └── hosei-thesis.cls, latexmkrc   ← 原本のコピー（make sync で更新）
├── en/                ← 英語版（構成は ja/ と同じ）
└── starter/
    ├── ja/            ← 日本語の起稿用（main.tex・chapters/・空の文献データベースなど）
    └── en/            ← 英語の起稿用（同上）
```

## 設計方針

- **複雑さは `hosei-thesis.cls` に集約**し，学生は `main.tex` と `chapters/` だけを編集する．
- **日本語版は jlreq**（「日本語組版処理の要件」準拠．40 字 × 36 行），**英語版は report**．どちらも LuaLaTeX．
  余白は左 30 mm・右約 25 mm・上 30 mm．英語版は 1.5 行送り．
- **参考文献は natbib + upBibTeX + junsrt**．日本語文献も `@article` などで書け，巻・号・ページが正しく出る．
  upBibTeX の指定は `latexmkrc` で行う（Overleaf も `latexmkrc` を読む）．
- **相互参照は `\cref`**．言語に応じて「図4.1」「Figure 4.1」などを自動で付ける．
- 図表・数式・アルゴリズム（algorithm2e）・ソースコード（listings）・TikZ のパッケージはクラスで読み込み済み．
- **図表の配置**：本文で書いた位置より前（同じページの上）に置かない（flafter），節をまたいで後ろの節に流さない（`\section` ごとに `\FloatBarrier`），
  図表だけのページは上に詰める．1 ページに置ける図表の量の上限は標準より緩めている．
- **表紙**は理工学研究科「修士論文の提出について」（資料3）の記載事項（年度・論文種別，論文題名，指導教員，所属，学生証番号，フリガナ，氏名）をすべて含む．
  配置は見本の位置にはこだわらず，上段に所属と年度・種別，中段に題目（罫線で囲む），下段に氏名（フリガナは氏名の上）・学生証番号・指導教員を同じ行送りで並べた．学部も同じ形式．ラベルは英語版でも日本語．
- **本文の構成**は「はじめに・準備・関連研究・提案手法・数値実験・結論」の 6 章と研究業績．
  既存の知識（準備）と自分の提案（提案手法）を章で分け，準備（定義）→ 関連研究（既存研究の課題）→ 提案手法 の順にする．
- **サンプルの内容は分野に依存しない骨組み**：各節に「何を書くか」の説明と「○○」「……」の空欄を置き，
  LaTeX の使用例（定式化・アルゴリズム・TikZ の図・表・実験結果のグラフ・ソースコード）は，
  経営システム工学科の学生なら誰でも知っている 0-1 ナップサック問題と貪欲法を題材にした．
- **執筆ガイドと論文本文を区別**：表示する指導文は `writingnote` 環境にまとめ，提出時に削除する旨を見出しに示す．実験の数値は架空であることを章の冒頭と図表のキャプションに明記する．
- **起稿用**には章・節・ラベルとコメントを残し，説明文・例の文章・架空データを入れない．参考文献は自分で登録し，最初の引用を追加してから `\bibliography{references}` を有効にする．
- **参考文献の例**は形式ごとに 1 つずつ（英語・日本語の書籍，論文誌，国際会議，Web ページ）．すべて実在の文献で，
  本文中で引用している（junsrt は引用した文献だけを載せるため）．論文の書き方の参考書（日本語版は木下・酒井，英語版は Zobel と Glasman-Deal，および Web 版の Academic Phrasebank）も含めた．
- **英語の修士論文には Abstract と要旨の両方**を入れる（研究室の決まり）．
- **添削モード（`review` オプション）**：行番号，`\TODO{…}`（赤字），`\rev{…}`（青字），各ページ右上の「添削用」と日付．
- `main.tex` に `\fiscalyear{2026}` を明記する．学生は自分の提出年度に変更し，定稿時に固定する．指定を省いた場合のみ，コンパイル日から年度を自動計算する（4 月〜翌年 3 月）．
- 所属の既定値：学部「法政大学 理工学部／経営システム工学科」，修士「法政大学大学院 理工学研究科／システム理工学専攻 経営システム系 修士課程」．
  `\affiliation{1行目}{2行目}` で変更できる．表紙では，続けて版面の幅の 8 割以内に収まれば 1 行（学部の既定値），収まらなければ 2 行（修士の既定値）で表示する．

## メンテナンス

- 共通設定を変更するときはルートの `hosei-thesis.cls` と `latexmkrc` を編集する．例付き版と起稿用のコピーは `make sync` で更新される（`make` でも自動で実行）．
- 変更したら，`make`（通常版）と `make review`（添削モード）の両方がエラー・警告なしで通ることを確認する．
- クラスを更新したら，`\ProvidesClass` の日付と版番号を上げ，下の「更新履歴」に書く．

```sh
make          # 例付き版と起稿用の日英 PDF を作る
make starter  # 起稿用の日英 PDF だけを作る
make review   # 例付き版と起稿用の添削モード PDF を作る
make dist     # dist/ に配布用 zip とサンプル PDF を作る
make figures  # figure-sources/ からサンプル図を作り直し，ja/figures と en/figures に置く
make clean    # 生成物を削除する
```

- サンプル図（数値実験の結果のグラフ 2 枚）は pgfplots で描いたベクター形式の PDF で，
  日本語版と英語版でラベルの言語だけが異なる．値は式で作った架空のデータで，本文の表 5.2（$n = 1000$）と一致させている．

## 配布

### Overleaf

1. `make dist` で `dist/hosei-thesis-ja.zip` と `dist/hosei-thesis-en.zip` を作る．
   起稿用の `dist/hosei-thesis-ja-starter.zip` と `dist/hosei-thesis-en-starter.zip` も同時に作られる．
2. Overleaf で New Project → Upload Project から zip をアップロードする（`main.tex` が自動でメイン文書になる）．
3. Menu → Settings で Compiler を **LuaLaTeX** にし，TeX Live version は最新にする．
4. 研究室の学生には，このプロジェクトを Copy（Menu → Copy Project）して学生ごとのプロジェクトを作り，Share から学生を編集者として招待する．
   コンパイル時間の上限はプロジェクトの所有者のプランで決まる（無料プラン 10 秒，有料プラン 4 分）ため，無料プランの学生が自分で Copy するとタイムアウトしやすい．
5. 閲覧用リンク（Share → Link sharing）は，研究室サイト（isl-seminar リポジトリの `guide/new.qmd` の「テンプレート」）に載せてもよい．
6. 更新するときは，同じプロジェクトにファイルを上書きアップロードする（リンクが変わらない）．

### GitHub

- リポジトリ：<https://github.com/zi-ang-liu/hosei-thesis-template>（公開）
- 版を上げたら，`make dist` の後で Release を作り，`dist/` の zip とサンプル PDF（`hosei-thesis-*-sample.pdf`）を添付する．

  ```sh
  gh release create vX.Y.Z dist/*.zip dist/*-sample.pdf --title "vX.Y.Z" --notes "（更新履歴の内容）"
  ```

- `dist/` は `.gitignore` に入れてある．

## 公式の規定（理工学研究科・2025 年 10 月の資料）

**修士論文（資料3）**

- 提出は PDF．ファイル名は「学生証番号氏名.pdf」（スペースなし．例：`24R0000法政太郎.pdf`）．
- Acrobat 5.0 以上で読めること，LaTeX の場合はフォントを埋め込むこと．
  → LuaLaTeX はすべてのフォントを埋め込む．出力は PDF 1.7（Acrobat 8 以降で開ける）．
- 20 MB 以下．和文または欧文（英文・仏文・独文）．
- 表紙の記載事項：「○○年度修士論文」，論文題名，指導教員，所属，学生証番号，氏名，フリガナ．

**論文要旨（資料4）**

- 修士論文とは別の提出物．2 頁以上 8 頁以内，2 MB 以内．Hoppii の「論文要旨の書き方」と Word 様式に従う．
- このテンプレートでは未対応（今後の予定を参照）．

## 今後の予定

- 同じクラスのオプションとして，卒研発表会の予稿・梗概と修士論文要旨（資料4）の様式を追加する．

## ライセンス

[MIT License](LICENSE)．このテンプレートを使って書いた論文（PDF）に，ライセンスの表示は不要です．

## 更新履歴

- **v2.2.0（2026-11-05）** 要旨と全章の執筆ガイドを追加・改訂した（Glasman-Deal の書籍と Academic Phrasebank を参考にし，英語版では両者を参考文献に加えた）．
  要旨のファイルに，研究科に提出する「論文要旨」（資料4）が別の書類であることを注記．`writingnote` の 1 行目の先頭に空白が入る不具合を修正．
  独立したリポジトリ（GitHub で公開，MIT License）に移行し，Overleaf の使い方（研究室の学生は指導教員が用意したプロジェクトを使う）を README に追記．
- **v2.1.0（2026-11-04）** 架空データを PDF 上にも明記し，執筆ガイドを本文と区別した．日英の起稿用を追加．性能の優位性を前提としない文例に改め，実験設計のコメント，提出年度の固定，全著者を保存する文献管理方針を追加した．
- **v2.0.0（2026-11-04）** 全面改訂．共通クラス `hosei-thesis.cls` に移行し，日本語版（jlreq）と英語版（report）を用意．
  upBibTeX + junsrt で日本語文献に対応，`\cref` による相互参照，研究科の記載事項を満たす表紙，添削モード，TikZ を追加．
  本文を 6 章構成（準備と提案手法を分離）にして研究業績を加え，サンプルを分野に依存しない骨組みと 0-1 ナップサック問題の使用例にした．
  付録の番号付け，目次の参考文献ページと字下げ，アルゴリズム・コードの見出しの日本語化，図表の配置などの不具合を修正．
- **v1（2025-06-19）** 初版（劉 子昂）．
