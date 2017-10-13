# This Makefile provides some shortcuts to generating security documents
# based on any changes in the input files. Typical usage to make a PDF
# complete from all OpenStack sources:
# 	make clean pdf
#
# or likewise for serving the content:
# 	make clean serve
#
# TODO: Add rules so generating files are compared instead of their
# 	directories

CM = compliance-masonry
GB = gitbook

# GNU Make trick from
# 	http://stackoverflow.com/questions/5618615/check-if-a-program-exists-from-a-makefile
EXECUTABLES = $(CM) $(GB)
K := $(foreach exec,$(EXECUTABLES),\
	$(if $(shell which $(exec)), some string,$error "No $(exec) in PATH"))))

clean:
	rm -Rf exports/

compliance-pdf: exports
	cd exports/ && gitbook pdf ./ ./Red_Hat_OpenStack_Platform_13_Compliance.pdf

serve: exports
	cd exports/ && gitbook serve

exports: opencontrols
	${CM} docs gitbook --opencontrols exports/opencontrols/ --exports exports/ --markdowns exports/ FedRAMP-low

opencontrols: 
	cd narratives && ${CM} get --dest ../exports/opencontrols/ --config opencontrol.yaml

coverage:
	${CM} diff FedRAMP-low

fedramp-docs:
	${GOPATH}/bin/fedramp-templater fill exports/opencontrols/ ./../shared/doc_templates/FedRAMP-System-Security-Plan-Template-v2.1.docx exports/FedRAMP-Filled-v2.1.docx

fedramp-diff:
	${GOPATH}/bin/fedramp-templater diff exports/opencontrols/ ./../shared/doc_templates/FedRAMP-System-Security-Plan-Template-v2.1.docx
all:
	../shared/build-scripts/ssg-content-generator.py xccdf --shorthand ../shared/ profiles/ elements/rules/ elements/checks/ elements/remediations/

checks:
	yamllint elements/guide/*
