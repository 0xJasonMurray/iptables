class iptables::servers {

  # Init the variable in case there is no rules for the host
  $hostv4_rules = ''
  $hostv6_rules = ''

  # First hosts rules
  if $fqdn == 'ubuntu.example.com' {
    $hostv4_rules = [
      '-A INPUT-HOSTSPECIFIC -m state --state NEW -m tcp -p tcp --dport 80 -m comment --comment "Web server" -j ACCEPT',
      '-A INPUT-HOSTSPECIFIC -m state --state NEW -m tcp -p tcp --dport 443 -m comment --comment "Web server" -j ACCEPT',
      '-A INPUT-HOSTSPECIFIC -m state --state NEW -m tcp -p tcp --dport 8140 -m comment --comment "Puppet Master" -j ACCEPT',
    ]
    $hostv6_rules = [
      '-A INPUT-HOSTSPECIFIC -m state --state NEW -m tcp -p tcp --dport 80 -m comment --comment "Web server" -j ACCEPT',
      '-A INPUT-HOSTSPECIFIC -m state --state NEW -m tcp -p tcp --dport 443 -m comment --comment "Web server" -j ACCEPT',
    ]
  }

  # Second hosts rules
  if $fqdn == 'centos.example.com' {
    $hostv4_rules = [
      '-A INPUT-HOSTSPECIFIC -m state --state NEW -m tcp -p tcp --dport 80 -m comment --comment "Web server" -j ACCEPT',
      '-A INPUT-HOSTSPECIFIC -m state --state NEW -m tcp -p tcp --dport 443 -m comment --comment "Web server" -j ACCEPT',
    ]
    $hostv6_rules = [
      '-A INPUT-HOSTSPECIFIC -m state --state NEW -m tcp -p tcp --dport 80 -m comment --comment "Web server" -j ACCEPT',
      '-A INPUT-HOSTSPECIFIC -m state --state NEW -m tcp -p tcp --dport 443 -m comment --comment "Web server" -j ACCEPT',
    ]
  }

}
