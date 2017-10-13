control "horizon_csrf_cookie_secure" do
  impact 1.0
  title "Is CSRF_COOKIE_SECURE parameter set to True?"
  desc "CSRF (Cross-site request forgery) is an attack which forces an end user
	to execute unauthorized commands on a web application in which they are
	currently authenticated. A successful CSRF exploit can compromise end
	user data and operations in case of normal user. If the targeted end
	user has admin privileges, this can compromise the entire web
	application."
  describe file('/etc/openstack-dashboard/local_settings') do
    its('content') { should match /CSRF_COOKIE_SECURE=True/ }
  end
end
