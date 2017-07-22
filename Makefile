# This makefile provides some shortcuts to generating update documents
# based on any changes in the input files. Typical usage to make a
# PDF complete from all sources:
#    `make clean pdf`
# or likewise for serving the content:
#    `make clean serve`
#
# FIXME: Add rules so generated files are compared instead of their directories

CM = compliance-masonry
GB = gitbook

# GNU Make trick from
#   http://stackoverflow.com/questions/5618615/check-if-a-program-exists-from-a-makefile
EXECUTABLES = $(CM) $(GB)
K := $(foreach exec,$(EXECUTABLES),\
        $(if $(shell which $(exec)),some string,$(error "No $(exec) in PATH")))

default: rhel7 openshiftv3

clean-all: clean
	- cd RHEL7 && make clean
	- cd OpenShift-v3 && make clean

clean:
	- rm -rf exports/ opencontrols/

rhel7-clean:
	- cd RHEL7 && clean

rhel7: rhel7-clean
	- cd RHEL7 && make clean

openshiftv3-clean:
	- cd OpenShift-v3 && make clean

openshiftv3: openshiftv3-clean
	- cd OpenShift-v3 && make

###
### Sample 'MyApp' targets
###
opencontrols: opencontrol.yaml
	- ${CM} get

exports: opencontrols
	- ${CM} docs gitbook FedRAMP-low

pdf: exports
	- cd exports/ && gitbook pdf ./ ./MyApp_Compliance_Guide.pdf
	
serve: exports
	- cd exports/ && gitbook serve

fedramp:
	- ${GOPATH}/bin/fedramp-templater fill opencontrols/ ./FedRAMP_Template/FedRAMP-System-Security-Plan-Template-v2.1.docx exports/FedRAMP-Filled-v2.1.docx

fedramp-diff:
	- ${GOPATH}/bin/fedramp-templater diff opencontrols/ ./FedRAMP_Template/FedRAMP-System-Security-Plan-Template-v2.1.docx

checks:
	- yamllint customer_cxo_controls/policies/
	- yamllint customer_pmo_controls/policies/
