#
#
#

all: clean ansible openshift openstack idm

ansible:
	cd ansible-tower && make && cd -

openshift:
	cd openshift-container-platform-3 && make && cd -

openstack:
	cd openstack-platform-13 && make && cd -

idm:
	cd identity-management && make && cd -

clean:
	rm {ansible-tower,openshift-container-platform-3,openstack-platform-13,identity-management}/component.yaml