# build package documentation
build:
	R -e "devtools::build()"
check:
	R -e "devtools::check()"
doc:
	R -e "devtools::document()"
