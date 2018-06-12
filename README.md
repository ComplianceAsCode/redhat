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
    - You <you@domain.com

components:
#    - ./local/content/

dependencies:
  standards:
    - url: https://github.com/opencontrol/standards
      revision: master
  certifications:
    - url: https://github.com/SecurityCentral/opencontrol-certifications
      revision: master
    - url: https://github.com/opencontrol/FedRAMP-Certifications
      revision: master
  systems:
    - url: https://github.com/SecurityCentral/redhat-openstack-platform-13
      revision: opencontrol
`````
