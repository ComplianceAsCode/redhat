#
#
#

all: clean ansible openshift openstack idm rhvh rhvm

ansible:
	cd ansible-tower && make && cd -

openshift:
	cd openshift-container-platform-3 && make && cd -

openstack:
	cd openstack-platform-13 && make && cd -

idm:
	cd identity-management && make && cd -

rhvh:
	cd virtualization-host && make && cd -

rhvm:
	cd virtualization-manager && make && cd -

clean:
	rm {ansible-tower,openshift-container-platform-3,openstack-platform-13,identity-management,virtualization-host,virtualization-manager}/component.yaml