all: clean gitbook pdf
.PHONY: clean gitbook pdf

clean:
	Rscript -e 'options(bookdown.clean_book = TRUE); bookdown::clean_book()'

gitbook:
	Rscript -e 'bookdown::render_book("index.Rmd", output_format = "bookdown::gitbook", quiet = TRUE)'

pdf:
	Rscript -e 'bookdown::render_book("index.Rmd", output_format = "bookdown::pdf_book", quiet = TRUE)'
