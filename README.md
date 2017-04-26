# Red Hat
OpenControl content for Red Hat technologies. Work in progress!


## Building OpenControl/RedHat content
A few packages are needed for successful OpenControl builds on a RHEL7 system. 

(1) Install Base Packages
`````
$ sudo yum -y install git vim gcc-c++ make xdg-utils
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
cp compliance-masonry_1.1.2_linux_amd64/compliance-masonry /usr/local/bin
`````
