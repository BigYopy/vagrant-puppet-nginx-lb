class site::profile::helloapp inherits site::profile::nodeapp {

  # Create App dir
  file { '/opt/helloapp':
    ensure => directory,
	owner  => 'www-data',
	group  => 'www-data',
	mode   => '0755',
  }

  # Deploy App script
  file { '/opt/helloapp/app.js':
    ensure  => present,
	owner   => 'www-data',
	group   => 'www-data',
	mode    => '0644',
	content => template('site/hello-js.erb'),
	require => File['/opt/helloapp'],
  }

  # deploy Upstart script
  file { '/etc/init/helloapp.conf':
    ensure => present,
	owner  => 'root',
	group  => 'root',
	mode   => '0644',
	source => 'puppet:///modules/site/helloapp-init.conf',
  }

  # Run helloapp service
  service {'helloapp':
    ensure => running,
	enable => true,
  }

  Package['nodejs'] -> Service['helloapp']
  File['/opt/helloapp/app.js'] ~> Service['helloapp']
  File['/etc/init/helloapp.conf'] ~> Service['helloapp']
  
}