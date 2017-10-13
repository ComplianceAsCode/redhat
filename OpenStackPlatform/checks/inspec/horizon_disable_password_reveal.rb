control "horizon_disable_password_reveal" do
  impact 1.0
  title "Is disable_password parameter set to True?"
  desc "Common feature that applications use to provide users a convenience is
	to unmask passwords in the browser. While this feature is percieved as
	extremely friendly for the average user, at the same time it
	introduces a flaw, as user passwords will be entered in plain text."
  describe file('/etc/openstack-dashboard/local_settings') do
    its('content') { should match /disable_password=True/ }
  end
end
