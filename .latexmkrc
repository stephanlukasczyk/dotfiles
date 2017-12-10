# vim: set ft=perl :

# Choose lualatex as the default builder for pdfs, don't stop for errors, use synctex
$pdflatex = 'lualatex -interaction=nonstopmode -synctex=1 --shell-escape %O %S';
# .bbl files assumed to be regeneratable, safe as long as the .bib file is available
$bibtex_use = 2;
# Use biber instead of bibtex
$biber = 'biber --debug %O %S';
# Default pdf viewer
$pdf_update_method = 2;
$pdf_previewer = 'mupdf %O %S';
# Extra file extensions to clean when latexmk -c or latexmk -C is used
$clean_ext = '%R.run.xml %R.synctex.gz pdfa.xmpi %R.xmpdata';

add_cus_dep('glo', 'gls', 0, 'makeglo2gls');
add_cus_dep('acn', 'acr', 0, 'makeglo2gls');
sub makeglo2gls {
    system("makeglossaries $_[0]");
}
