# build package documentation
build:
	R -e "devtools::build()"
install:
	R -e "devtools::install_github('klainfo/DefectData')"
check:
	R -e "devtools::check()"
doc:
	R -e "devtools::document()"
