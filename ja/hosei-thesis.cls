%% =====================================================================
%%  hosei-thesis.cls
%%  法政大学 卒業論文・修士論文 LaTeX クラス
%%  理工学部 経営システム工学科 / 大学院理工学研究科  知能システム研究室
%%  https://github.com/zi-ang-liu/hosei-thesis-template
%%  Copyright (c) 2025-2026 Ziang Liu.  MIT License（リポジトリの LICENSE を参照）
%% ---------------------------------------------------------------------
%%  学生の皆さんへ : このファイルは編集しないでください．
%%                   設定はすべて main.tex で行います．
%%  メンテナ向け   : 原本はリポジトリのルートにある hosei-thesis.cls．
%%                   ja/ と en/ にあるのはコピーです（make sync で更新）．
%% ---------------------------------------------------------------------
%%  オプション
%%    ja（既定） / en           本文の言語（日本語 / 英語）
%%    bachelor（既定） / master  卒業論文 / 修士論文
%%    review                    添削用（行番号・TODO・修正箇所の色付けを表示）
%%  エンジン : LuaLaTeX のみ（参考文献は upBibTeX + junsrt）
%% =====================================================================
\NeedsTeXFormat{LaTeX2e}[2022/06/01]
\ProvidesClass{hosei-thesis}[2026/11/05 v2.2.0 Hosei University thesis class (ISL)]

%% ---------------------------------------------------------------------
%%  エンジンの確認（pdfLaTeX などでは分かりやすいエラーを出して止める）
%% ---------------------------------------------------------------------
\RequirePackage{iftex}
\ifluatex\else
  \ClassError{hosei-thesis}
    {This template must be compiled with LuaLaTeX}
    {Overleaf: Menu -> Settings -> Compiler -> LuaLaTeX.\MessageBreak
     Local: run latexmk (latexmkrc selects LuaLaTeX).}
  \expandafter\stop
\fi

