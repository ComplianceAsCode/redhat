control "horizon_file_ownership" do
  impact 1.0
  title "Is user/group of config files set to root/horizon?"
  desc "Configuration files contain critical parameters and information
	required for smooth functioning of the component. If an
	unprivileged user, either intentionally or accidentally modifies
	or deletes any of the parameters or the file itself then it would
	cause severe availability issues causing a denial of service to the
	other end users. The configuration file must have file permissions
	of 0640 or more restrictive."
  describe file('/dev') do
    its('mode') { should cmp '00640' }
  end
end
