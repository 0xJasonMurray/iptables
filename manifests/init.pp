class iptables inherits iptables::servers {


  # Fall through rules, indicates there are no host specific rules
  if $hostv4_rules == '' {
    $hostv4_rules = [
      '##',
      '## There are no HOST specific rules for this host',
      '##',
    ]
  }

  # Make sure Ubuntu/Debian has a way to manage iptables files
  if $operatingsystem =~ /Ubuntu|Debian/ {
    package {
      "iptables-persistent": ensure => present;
    }
    service { "iptables-persistent":
      require => Package["iptables-persistent"],
      enable => true,
      hasstatus => true,
      status => "true",
      hasrestart => false
    }
  }

  # Make sure RedHat/CentOS has iptables
  if $operatingsystem =~ /CentOS|RedHat/ {
    package {
      "iptables": ensure => present;
    }

    service { "iptables":
      require => Package["iptables"],
      enable => true,
      hasstatus => true,
      status => "true",
      hasrestart => false
    }

    service { "ip6tables":
      require => Package["iptables"],
      enable => true,
      hasstatus => true,
      status => "true",
      hasrestart => false
    }
  }

  # Make sure UFW is disabled on Ubuntu
  if $operatingsystem =~ /Ubuntu/ {
    exec { "disable_ufw":
      command => "/usr/sbin/ufw disable",
      onlyif => "/usr/sbin/ufw status | /bin/grep 'Status: active'",
    }
  }

  # Copy the IPv4 template
  file { 'iptablesv4':
    name => $operatingsystem ? {
      /(Ubuntu|Debian)/ => '/etc/iptables/rules.v4',
      /(CentOS|RedHat)/ => '/etc/sysconfig/iptables',
    },
    mode => 644,
    owner => root,
    group => root,

    content => template('iptables/iptables-common-v4.erb'),

    require => $operatingsystem ? {
      /(Ubuntu|Debian)/ => Package["iptables-persistent"],
      /(CentOS|RedHat)/ => Package["iptables"],
    },

    notify  => $operatingsystem ? {
      /(Ubuntu|Debian)/ => Service["iptables-persistent"],
      /(CentOS|RedHat)/ => Service["iptables"],
    }
  }

  # Copy the IPv6 template
  file { 'iptablesv6':
    name => $operatingsystem ? {
      /(Ubuntu|Debian)/ => '/etc/iptables/rules.v6',
      /(CentOS|RedHat)/ => '/etc/sysconfig/ip6tables',
    },
    mode => 644,
    owner => root,
    group => root,

    content => template('iptables/iptables-common-v6.erb'),

    require => $operatingsystem ? {
      /(Ubuntu|Debian)/ => Package["iptables-persistent"],
      /(CentOS|RedHat)/ => Package["iptables"],
    },

    notify  => $operatingsystem ? {
      /(Ubuntu|Debian)/ => Service["iptables-persistent"],
      /(CentOS|RedHat)/ => Service["ip6tables"],
    }
  }
}

