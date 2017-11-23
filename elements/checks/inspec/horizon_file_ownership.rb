control "horizon_file_ownership" do
  impact 1.0
  title "Is user/group of config files set to root/horizon?"
  desc "Configuration files contain critical parameters and information
	required for smooth functioning of the component. If an
	unprivileged user, either intentionally or accidentally modifies
	or deletes any of the parameters or the file itself then it would
	cause severe availability issues causing a denial of service to the
	other end users. Thus user ownership of such critical configuration
	files must be set to root and group ownership must be set to horizon."
  describe file('/etc/openstack-dashboard/local_settings') do
    its('owner') { should eq 'root' }
    its('group') { should eq 'horizon' }
  end
end
