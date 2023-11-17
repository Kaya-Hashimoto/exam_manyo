server '54.150.102.5', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/Users/kaya/.ssh/id_rsa'
