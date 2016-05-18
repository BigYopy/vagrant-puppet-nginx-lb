# vagrant-puppet-nginx-lb

####Table of Contents

1. [Overview](#overview)
    * [Project layout](#project-layout)
2. [Setup](#setup)
    * [Setup requirements](#setup-requirements)
    * [Getting started](#getting-started)
    * [More information](#more-information)

###Overview
In this project i am using puppet and vagrant to build an example of nginx loadbalancing
```
####Project layout

  /vagrant-puppet-nginx-lb
      /provisioning
          /shell                                  # Shell Provisioning: Install Puppet And required Modules                          
          /puppet                                 # Puppet Provisioning
              /data                               # Hiera Data Dir
              /environments                       # Environments Dir
                  /production
                      /manifests
                          /site.pp                # Main Manifest file
                      /modules
                          /site
                            /manifests
                                /profile          # Profile Classes
                            /templates
                            /files
                      /environment.conf
              /hiera.yaml                         # Hiera Config File
      Vagranfile
```
i used Puppet roles and profiles pattern to configure project's VMs:
* loadblancer: Applied to Nginx Load balancer and used to install nginx and configure load balancing
* helloapp: Applied to web application backends and used to install nodejs and deploy hello app application

###Setup
####Setup Requirements

* Install Vagrant: https://www.vagrantup.com/downloads.html
* clone https://github.com/BigYopy/vagrant-puppet-nginx-lb.git  repository
```
git clone https://github.com/BigYopy/vagrant-puppet-nginx-lb.git
```

###Getting Started

To run vagrant environment:
```
cd vagrant-puppet-nginx-lb
vagrant up
```

###More Information

