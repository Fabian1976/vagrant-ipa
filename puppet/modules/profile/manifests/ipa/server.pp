class profile::ipa::server (
  String            $version,
  String            $domain,
  String            $dm_password,
  String            $admin_password,
  Boolean           $managed         = false,
  Boolean           $manage_firewall = true,
  Optional[String]  $shell           = '/bin/bash',
  Optional[Boolean] $dns             = false,
) {
  if $managed {
    class { '::ipa::server':
      version         => $version,
      domain          => $domain,
      dm_password     => $dm_password,
      admin_password  => $admin_password,
      shell           => $shell,
      dns             => $dns,
      manage_firewall => $manage_firewall,
    }
  } elsif $manage_firewall {
    class { '::ipa::firewall':
      dns => $dns,
    }
  }
}
