normal['repose']['header_normalization']['whitelist'] = [
  { 'id' => 'headers',
    'headers' => ['Auth-Token', 'Host'] }
]
normal['repose']['header_normalization']['blacklist'] = []

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
