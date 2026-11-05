# =====================================================================
#  法政大学 卒業論文・修士論文 LaTeX テンプレート  メンテナンス用 Makefile
# ---------------------------------------------------------------------
#  make          例付き版と起稿用をビルドする（先に共通ファイルをコピーする）
#  make ja       日本語版だけビルドする
#  make en       英語版だけビルドする
#  make starter  starter/ja/ と starter/en/ をビルドする
#  make review   review オプション付きでビルドする（main-review.pdf）
#  make dist     配布用の zip とサンプル PDF を dist/ に作る
#  make figures  サンプル図（figure-sources/）を作り直して ja/ と en/ に置く
#  make clean    中間ファイル・PDF・dist/ を削除する
# =====================================================================

SHARED   := hosei-thesis.cls latexmkrc
VARIANTS := ja en
PROJECTS := $(VARIANTS) $(addprefix starter/,$(VARIANTS))
LATEXMK  := latexmk -interaction=nonstopmode -halt-on-error
LUALATEX := lualatex -interaction=nonstopmode -halt-on-error -output-directory=build

.PHONY: all sync $(VARIANTS) starter review dist figures clean

all: $(VARIANTS) starter

# 共通ファイルの原本はこのフォルダにある．ja/ と en/ にはコピーを置く
sync:
	@for v in $(PROJECTS); do cp $(SHARED) $$v/ || exit 1; done

$(VARIANTS): sync
	cd $@ && $(LATEXMK) main.tex

starter: sync
	@for v in $(VARIANTS); do \
	  (cd starter/$$v && $(LATEXMK) main.tex) || exit 1; \
	done

review: sync
	@for v in $(PROJECTS); do \
	  (cd $$v && $(LATEXMK) -jobname=main-review \
	    -usepretex='\PassOptionsToClass{review}{hosei-thesis}' main.tex) || exit 1; \
	done

dist: all
	rm -rf dist && mkdir -p dist
	@for v in $(VARIANTS); do \
	  cp $$v/main.pdf dist/hosei-thesis-$$v-sample.pdf || exit 1; \
	  (cd $$v && zip -q ../dist/hosei-thesis-$$v.zip \
	    $(SHARED) main.tex README.md references.bib chapters/*.tex figures/*.pdf) || exit 1; \
	  (cd starter/$$v && zip -q ../../dist/hosei-thesis-$$v-starter.zip \
	    $(SHARED) main.tex README.md references.bib chapters/*.tex figures/README.md) || exit 1; \
	done
	@ls -l dist

# サンプル図：数値実験の結果（ギャップと計算時間．pgfplots）を日英それぞれで作る
figures:
	@mkdir -p figure-sources/build
	@cd figure-sources && for v in $(VARIANTS); do \
	  for k in gap time; do \
	    $(LUALATEX) -jobname=results-$$k-$$v "\def\figlang{$$v}\def\figkind{$$k}\input{results.tex}" >/dev/null || exit 1; \
	    cp build/results-$$k-$$v.pdf ../$$v/figures/results-$$k.pdf; \
	  done; \
	done
	rm -rf figure-sources/build
	@ls ja/figures en/figures

clean:
	@for v in $(PROJECTS); do \
	  (cd $$v && latexmk -C main.tex >/dev/null 2>&1; rm -f main-review.* main.bbl); \
	done
	rm -rf dist
