default['repose']['version'] = '8.5.0.1'
default['repose']['owner'] = 'repose'
default['repose']['group'] = 'repose'

normal['repose']['header_normalization']['whitelist'] = [
  { 'id' => 'headers',
    'headers' => ['Auth-Token', 'Host'] }
]
normal['repose']['header_normalization']['blacklist'] = []

default['java']['jdk_version'] = '8'
default['java']['remove_deprecated_packages'] = true
default['java']['oracle']['accept_oracle_download_terms'] = true

default['repose']['keystone_v2']['username_admin'] = 'dimatest'
default['repose']['keystone_v2']['password_admin'] = 'dimapassword'
default['repose']['keystone_v2']['uri'] = 'https://identity.dimitryushakov.com'

default['repose']['url_extractor_to_header']['extractor_headers'] = [
  {
    'name' => 'User',
    'url-regex' => '/users/(.*)/devices',
    'default' => 'standard'
  }
]

default['repose']['endpoints'] = [{
  cluster_id: 'repose',
  id: 'responder',
  protocol: 'http',
  hostname: 'localhost',
  port: '8000',
  root_path: '/',
  default: true
}]
