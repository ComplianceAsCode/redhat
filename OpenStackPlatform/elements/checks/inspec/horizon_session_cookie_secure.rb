control "horizon_session_cookie_secure" do
  impact 1.0
  title "Is SESSION_COOKIE_SECURE parameter set to True?"
  desc "The 'SECURE' cookie attribute instructs web browsers to only send the
	cookie through an encrypted HTTPS (SSL/TLS) connection. This session
	protection mechanism is mandatory to prevent the disclosure of the
	session ID through Man-in-the-Middle (MitM) attacks. It ensures that
	an attacker cannot simply capture the session ID from web browser
	traffic"
  describe file('/etc/openstack-dashboard/local_settings') do
    its('content') { should match /SESSION_COOKIE_SECURE=True/ }
  end
end
