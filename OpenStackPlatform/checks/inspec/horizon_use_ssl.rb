control "horizon_use_ssl" do
  impact 1.0
  title "Is USE_SSL parameter set to True?"
  desc "OpenStack services communicate with each other using various
	protocols and the communication might involve sensitive/confidential
	information. An attacker may try to eavesdrop on the channel in
	order to access sensitive information. Thus all the services must
	communicate with each other using a secured communication protocol
	like HTTPS."
  describe file('/etc/openstack-dashboard/local_settings') do
    its('content') { should match /USE_SSL=True/ }
  end
end
