echo "alias r='sudo su'" >> .bashrc 

echo "Install puppet"
package="puppetlabs-release-pc1-xenial.deb"
wget https://apt.puppetlabs.com/$package
sudo dpkg -i $package
sudo apt-get update

sudo rm -rf /var/lib/puppet/ssl

sudo cat > /etc/puppet/puppet.conf << EOF
[main]
logdir=/var/log/puppet
vardir=/var/lib/puppet
ssldir=/var/lib/puppet/ssl
rundir=/run/puppet
factpath=$vardir/lib/facter
prerun_command=/etc/puppet/etckeeper-commit-pre
postrun_command=/etc/puppet/etckeeper-commit-post
certname = puppetmaster.vm.local
dns_alt_names = puppetmaster,puppetmaster.vm.local

[master]
# These are needed when the puppetmaster is run by passenger
# and can safely be removed if webrick is used.
ssl_client_header = SSL_CLIENT_S_DN
ssl_client_verify_header = SSL_CLIENT_VERIFY

[agent]
server = puppetmaster.vm.local
EOF

sudo touch /etc/puppet/manifests/site.pp
sudo apt-get install -y puppet




