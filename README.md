OpenControl content for Red Hat technologies. Work in progress!

## Developer Prep
Instructions on how to prepare your development host:
- [RHEL / Fedora / CentOS](https://github.com/opencontrol/RedHat/blob/master/README-hostprep.md#red-hat-enterprise-linux-centos-fedora)
- [OSX](https://github.com/opencontrol/RedHat/blob/master/README-hostprep.md#osx)
- [Perform a test build](https://github.com/opencontrol/RedHat/blob/master/README-hostprep.md#perform-a-test-build)

## Using this Content
Usable/"stable" content is kept on the ``opencontrol`` branch. A sample opencontrol.yaml:
`````
name: Template Information System
metadata:
  description: Template Information System
  maintainers:
    - You <you@domain.com>

components:
#    - ./local/content/

dependencies:
  standards:
    - url: https://github.com/opencontrol/standards
      revision: master
  certifications:
    - url: https://github.com/opencontrol/certifications
      revision: master
  systems:
    # Pulls in OpenStack 13 content
    - url: https://github.com/ComplianceAsCode/redhat
      contextdir: osp13
      revision: opencontrol
    #Pulls in OpenShift 3 content
    - url: https://github.com/ComplianceAsCode/redhat
      contextdir: ocp3
      revision: opencontrol
    # Pulls in Red Hat Identity Management content
    - url: https://github.com/ComplianceAsCode/redhat
      contextdir: idm
      revision: opencontrol
    # Pulls in Ansible Tower content
    - url: https://github.com/ComplianceAsCode/redhat
      contextdir: ansible-tower
      revision: opencontrol
    # Pulls in Red Hat Virtualization Manager content
    - url: https://github.com/ComplianceAsCode/redhat
      contextdir: rhvm
      revision: opencontrol
    # Pulls in Red Hat Virtualization Host content
    - url: https://github.com/ComplianceAsCode/redhat
      contextdir: rhvh
      revision: opencontrol
`````
