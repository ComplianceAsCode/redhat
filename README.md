# This repository is DEPRECATED

Please refer to [ComplianceAsCode/content](http://github.com/ComplianceAsCode/content) instead.

Entries from OpenControl were migrated to the controls structure:

e.g.

* https://github.com/ComplianceAsCode/content/pulls?q=is%3Apr+is%3Amerged+migrate+label%3Aopencontrol-to-cac


# Open Controls for Red Hat technologies

This repository contains control responses to NIST-800-53 security controls. Human readable overview is available at http://atopathways.redhatgov.io/ato/products/select/NIST-800-53

Some of the content is still work in progress!

![Validate content](https://github.com/ComplianceAsCode/redhat/workflows/Validate%20content/badge.svg)

## Developer Prep
Instructions on how to prepare your development host:
- [RHEL / Fedora / CentOS](https://github.com/opencontrol/RedHat/blob/master/README-hostprep.md#red-hat-enterprise-linux-centos-fedora)
- [OSX](https://github.com/opencontrol/RedHat/blob/master/README-hostprep.md#osx)
- [Perform a test build](https://github.com/opencontrol/RedHat/blob/master/README-hostprep.md#perform-a-test-build)

## Using this Content

Users can use [GoComply/fedramp](https://github.com/GoComply/fedramp) tool to genereate OSCAL formatted FedRAMP SSPs out of the OpenControl formatted here. Example:

```
podman run \
  --rm -t --security-opt label=disable \
  -v $(pwd):/shared-dir \
  quay.io/gocomply/gocomply sh -c "\
      cd /shared-dir && \
      gocomply_fedramp opencontrol https://github.com/ComplianceAsCode/redhat oscal.xml/"
  find oscal.xml/ -type f
```

The results of this process can be reviewed online under [ComplianceAsCode/oscal](https://github.com/ComplianceAsCode/oscal) project.

## Debugging the OpenControl

Compliance masonry command from [OpenControl project](https://open-control.org/) may be used to fetch opencontrol dependencies of this project and validate the repository conformance with OpenControl standard.

```
podman run \
  --rm -t --security-opt label=disable \
  -v $(pwd):/shared-dir \
  quay.io/gocomply/gocomply sh -c "\
      cd /shared-dir && \
      git clone --depth 1 https://github.com/complianceascode/redhat ComplianceAsCode.redhat && \
      cd ComplianceAsCode.redhat && \ 
      masonry get --verbose && \
      masonry validate"
find ComplianceAsCode.redhat/opencontrols/ -type f
```
