Beginner Exercise for OpenControl: Welcome to Freedonia Compliance
===================================================================

This project repository demonstrates a simple `System Security Plan` generated using the [OpenControl](http://open-control.org/) framework to automate security compliance paperwork.

We created this demonstration as a simple starter example for ourselves and others. We found the existing mid-2016 OpenControl documentation and examples from Pivotal and 18F very specific to the use case of Cloud.gov.

Audience
---------

Anyone trying to get started with [OpenControl](http://open-control.org/) or [Compliance-Masonry](https://github.com/opencontrol/compliance-masonry), including:

* FISMA newbies that don't want to write big word documents
* FISMA experts that need a more efficent way of doing paper work
* FISMA enforcers that need to trust the OpenControl model and tools we're presenting



Scenario
--------

For this exercise, we'll take the role of IT staff for the Republic of Freedonia.

Freedonia thinks America is just awesome! Freedonia has modeled their `FRedRAMP` program for certifying security of major Information Systems after America's `FedRAMP` for program certifying cloud service providers. (If it's good enough for the cloud...)

The starting point for `FRedRAMP` certifications is the `FRIST 800-53`, which is identical to America's `NIST 800-53` except with fewer security controls. A lot fewer.

### The Controls

Freedonia's `FRIST 800-53` has only 6 security controls:

| ID         | Title          | Type |
| ---------- | -------------- | --------|
| AU-1 | AUDIT AND ACCOUNTABILITY POLICY AND PROCEDURES | organizational control on audit policy |
| AU-2 | AUDIT EVENTS | technical control at the node level |
| PE-2 | PHYSICAL ACCESS AUTHORIZATIONS | organization control on who accesses data center |
| SC-1 | SYSTEM AND COMMUNICATIONS PROTECTION POLICY AND PROCEDURES | organizational control on how components communicate securely |
| SC-7 | BOUNDARY PROTECTION | technical control defending boundary of entire system |
| XX-1 | MOCK/DUMMY CONTROL | here to demonstrate that a control in standard does not have to referenced in a certification |

### The Certification

The certification of `FRedRAMP-Low` requires all the above controls except for XX-1.

The standards and certifications are housed in a repository for easier re-use at [https://github.com/opencontrol/freedonia-frist](https://github.com/opencontrol/freedonia-frist).

### The Information System

The system we're building is a 'Hello World' website for Freedonia, which will comprise:

* Two Amazon Web Service Virtual Private Clouds (AWS VPCs),
one each for development and production
* In each AWS VPC, one node with `NGINX` web server and the static content for the website
* Infrastructure for logging traffic

\[Note: This system is still fictitious, but could be built if it helps Masonry users understand the process\]

Desired Outcome: A Managed System Security Plan
------------------------------------------------

To obtain the `Authority to Operate`, or `ATO`, we'll need an `System Security Plan`, or `SSP`.

The typical `SSP` is a 400 page Word Document re-written for each System, even when many of the controls refer to the same components used by many systems. Creating Word Documents manually cannot keep up with our improved DevOps practices and our high velocity Continuous Integration and Delivery pipeline.

So instead, we want to manage our `SSP` using the tooling from OpenControl to manage, generate, and deploy (e.g., publish) our paperwork like we manage, generate, and deploy our applications.

With the OpenControl tooling, all of our details about system components, standards, and certifications are kept as [YAML](http://www.yaml.org/start.html) files and versioned as needed.  Using the [Compliance-Masonry](https://github.com/opencontrol/compliance-masonry) SSP-assembler written in GO, we can combine OpenControl `YAML` files from multiple repositories into PDF document or HTML files.

### The System Security Plan as PDF

At the end of this excercise, we can generate a PDF version of our SSP with a single command. It will look like this:

> ![PDF screenshoot](./assets/pdffirstpage.png)

A complete generated PDF is [included here](./assets/example.pdf).

### The System Security Plan as HTML

Alternatively--maybe even preferably--we can also generate our `SSP` as a website that looks like this on the front page:

> ![frontpage](./assets/frontpage.png)

and like this on a page for particular control:

> ![detailpage](./assets/detailpage.png)


Requirements to Use OpenControl
--------------------------------
These steps assume you already have:

* a \*nix type operating system
* [Compliance Masonry installed](https://github.com/opencontrol/compliance-masonry#installation)
* `calibre` installed for PDF generation
    * For OS X with Homebrew installed, try `brew cask install calibre`
* `node-js` installed for local viewing at https://localhost:4000


Minimal File Structure for an OpenControl-based SSP
----------------------------------------------------

The minimum initial files and file tree structure we need to generate a standalone `SSP` is:

```
.
├── README.md   # the file you're reading now
├── AU_policy
│   └── component.yaml        # a local description of the Audit policy (AU)
├── markdowns         
│   ├── README.md             # the introduction to the entire SSP
│   ├── SUMMARY.md            # a table of contents for narrative documents of the SSP
│   └── docs  # directory for narrative documents
│       ├── about-the-ssp.md
│       └── Waterfall_model.png # an example image
├── opencontrol.yaml          # the schema for SSP and its remote resources/dependencies
```

Running `compliance-masonry` will also generate the directories `opencontrols` and `exports`

It just so happens you can get these files and file tree structure by cloning this repository!

#### The opencontrol.yaml Config File

Notice one file in particular, the `opencontrol.yaml` file in the root directory of the tree. The `opencontrol.yaml` file is key to using OpenControl.

OpenControl uses a config file called `opencontrol.yaml` following the popular configuration file pattern we see with so many tools today. Every OpenControl repository will have at least one `opencontrol.yaml` file providing critical informatoin and, importantly, information about dependencies on other other OpenControl YAML files and repos.

Here's what the `opencontrol.yaml` file for our Freedonia project looks like:

```yaml
schema_version: "1.0.0"
name: freedonia.fd
metadata:
  description: hello_world
  maintainers:
    - pburkholder@pobox.com
components:
  - ./AU_policy
dependencies:
  standards:
    - url: https://github.com/opencontrol/freedonia-frist/
      revision: master
  certifications:
    - url: https://github.com/opencontrol/freedonia-frist/
      revision: master
  # We re-use the Freedonia AWS component, so consume
  # the system's compliance info as a remote `systems` description
  systems:
    - url: https://github.com/opencontrol/freedonia-aws-compliance/
      revision: master
```

Building and Updating the SSP Yourself
--------------------------------------

Clone this repo, then `cd` into `freedonia-compliance`.  Then run:

```shell
compliance-masonry get
compliance-masonry docs gitbook FredRAMP-low
```

The `compliance-masonry get` command reads the `opencontrol.yaml` file and retrieves all the dependencies, even from other OpenControl repositories!

The `compliance-masonry docs gitbook FredRAMP-low` command generates a document of the components and standards matching the `FRedRAMP-Low` certification that is expressed in the `gitbook` format.

At this point, you have generated content for your `SSP` inside of the `exports` directory that has artfully combined data from the all other OpenControl `YAML` files into a `gitbook`!

Our next step is to publish/deploy our `gitbook` content representing our SSP for shared human access. First, install [GitBook](https://github.com/GitbookIO/gitbook-cli#readme):

```shell
npm install -g gitbook-cli
```

To make a PDF version:

```shell
cd exports && gitbook pdf ./ ./compliance.pdf
# creates the PDF at `exports/compliance.pdf`
```

To make a HTML web site version:

```shell
cd exports && gitbook serve
# visit your HTML SSP at http://localhost:4000
```

The steps above are included in the project's `Makefile` so you can reliably run, say:

```shell
make clean pdf
# or
make clean serve
```

Review
-------

We've generated a very simple `System Security Plan` from a bunch of re-usable `YAML` files and Markdown content in a computer-controlled pipeline style instead of a manually created word documents.

There are big benefits to this approach:

1. Our `SSP` is now managed like our codebase; anytime we update our code we can also update our `SSP` and publish a new one with a single click
2. Our `SSP` is more structured and more machine-readable, so we can do other processing
3. We can document compliance of re-usable components ONCE and re-use the documentation, too

Next Steps
----------

OK. So we got a document. But how do we do include actual verification of the controls in the document? We've started another repo (still in progress) to show building a system and documentation together--and deploying both. Visit [freedonia-aws-compliance](https://github.com/opencontrol/freedonia-aws-compliance) for that.

You could use this repo as a kind of stub file for your own compliance documentation. Just change the `opencontrol.yaml` file and the content in the repo.


Feedback
--------

Please open issues at the [ATO1Day
Project](https://github.com/opencontrol/ato1day-compliance/issues), instead of within this repository.
