# OpenControl for Red Hat OpenStack Platform
Welcome! This content is very much in draft form. Contributions welcome!

We've done our best to separate NIST 800-53 controls that represent [organizational](https://github.com/opencontrol/RedHat/tree/master/customer_cxo_controls), [program/project management](https://github.com/opencontrol/RedHat/tree/master/customer_pmo_controls), and technical controls that should be addressed during OpenStack configuration and operations.

The ``policies/`` directory contains YAML that corresponds to various NIST 800-53 control categories, as follows:
* AC-Access_Control/
* AT-Awareness_and_Training/
* AU-Audit_and_Accountability/
* CA-Security_Assessment_and_Authorization/
* CM-Configuration_Management/
* CP-Contingency_Planning/
* IA-Identification_and_Authentication/
* IR-Incident_Response/
* MA-Maintenance/
* MP-Media_Protection/
* PE-Physical_and_Environmental_Protection/
* PL-Planning/
* PS-Personnel_Security/
* RA-Risk_Assessment/
* SA-System_and_Services_Acquisition/
* SC-Systems_and_Communications_Protection/
* SI-System_and_Information_Integrity/

### How can I help?
To dive right in, take a look at any of the policy files (e.g. policies/AU-Audit_and_Accountability/component.yaml). Each control has generic language outlining what a successful response would be. Anything you can help address would be great! 

### How do I get help?
Please open a ticket: [https://github.com/opencontrol/RedHat/issues](https://github.com/opencontrol/RedHat/issues)

### Perform a Build
First, review the [Prep your Dev Environment](https://github.com/opencontrol/RedHat/#prep-your-development-environment) instructions.

Once your system is ready, run `make`:

`$ make`

Two artifacts will be generated:
1. `exports/RedHat_OpenStack_Platform_Compliance.pdf`: Simply formatted "Security Requirements Traceability Matrix" that outlines how OpenStack configurations and operation procedures meet various FedRAMP requirements.

2. `exports/FedRAMP-Filled-v2.1.docx`: Incorporates OpenStack content into a GSA-provided FedRAMP template.
