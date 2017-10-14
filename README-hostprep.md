# Prep your Development Environment
## Red Hat Enterprise Linux, CentOS, Fedora
A few packages are needed for successful OpenControl builds on a RHEL7/Fedora 25+ system. 

(1) Install Base Packages
`````
sudo yum -y install git vim gcc-c++ make xdg-utils libxml2-devel
`````

(2) Enable EPEL
`````
sudo yum -y localinstall https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
`````

(3) Install ``NodeJS`` and ``NPM`` packages
`````
sudo yum install nodejs npm --enablerepo=epel
`````

(4) Install Calibre
`````
sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.py | sudo python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main()"
`````

(5) Install GitBook via NPM
`````
sudo npm install gitbook-cli -g
`````

(6) Install ComplianceMasonry
`````
curl -L https://github.com/opencontrol/compliance-masonry/releases/download/v1.1.2/compliance-masonry_1.1.2_linux_amd64.tar.gz -o compliance-masonry.tar.gz
tar -xf compliance-masonry.tar.gz
sudo cp compliance-masonry_1.1.2_linux_amd64/compliance-masonry /usr/local/bin
`````

(7) Install Golang
`````
sudo subscription-manager repos --enable=rhel-7-server-optional-rpms
sudo yum -y install golang
`````

(7a) Create GOPATH structure 
You can use something else besides ``~/golang-projects``, just remember to update the directory in 7b.
`````
mkdir -p ~/golang-projects/{bin,pkg,src}
`````

(7b) Update ~./bash_profile
`````
export GOBIN="$HOME/golang-projects/bin"
export GOPATH="$HOME/golang-projects"
export GOSRC="$HOME/golang-projects/src"
`````
And then source it:
`````
source ~/.bash_profile
`````

(8) Install FedRAMP Templater
`````
go get github.com/opencontrol/fedramp-templater

`````

(9) Install ``yamllint``
`````
sudo yum -y install yamllint
`````

# OSX
(1) Use ``brew`` to install required packages
`````
brew install go node npm libxml2 pkg-config
`````

(2) Download ComplianceMasonry (used for OpenControl language processing)
`````
cd ~/Downloads
curl -L https://github.com/opencontrol/compliance-masonry/releases/download/v1.1.2/compliance-masonry_1.1.2_darwin_amd64.zip -o compliance-masonry.zip
unzip compliance-masonry.zip
cp compliance-masonry_1.1.2_darwin_amd64/compliance-masonry /usr/local/bin
`````

(3) Install fedramp-templater components (used to generate SSP templates)
NOTE: Your version numbers of libxml may be different
`````
mkdir -p /usr/local/lib/pkgconfig
sudo ln -s /usr/local/Cellar/libxml2/2.9.4_2/lib/pkgconfig/libxml-2.0.pc /usr/local/lib/pkgconfig/libxml-2.0.pc
go get github.com/moovweb/gokogiri
`````

(4) Install GitBook
`````
npm install n -g
npm install -g gitbook-cli
gitbook install
`````

(5) Update environment variables, as needed.
Add the following to ~/.bash_profile:
`````
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export GOPATH="$HOME/go"
export GOPATH="/usr/local/opt/go/"
export GOBIN=$GOPATH/libexec/bin"
export PATH=$PATH:$GOBIN
`````

# Perform a test build
You can run ``make`` in a top-level directory to build the project.

For example, to build OpenStack 13 content:
`````
$ cd OpenStackPlatform/
$ make
`````

Inside the ``exports`` directory, you will now see two files:
  * ``FedRAMP-Filled-v2.1.docx``: Completed FedRAMP template with your security controls
  * ``Red_Hat_OpenStack_Platform_13_Compliance.pdf``: DocBook style, breakouts controls without formatting
