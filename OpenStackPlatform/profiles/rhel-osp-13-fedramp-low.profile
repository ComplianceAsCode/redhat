documentation_complete: true
title: Red Hat OpenStack Platform Version 13: FedRAMP Low
title_override: true
profile_id: rhel-osp-13-fedramp-low

description: |
    This profile verifies compliance of Red Hat OpenStack Platform 13
    against FedRAMP Low requirements.

rule_selection:
    - rule: horizon_csrf_cookie_secure
    - rule: horizon_disable_password_reveal
    - rule: horizon_file_ownership
    - rule: horizon_file_perms
    - rule: horizon_password_autocomplete
    - rule: horizon_session_cookie_httponly
    - rule: horizon_session_cookie_secure
    - rule: horizon_use_ssl
