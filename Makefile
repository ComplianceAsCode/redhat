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
ROOT_DIR ?= $(CURDIR)
RPM_SPEC := $(ROOT_DIR)/opencontrol-redhat.spec
PKGNAME := $(shell sed -ne 's/Name:\t\t\(.*\)/\1/p' $(RPM_SPEC))
VERSION := $(shell sed -ne 's/Version:\t\(.*\)/\1/p' $(RPM_SPEC))
REDHAT_RELEASE := $(shell sed -ne 's/^\(.*\)redhatrelease\t\(.*\)/\2/p' $(RPM_SPEC))

REDHAT_DIST := $(shell rpm --eval '%{dist}')
RELEASE := $(REDHAT_RELEASE)$(REDHAT_DIST)
PKG := $(PKGNAME)-$(VERSION)-$(REDHAT_RELEASE)

ARCH := noarch
TARBALL = $(RPM_TOPDIR)/SOURCES/$(PKG).tar.gz

RPM_DEPS := tarball $(RPM_SPEC) Makefile
RPM_TMPDIR ?= $(ROOT_DIR)/rpmbuild
RPM_TOPDIR ?= $(RPM_TMPDIR)/src/redhat
RPM_BUILDROOT ?= $(RPM_TMPDIR)/rpm-buildroot
RPMBUILD_ARGS := --define '_topdir $(RPM_TOPDIR)'  --define '_tmppath $(RPM_TMPDIR)'

MKDIR = test -d $(1) || mkdir -p $(1)

define rpm-prep
	$(call MKDIR,$(RPM_TMPDIR)/$(PKG))
	$(call MKDIR,$(RPM_BUILDROOT))
	$(call MKDIR,$(RPM_TOPDIR)/SOURCES)
	$(call MKDIR,$(RPM_TOPDIR)/SPECS)
	$(call MKDIR,$(RPM_TOPDIR)/BUILD)
	$(call MKDIR,$(RPM_TOPDIR)/RPMS/$(ARCH))
	$(call MKDIR,$(RPM_TOPDIR)/SRPMS)
	$(call MKDIR,$(RPM_TOPDIR)/ZIP)
endef

# GNU Make trick from
#   http://stackoverflow.com/questions/5618615/check-if-a-program-exists-from-a-makefile
EXECUTABLES = $(CM) $(GB)
K := $(foreach exec,$(EXECUTABLES),\
        $(if $(shell which $(exec)),some string,$(error "No $(exec) in PATH")))

default: openshiftv3
all: rhel7 openshiftv3 rpm

clean-all: clean
	- cd RHEL7 && make clean
	- cd OpenShift-v3 && make clean
	- rpm -rf $(RPM_TMPDIR)

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

tarball:
	$(call rpm-prep)

	# Copy in the source trees
	cp -r OpenShift-v3/ $(RPM_TMPDIR)/$(PKG)
	cp -r RHEL7/ $(RPM_TMPDIR)/$(PKG)

	# Don't trust developers. Clean out the build
	# environment before packaging
	cd $(RPM_TMPDIR)/$(PKG)/OpenShift-v3 && $(MAKE) clean
	
	# Create the source tar, copy it to $TARBALL
	# (e.g. somewhere in the SOURCES directory)
	cd $(RPM_TMPDIR) && tar -czf $(PKG).tar.gz $(PKG)
	cp $(RPM_TMPDIR)/$(PKG).tar.gz $(TARBALL)

zipfile:
	# Gives us something windows people can download from GitHub
	# for one-way transfer to their networks
	#
	# NOTE: By default zip will store the full path relative
	#	to the current directory, need to cd into $(RPM_TMPDIR)
	#
	cp OpenShift-v3/ $(RPM_TOPDIR)/ZIP/
	#
	# Originally attempted to 'cd $(RPM_TOPDIR)/ZIP' and
	# make the zip from there, however it still placed it 
	# at working directory. Should look into this sometime.
	#
	#cd $(RPM_TOPDIR)/ZIP
	#zip -r $(PKG)-$(RELEASE).zip . * -j
	zip -r $(PKG)-$(RELEASE).zip $(RPM_TOPDIR)/ZIP/* -j
	mv $(PKG)-$(RELEASE).zip $(RPM_TOPDIR)/ZIP/

srpm: $(RPM_DEPS)
	@echo "Building $(PKGNAME) SRPM..."
	cat $(RPM_SPEC) > $(RPM_TOPDIR)/SPECS/$(notdir $(RPM_SPEC))
	cd $(RPM_TOPDIR) && rpmbuild $(RPMBUILD_ARGS) --target=$(ARCH) -bs SPECS/$(notdir $(RPM_SPEC)) --nodeps

rpm: srpm
	@echo "Building $(PKG) RPM..."
	cd $(RPM_TOPDIR)/SRPMS && rpmbuild --rebuild --target=$(ARCH) $(RPMBUILD_ARGS) --buildroot $(RPM_BUILDROOT) -bb $(PKG)$(REDHAT_DIST).src.rpm


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
