class profile::ipa::replica (
  String            $version,
  Boolean           $managed         = false,
  Boolean           $manage_firewall = true,
  Optional[Boolean] $dns             = false,
) {
  if $managed {
    class { '::ipa::replica':
      version         => $version,
      dns             => $dns,
      manage_firewall => $manage_firewall,
    }
  } elsif $manage_firewall {
    class { '::ipa::firewall':
      dns => $dns,
    }
  }
}
