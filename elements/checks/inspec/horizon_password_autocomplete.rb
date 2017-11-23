control "horizon_password_autocomplete" do
  impact 1.0
  title "Is password_autocomplete  parameter set to False?"
  desc "Common feature that applications use to provide users a convenience
	is to cache the password locally in the browser (on the client
	machine) and having it 'pre-typed' in all subsequent requests. While
	this feature can be perceived as extremely friendly for the average user,
	at the same time, it introduces a flaw, as the user account becomes easily
	accessible to anyone that uses the same account on the client machine
	and thus may lead to compromise of the user account."
  describe file('/etc/openstack-dashboard/local_settings') do
    its('content') { should match /password_autocomplete=False/ }
  end
end
