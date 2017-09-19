class profile::ipa::server {
  include ipa::server

  ipa_forwardzonerecord { 'windows.cmc.lan':
    ensure         => absent,
    forwarder      =>   '10.10.10.116'
  }

  $httpports = ['80','443']
  $ldapport = '389'
  $slapport = '636'
  $kerberosports = ['88','464']
  $iptable_entries = {
    '200 IPA http' => {
      chain  => $::input_chain_name,
      proto  => 'tcp',
      action => 'accept',
      dport  => $httpports
    },
    '200 IPA ldap' => {
      chain  => $::input_chain_name,
      proto  => 'tcp',
      action => 'accept',
      dport  => $ldapport
    },
    '200 IPA slap' => {
      chain  => $::input_chain_name,
      proto  => 'tcp',
      action => 'accept',
      dport  => $slapport
    },
    '200 IPA kerberos' => {
      chain  => $::input_chain_name,
      proto  => 'tcp',
      action => 'accept',
      dport  => $kerberosports
    },
  }
  create_resources('firewall', $iptable_entries)
}

