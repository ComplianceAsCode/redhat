file { '/etc/.java/deployment':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

file { '/etc/.java/deployment/deployment.config':
    ensure => 'present',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

