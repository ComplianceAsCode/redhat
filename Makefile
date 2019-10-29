TARGETS = ansible-tower coreos-4 identity-management openshift-container-platform-3 openshift-dedicated openstack-platform-13 virtualization-host virtualization-manager
TARGET_FILES = $(TARGETS:%=build/%/component.yaml)

.PHONY: clean
all: $(TARGET_FILES)

clean:
	rm -f $(TARGET_FILES)

build/%/component.yaml: %/header_opencontrol.yaml %/policies/**/*
	mkdir -p $(@:%/component.yaml=%)
	cat $(sort $^) > $@

%: build/%/component.yaml
