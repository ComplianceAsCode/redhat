%global		redhatrelease	1
%global 	import_path     code.google.com/p/go.net

Name:		opencontrol-redhat
Version:	0.1
Release:	%{redhatrelease}%{?dist}
Summary:	OpenControl content for Red Hat technologies
Vendor:		Red Hat, Inc

Group:		System Environment/Base
License:	BSD-3
URL:		https://github.com/OpenControl/RedHat

Source0:	https://github.com/opencontrol/RedHat/releases/download/v1.0.1/opencontrol-redhat-0.1-1.tar.gz

BuildArch:	noarch

BuildRequires:	make
#Requires:	tbd

%description
OpenControl content for Red Hat technologies

%prep
%setup -q -n %{name}-%{version}-%{redhatrelease}

%build
cd OpenShift-v3 && make pdf

%install
mkdir -p %{buildroot}%{_datadir}/opencontrol/RedHat/OpenShift-v3

# Add in core content (SCAP)
cp -a OpenShift-v3/* %{buildroot}%{_datadir}/opencontrol/RedHat/OpenShift-v3/

# Add in manpage
#cp -a RHEL6/input/auxiliary/scap-security-guide.8 %{buildroot}%{_mandir}/en/man8/scap-security-guide.8

%files
%{_datadir}/opencontrol/RedHat/
#%lang(en) %{_mandir}/en/man8/scap-security-guide.8.gz
#%doc tbd

%changelog
* Thu Jul 27 2017 Shawn Wells <shawn@redhat.com) 0.1-1
- Initial RPM
