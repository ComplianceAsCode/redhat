#
#
#

all: clean ansible openshift openstack

ansible:
	cd ansible-tower && make && cd -

openshift:
	cd openshift-container-platform-3 && make && cd -

openstack:
	cd openstack-platform-13 && make && cd -

clean:
	rm {ansible-tower,openshift-container-platform-3,openstack-platform-13}/component.yaml