class redis {


  $ROOT_DIR = '/usr/local'

  $packages = ["wget", "gcc"]
  package { $packages: ensure => "installed"}

}