% 無害だが学生を不安にさせる警告を出さない
% （LuaTeX-ja のフォント関係のメッセージは下の \hosei@quietfonts で抑える）
\RequirePackage{silence}
\WarningFilter{caption}{Unknown document class}
\WarningFilter{relsize}{Failed to get list of defined font sizes}
\WarningFilter{luatexja}{LuaTeX-ja's patch against the microtype}

%% ---------------------------------------------------------------------
%%  オプション
%% ---------------------------------------------------------------------
\newif\ifhosei@en
\newif\ifhosei@master
\newif\ifhosei@review
\newif\ifhosei@inappendix
\DeclareOption{ja}{\hosei@enfalse}
\DeclareOption{en}{\hosei@entrue}
\DeclareOption{bachelor}{\hosei@masterfalse}
\DeclareOption{master}{\hosei@mastertrue}
\DeclareOption{review}{\hosei@reviewtrue}
\DeclareOption{final}{\hosei@reviewfalse}
\DeclareOption*{%
  \ClassWarningNoLine{hosei-thesis}{Unknown option `\CurrentOption' is ignored}}
\ProcessOptions\relax

%% ---------------------------------------------------------------------
%%  基本クラス・版面・フォント
%%   日本語版 : jlreq（日本語組版処理の要件に準拠）  40字 × 36行
%%   英語版   : report + LuaTeX-ja（表紙・要旨の日本語用）
%%   余白はどちらも 左 30mm・右 約25mm・上 30mm
%% ---------------------------------------------------------------------
% フォント設定時に出る情報メッセージを抑える（設定後に元に戻す）
\ExplSyntaxOn
\cs_new_protected:Npn \hosei@quietfonts:n #1
  {
    \msg_redirect_name:nnn { luatexja-preset } { scale } { #1 }
    \msg_redirect_name:nnn { luatexja-fontspec } { addjfontfeatures-ignored } { #1 }
  }
\cs_new_eq:NN \hosei@quietfonts \hosei@quietfonts:n
\ExplSyntaxOff
\hosei@quietfonts{none}
\ifhosei@en
  \LoadClass[a4paper,11pt,oneside]{report}
  \RequirePackage{luatexja}
  \RequirePackage[haranoaji,deluxe]{luatexja-preset}
  % 英文中の “ ” ‘ ’ – — … † • などを欧文フォントで組む
  % （範囲 9 のみ．○ △ □ などは欧文フォントにないので和文フォントのまま）
  \ltjsetparameter{jacharrange={-9}}
  \RequirePackage[a4paper,left=30mm,right=25mm,top=30mm,bottom=30mm,
    headheight=15pt]{geometry}
  \RequirePackage{setspace}
  \onehalfspacing
  \RequirePackage{microtype}
\else
  \LoadClass[report,paper=a4,fontsize=11pt,line_length=40zw,%
    number_of_lines=36,gutter=30mm,head_space=30mm]{jlreq}
  \RequirePackage[haranoaji,deluxe,jfm_yoko=jlreq,jfm_tate=jlreqv]{luatexja-preset}
\fi
\hosei@quietfonts{}

%% ---------------------------------------------------------------------
%%  よく使うパッケージ（学生が追加で読み込む必要がないように一通り用意）
%% ---------------------------------------------------------------------
\RequirePackage{amsmath,amssymb,mathtools,bm}
\RequirePackage{graphicx}
\graphicspath{{figures/}}
\RequirePackage{xcolor}
\RequirePackage{tikz}
\usetikzlibrary{arrows.meta,positioning}
\RequirePackage{booktabs,multirow,array,tabularx}
\RequirePackage{float}
\RequirePackage{flafter}% 図表を，本文で書いた位置より前（同じページの上）に置かない
\RequirePackage[below]{placeins}% \FloatBarrier（下の「図表の配置」で使う．ページ下端の図表は待たせない）
\RequirePackage{caption,subcaption}
\RequirePackage{listings}
\RequirePackage[linesnumbered,ruled,vlined,algochapter]{algorithm2e}
\RequirePackage[numbers,sort&compress]{natbib}
\RequirePackage{xurl}
\ifhosei@review
  \RequirePackage[mathlines]{lineno}
\fi
\ifhosei@en
  \RequirePackage{titlesec}
  \RequirePackage{fancyhdr}
  \RequirePackage{enumitem}
  \RequirePackage[bottom]{footmisc}% 脚注をページ下端の図表より下に置く
\fi
\RequirePackage{hyperref}
\RequirePackage[capitalise,noabbrev,nameinlink]{cleveref}

\DeclareMathOperator*{\argmax}{arg\,max}
\DeclareMathOperator*{\argmin}{arg\,min}

%% ---------------------------------------------------------------------
%%  色・リンク
%% ---------------------------------------------------------------------
\definecolor{hosei@navy}{RGB}{0,51,102}
\hypersetup{
  colorlinks=true,
  linkcolor=hosei@navy, citecolor=hosei@navy,
  urlcolor=hosei@navy, filecolor=hosei@navy,
  bookmarksnumbered=true, bookmarksopen=true, bookmarksopenlevel=1,
  pdfdisplaydoctitle=true,
}

%% ---------------------------------------------------------------------
%%  言語ごとの名称
%% ---------------------------------------------------------------------
\ifhosei@en
  \renewcommand\bibname{References}
  \renewcommand\appendixname{Appendix}
  \newcommand\hosei@ackname{Acknowledgments}
  \newcommand\hosei@pubname{List of Publications}
\else
  \def\bibname{参考文献}% natbib が英語で定義しているので上書き
  \def\appendixname{付録}
  \newcommand\hosei@ackname{謝辞}
  \newcommand\hosei@pubname{研究業績}
  \renewcommand\lstlistingname{コード}
  \renewcommand\lstlistlistingname{コード一覧}
  \SetAlgorithmName{アルゴリズム}{アルゴリズム}{アルゴリズム一覧}
  \SetKwInput{KwIn}{入力}
  \SetKwInput{KwOut}{出力}
  % キャプションを「アルゴリズム1.1　二分法」の形にする（「:」を全角空白に）
  \renewcommand{\algocf@captiontext}[2]{%
    \algocf@captionlayout{\AlCapSty{\AlCapFnt #1\algocf@typo}\hspace{1\zw}%
      \AlCapNameSty{\AlCapNameFnt{}#2\endgraf}}}
\fi

%% ---------------------------------------------------------------------
%%  見出し（英語版．日本語版は jlreq の既定を使う）
%% ---------------------------------------------------------------------
\ifhosei@en
  \titleformat{\chapter}[display]
    {\normalfont\sffamily\bfseries\raggedright}
    {\Large\chaptertitlename\ \thechapter}{0.6\baselineskip}{\huge}
  \titlespacing*{\chapter}{0pt}{0pt}{2\baselineskip}
  \titleformat{\section}
    {\normalfont\sffamily\bfseries\Large}{\thesection}{1em}{}
  \titleformat{\subsection}
    {\normalfont\sffamily\bfseries\large}{\thesubsection}{1em}{}
  \titleformat{\subsubsection}
    {\normalfont\sffamily\bfseries\normalsize}{\thesubsubsection}{1em}{}
  \titleformat{\paragraph}[runin]
    {\normalfont\sffamily\bfseries}{\theparagraph}{1em}{}
  \setlist{itemsep=0.2\baselineskip,topsep=0.4\baselineskip}
  \widowpenalty=10000
  \clubpenalty=10000
\else
  % 目次：章の行を太字（ゴシック）にし，前を少しあける．
  % jlreq は最初の項目のレベルを字下げの基準として（ローカルに）記録するので，
  % フォント変更のグループに入る前に章のレベル（0）で記録しておく．
  \let\hosei@l@chapter\l@chapter
  \renewcommand*\l@chapter[2]{%
    \ifnum\c@tocdepth>\m@ne
      \addpenalty{-\@highpenalty}%
      \vskip 0.5\baselineskip\@plus\p@
      \jlreq@set@top@contents{0}%
      {\sffamily\gtfamily\bfseries\hosei@l@chapter{#1}{#2}}%
    \fi}
\fi

%% ---------------------------------------------------------------------
%%  ページスタイル
%%   前付け : ページ番号のみ（i, ii, ...）
%%   本文   : 柱（章名）＋ページ番号．章の最初のページはページ番号のみ
%% ---------------------------------------------------------------------
\ifhosei@en
  \fancypagestyle{plain}{%
    \fancyhf{}\fancyfoot[C]{\thepage}%
    \renewcommand\headrulewidth{0pt}\renewcommand\footrulewidth{0pt}}
  \fancypagestyle{hosei}{%
    \fancyhf{}%
    \fancyhead[R]{\small\sffamily\leftmark}%
    \fancyfoot[C]{\thepage}%
    \renewcommand\headrulewidth{0.4pt}\renewcommand\footrulewidth{0pt}%
    \renewcommand\chaptermark[1]{%
      \markboth{\ifnum\c@secnumdepth>\m@ne\@chapapp\ \thechapter\quad\fi##1}{}}%
    \renewcommand\sectionmark[1]{}}
\else
  \newcommand\hosei@chapterlabel{%
    \ifhosei@inappendix\appendixname\thechapter\else 第\thechapter 章\fi}
  \NewPageStyle{hosei}{%
    yoko,
    running_head_position=top-right,
    nombre_position=bottom-center,
    running_head_font=\small\sffamily\gtfamily,
    odd_running_head=_chapter,
    mark_format={_chapter={\hosei@chapterlabel\hspace{1\zw}#1}},
    odd_head_format={\underline{\makebox[\jlreqyokoheadlength]{#1}}},
  }
  % 章の最初のページでは，図表が見出しより上に来ないようにする（report と同じ動作）．
  % jlreq の改ページを止め，\clearpage の直後に \@topnum を 0 にしてから見出しを出す．
  % \appendix で \chapter が作り直されるので，そのときにも再設定する（下の \appendix）．
  \ModifyHeading{chapter}{pagestyle=plain,pagebreak=nariyuki}
  \newcommand\hosei@wrapchapter{%
    \def\chapter{\clearpage\global\@topnum\z@\jlreq@headingcs@chapter}}
  \hosei@wrapchapter
\fi

%% ---------------------------------------------------------------------
%%  図表・キャプション
%%   日本語版 : 「図3.1　キャプション」   英語版 : 「Figure 3.1: Caption」
%% ---------------------------------------------------------------------
\captionsetup{font=small,labelfont=bf}
\ifhosei@en
  \captionsetup{labelsep=colon}
\else
  \DeclareCaptionLabelFormat{hosei-ja}{#1#2}
  \DeclareCaptionLabelSeparator{hosei-zw}{\hspace{1\zw}}
  \captionsetup{labelformat=hosei-ja,labelsep=hosei-zw}
\fi
\captionsetup[table]{position=top}
\captionsetup[sub]{labelformat=simple,labelsep=space}

% 図表の配置
%  ・節（\section）をまたいで図表が後ろの節に流れないようにする
%    （jlreq・titlesec の両方で効くように \begin{document} の時点で包む）
%  ・図表だけのページでは，図表を上に詰めて置く（既定は上下中央）
%  ・図表が本文の近くに置かれやすいように，1 ページに置ける図表の量を増やす
\AtBeginDocument{%
  \let\hosei@orig@section\section
  \renewcommand\section{\FloatBarrier\hosei@orig@section}}
\setlength{\@fptop}{0pt}
\setlength{\@fpsep}{\floatsep}
\setlength{\@fpbot}{0pt plus 1fil}
\renewcommand{\topfraction}{0.85}
\renewcommand{\bottomfraction}{0.7}
\renewcommand{\textfraction}{0.15}
\renewcommand{\floatpagefraction}{0.7}
\setcounter{topnumber}{3}
\setcounter{bottomnumber}{2}
\setcounter{totalnumber}{4}
\renewcommand\thesubfigure{(\alph{subfigure})}
\renewcommand\thesubtable{(\alph{subtable})}

%% ---------------------------------------------------------------------
%%  ソースコード（listings）
%% ---------------------------------------------------------------------
\lstset{
  basicstyle=\ttfamily\small,
  columns=fullflexible, keepspaces=true,
  keywordstyle=\color[RGB]{0,82,155},
  commentstyle=\color[RGB]{80,110,80}\itshape,
  stringstyle=\color[RGB]{163,21,21},
  numbers=left, numberstyle=\tiny\color{gray}, numbersep=1em,
  xleftmargin=2.5em, framexleftmargin=2em,
  frame=tb, framerule=0.4pt, rulecolor=\color{gray!60},
  backgroundcolor=\color{gray!6},
  breaklines=true, showstringspaces=false, tabsize=4, upquote=true,
  captionpos=t,
}

%% ---------------------------------------------------------------------
%%  相互参照（\cref）
%%   日本語版 : 第3章，3.1節，図3.1，表3.1，式(3.1)，アルゴリズム3.1，付録A
%%   英語版   : Chapter 3, Section 3.1, Figure 3.1, Eq. (3.1), Appendix A
%% ---------------------------------------------------------------------
\ifhosei@en
  \crefname{equation}{Eq.}{Eqs.}
  \Crefname{equation}{Eq.}{Eqs.}
  \crefname{algorithm}{Algorithm}{Algorithms}
  \Crefname{algorithm}{Algorithm}{Algorithms}
  \crefname{listing}{Listing}{Listings}
  \Crefname{listing}{Listing}{Listings}
  \crefname{subfigure}{Figure}{Figures}
  \Crefname{subfigure}{Figure}{Figures}
  \crefname{subtable}{Table}{Tables}
  \Crefname{subtable}{Table}{Tables}
\else
  % \hosei@jacref{種類}{前に付ける語}{後に付ける語}
  \def\hosei@jacref#1#2#3{%
    \crefformat{#1}{##2#2##1#3##3}%
    \Crefformat{#1}{##2#2##1#3##3}%
    \crefrangeformat{#1}{##3#2##1#3##4〜##5#2##2#3##6}%
    \Crefrangeformat{#1}{##3#2##1#3##4〜##5#2##2#3##6}%
    \crefmultiformat{#1}{##2#2##1#3##3}%
      {と##2#2##1#3##3}{，##2#2##1#3##3}{，##2#2##1#3##3}%
    \Crefmultiformat{#1}{##2#2##1#3##3}%
      {と##2#2##1#3##3}{，##2#2##1#3##3}{，##2#2##1#3##3}%
    \crefname{#1}{#2}{#2}\Crefname{#1}{#2}{#2}}
  \hosei@jacref{chapter}{第}{章}
  \hosei@jacref{appendix}{付録}{}
  \hosei@jacref{section}{}{節}
  \hosei@jacref{subsection}{}{節}
  \hosei@jacref{subsubsection}{}{節}
  \hosei@jacref{figure}{図}{}
  \hosei@jacref{subfigure}{図}{}
  \hosei@jacref{table}{表}{}
  \hosei@jacref{subtable}{表}{}
  \hosei@jacref{equation}{式(}{)}
  \hosei@jacref{algorithm}{アルゴリズム}{}
  \hosei@jacref{listing}{コード}{}
  \hosei@jacref{footnote}{脚注}{}
\fi

%% ---------------------------------------------------------------------
%%  参考文献（natbib + junsrt．文献スタイルはここで指定済み）
%% ---------------------------------------------------------------------
\let\hosei@orig@bibliographystyle\bibliographystyle
\def\hosei@bibstyle{junsrt}
% main.tex で \bibliographystyle を書いても二重指定にならないようにする
\renewcommand\bibliographystyle[1]{\gdef\hosei@bibstyle{#1}}
\AtBeginDocument{\hosei@orig@bibliographystyle{\hosei@bibstyle}}
\renewcommand\bibsection{\hosei@unnumberedchapter{\bibname}}
\ifhosei@en\else
  % jlreq では \labelsep が 0 なので，番号「[1]」と本文の間を全角1文字あける
  \let\hosei@NAT@bibsetnum\NAT@bibsetnum
  \renewcommand\NAT@bibsetnum[1]{\setlength\labelsep{1\zw}\hosei@NAT@bibsetnum{#1}}
\fi

%% ---------------------------------------------------------------------
%%  論文情報（main.tex で設定する）
%% ---------------------------------------------------------------------
\def\hosei@titleJA{}
\def\hosei@titleEN{}
\def\hosei@authorkana{}
\def\hosei@studentid{}
\def\hosei@supervisor{}
% 年度：4月〜翌年3月（例：2027年2月の提出なら 2026年度）
\edef\hosei@fiscalyear{\the\numexpr\year-\ifnum\month<4 1\else 0\fi\relax}
\ifhosei@master
  \def\hosei@thesistype{修士論文}
  \def\hosei@affiliationi{法政大学大学院 理工学研究科}
  \def\hosei@affiliationii{システム理工学専攻 経営システム系 修士課程}
\else
  \def\hosei@thesistype{卒業論文}
  \def\hosei@affiliationi{法政大学 理工学部}
  \def\hosei@affiliationii{経営システム工学科}
\fi
\newcommand*\titleJA[1]{\gdef\hosei@titleJA{#1}}
\newcommand*\titleEN[1]{\gdef\hosei@titleEN{#1}}
\newcommand*\authorkana[1]{\gdef\hosei@authorkana{#1}}
\newcommand*\studentid[1]{\gdef\hosei@studentid{#1}}
\newcommand*\supervisor[1]{\gdef\hosei@supervisor{#1}}
\newcommand*\fiscalyear[1]{\gdef\hosei@fiscalyear{#1}}
\newcommand*\affiliation[2]{\gdef\hosei@affiliationi{#1}\gdef\hosei@affiliationii{#2}}
% \title も使えるようにしておく（本文の言語の題目になる）
\renewcommand*\title[1]{\ifhosei@en\titleEN{#1}\else\titleJA{#1}\fi}

% 本文の言語の題目（\hosei@maintitle）ともう一方の言語の題目（\hosei@subtitle）
\AtBeginDocument{%
  \ifhosei@en
    \let\hosei@maintitle\hosei@titleEN \let\hosei@subtitle\hosei@titleJA
  \else
    \let\hosei@maintitle\hosei@titleJA \let\hosei@subtitle\hosei@titleEN
  \fi
  \hypersetup{pdftitle={\hosei@maintitle},pdfauthor={\@author},
    pdfsubject={\hosei@fiscalyear 年度\hosei@thesistype}}}
% PDF の文書情報では，題目中の \\ を英語では空白に，日本語では何もなしにする
\ifhosei@en
  \pdfstringdefDisableCommands{\def\\{ }\let\TODO\@gobble\let\rev\@firstofone}
\else
  \pdfstringdefDisableCommands{\def\\{}\let\TODO\@gobble\let\rev\@firstofone}
\fi

%% ---------------------------------------------------------------------
%%  表紙（\maketitle）
%%   「修士論文の提出について」（理工学研究科）の記載事項をすべて含む：
%%   年度・論文種別，論文題名，指導教員，所属，学生証番号，フリガナ，氏名．
%%   配置は見やすさを優先し，上段に年度と種別，中段に題目，
%%   下段に所属・学生・指導教員をまとめた．
%% ---------------------------------------------------------------------
\newcommand\hosei@warnempty[2]{%
  \expandafter\ifx\csname hosei@#1\endcsname\@empty
    \ClassWarningNoLine{hosei-thesis}{#2 が設定されていません（main.tex）}%
  \fi}
\renewcommand\maketitle{%
  \hosei@warnempty{maintitle}{論文題目 \ifhosei@en\string\titleEN\else\string\titleJA\fi}%
  \hosei@warnempty{studentid}{学生証番号 \string\studentid}%
  \hosei@warnempty{supervisor}{指導教員 \string\supervisor}%
  \ifhosei@master\hosei@warnempty{authorkana}{フリガナ \string\authorkana}\fi
  \begin{titlepage}%
    \hypersetup{pageanchor=false}%
    \centering\normalfont
    % ── 上段：年度と論文の種類
    \vspace*{12mm}%
    {\Large\hosei@fiscalyear 年度\hspace{1\zw}\hosei@thesistype\par}%
    \vspace{30mm}%
    % ── 中段：題目（上下を細い罫線で区切る）
    \rule{\linewidth}{0.6pt}\par
    \vspace{10mm}%
    {\huge\bfseries\hosei@maintitle\par}%
    \ifx\hosei@subtitle\@empty\else
      \vspace{8mm}%
      {\large\hosei@subtitle\par}%
    \fi
    \vspace{10mm}%
    \rule{\linewidth}{0.6pt}\par
    \vfill
    % ── 下段：所属・学生・指導教員
    %    ラベルは 5 文字分の幅に均等割りでそろえ，値はすべて同じ大きさにする
    {\large
    \begin{tabular}{@{}l@{\hspace{2\zw}}l@{}}
      \hosei@coverlabel{所\hfill 属} & \hosei@affiliationi \\
        & \hosei@affiliationii \\[4mm]
      \hosei@coverlabel{学生証番号} & \hosei@studentid \\[4mm]
      \ifx\hosei@authorkana\@empty\else
        & {\footnotesize\hosei@authorkana} \\[-1mm]
      \fi
      \hosei@coverlabel{氏\hfill 名} & \@author \\[4mm]
      \hosei@coverlabel{指\hfill 導\hfill 教\hfill 員} & \hosei@supervisor \\
    \end{tabular}\par}%
    \vspace*{14mm}%
  \end{titlepage}%
}
\newcommand\hosei@coverlabel[1]{\makebox[5\zw][l]{#1}}

%% ---------------------------------------------------------------------
%%  前付け・本文・付録
%% ---------------------------------------------------------------------
% 番号なしの章（目次に載せ，柱にも出す）
\newcommand\hosei@unnumberedchapter[1]{%
  \chapter*{#1}%
  \addcontentsline{toc}{chapter}{#1}%
  \markboth{#1}{#1}}

\newcommand\frontmatter{%
  \clearpage
  \pagenumbering{roman}%
  \pagestyle{plain}%
  \ifhosei@review\linenumbers\fi}
\newcommand\mainmatter{%
  \clearpage
  \pagenumbering{arabic}%
  \pagestyle{hosei}}

% 付録：\cref で「付録A」「Appendix A」と出るようにし，柱も「付録A」にする．
% cleveref が \begin{document} で \appendix を再定義するので，その後に包む．
\AtBeginDocument{%
  \let\hosei@orig@appendix\appendix
  \renewcommand\appendix{%
    \hosei@orig@appendix
    \ifhosei@en\else\hosei@wrapchapter\fi
    \global\hosei@inappendixtrue
    \crefalias{chapter}{appendix}}}

% 要旨・Abstract・謝辞
\newenvironment{abstractJA}{%
  \hosei@unnumberedchapter{要旨}%
  % 英語版でも，和文の段落は最初の段落から全角1文字下げる
  \ifhosei@en\setlength{\parindent}{1\zw}\@afterindenttrue\fi}{\par}
\newenvironment{abstractEN}{%
  \hosei@unnumberedchapter{Abstract}%
  \ifhosei@en\else\setlength{\parindent}{1.5em}\fi}{\par}
\newenvironment{acknowledgments}{%
  \hosei@unnumberedchapter{\hosei@ackname}}{\par}
% 研究業績（論文・学会発表の一覧）
\newenvironment{publications}{%
  \hosei@unnumberedchapter{\hosei@pubname}}{\par}

% 目次・図目次・表目次：リンクは黒字（英語版は行間も詰める）
\ifhosei@en
  \def\hosei@listsetup{\hypersetup{linkcolor=black}\singlespacing}
\else
  \def\hosei@listsetup{\hypersetup{linkcolor=black}}
\fi
\let\hosei@orig@tableofcontents\tableofcontents
\let\hosei@orig@listoffigures\listoffigures
\let\hosei@orig@listoftables\listoftables
\renewcommand\tableofcontents{%
  \begingroup\hosei@listsetup\hosei@orig@tableofcontents\endgroup}
\renewcommand\listoffigures{%
  \begingroup\hosei@listsetup\hosei@orig@listoffigures\endgroup}
\renewcommand\listoftables{%
  \begingroup\hosei@listsetup\hosei@orig@listoftables\endgroup}

%% ---------------------------------------------------------------------
%%  サンプル内の執筆ガイド（論文本文と区別し，提出時には環境ごと削除する）
%%  \ignorespaces : \begin{writingnote} の後の改行が 1 行目の先頭の空白にならないようにする
%% ---------------------------------------------------------------------
\newenvironment{writingnote}{%
  \begin{quote}\ifhosei@en\singlespacing\fi\small\color{hosei@navy}%
  \noindent\textbf{\ifhosei@en Writing guidance (remove before submission)\else 執筆ガイド（提出時に削除）\fi}\par\nobreak\noindent\ignorespaces
}{\par\end{quote}}

%% ---------------------------------------------------------------------
%%  添削用の機能
%%   \TODO{...} : review 時は赤字で表示．final 時は表示せず警告を出す
%%   \rev{...}  : review 時は青字（修正箇所）．final 時は通常の文字
%% ---------------------------------------------------------------------
\newcommand\TODO[1]{%
  \ifhosei@review
    {\color{red}\sffamily\bfseries [TODO: #1]}%
  \else
    \ClassWarning{hosei-thesis}{TODO remains: \detokenize{#1}}%
  \fi}
\newcommand\rev[1]{\ifhosei@review{\color{blue}#1}\else#1\fi}

\ifhosei@review
  \renewcommand\linenumberfont{\normalfont\tiny\sffamily\color{gray}}
  % 各ページ右上に「添削用」の印と日付を入れる
  \AddToHook{shipout/foreground}{%
    \put(\dimexpr\paperwidth-12mm\relax,-12mm){%
      \makebox[0pt][r]{\footnotesize\sffamily\color{red!70!black}%
        \ifhosei@en Review copy\else 添削用\fi\quad\today}}}
\fi

\endinput
