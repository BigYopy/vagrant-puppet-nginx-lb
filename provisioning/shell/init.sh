#!/bin/bash

set -e

install_puppet(){
    # Download and Install The release Package
    wget https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb
    sudo dpkg -i puppetlabs-release-pc1-trusty.deb

    # Update Apt Package List
    apt-get update

    # Install Puppet Agent
    apt-get install -y puppet-agent
}

# Main

# Check if Puppet is Already Installed
if ! type puppet > /dev/null;then
    install_puppet
fi

# Install nginx, sudo, nodejs Puppet Modules
/opt/puppetlabs/bin/puppet module install jfryman-nginx
/opt/puppetlabs/bin/puppet module install saz-sudo
/opt/puppetlabs/bin/puppet module install puppetlabs-nodejs

