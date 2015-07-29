# build package documentation
index:
	Rscript inst/indexing.R
doc:
	R -e "devtools::document()"
build:
	R -e "devtools::build()"
install:
	R -e "devtools::install_github('klainfo/DefectData')"
check:
	R -e "devtools::check()"
