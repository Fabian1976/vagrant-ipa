require stdlib

Package {allow_virtual => false}


unless $instance      {$instance      = hiera('instance', 'undef')}
unless $depzone       {$depzone       = hiera('depzone', 'undef')}
unless $platform      {$platform      = hiera('platform', 'cmc')}
unless $organisation  {$organisation  = hiera('organisation','cmc')}


#
# Om de modules compatible te houden tussen RHEL5 en RHEL6, introduceren
# we hier de $input_chain_name variable. Overal waar firewall regels toegevoegd
# worden aan de input chain, dient deze variable gebruikt te worden. 
case $operatingsystemmajrelease {
  '5': {
    $input_chain_name  = 'RH-Firewall-1-INPUT'
    $output_chain_name = 'RH-Firewall-1-OUTPUT'
  }
  '6', '7': {
    $input_chain_name  = 'INPUT'
    $output_chain_name = 'OUTPUT'
  }
  default: {
#    fail('unsuported OS version.')
  }
}

hiera_include('roles')
