Description:

  Puppet module to manage a common set of iptables rules.


Features:

  * Common template for all hosts
  * Basic IPv4 and IPv6 templates included
  * IPv4 and IPv6 support
  * Individual host configuration
  * Easy to understand and configure
  * Tested on Ubuntu 12.04 and CentOS 6


Files:

  * .../templates/iptables-common-v4.erb -> IPv4 iptables template.

    This is a common template that is copied to all systems.


  * .../templates/iptables-common-v6.erb -> IPv6 iptables template.

    This is a common template that is copied to all systems.


  * .../manifets/servers.pp -> Host specific rules go here.



Instructions:

  Customize the template files and the servers.pp for your specific
  site.   Each file includes examples to help with the initial 
  configuration.  



History:

  After looking over the many modules to manage iptables, none of them
  met the specific needs of our organization.   All we needed was a 
  simple system to copy a core set of rules and a method for adding
  rules for one off host specific needs.   

  This module meets our needs.


Known issues:

  * IPv6 rules do not work on Ubuntu < 12.04 and CentOS < 6.   It uses
    iptables modules like 'recent' which are not supported in these older
    versions.

  * Only works on Debian and RedHat class systems.


