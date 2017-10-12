control "horizon_session_cookie_httponly" do
  impact 1.0
  title "Is SESSION_COOKIE_HTTPONLY parameter set to True?"
  desc "The HTTPONLY cookie attribute instructs web browsers not to allow
	scripts (e.g. JavaScript or VBscript) the ability to access cookies
	via the DOM document.cookie object. This session ID protection is
	mandatory to prevent session ID stealing through XSS attacks."
  describe file('/etc/openstack-dashboard/local_settings') do
    its('content') { should match /SESSION_COOKIE_HTTPONLY=True/ }
  end
end
