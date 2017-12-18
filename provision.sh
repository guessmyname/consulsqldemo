#!/bin/bash

# Step 1 - Get the necessary utilities and install them.
# update and unzip
dpkg -s unzip &>/dev/null || {
	apt-get -y update && apt-get install -y unzip
}
# Step 2 - Copy the upstart script to the /etc/init folder.
cp /vagrant/consul.conf /etc/init/consul.conf


# install consul 
if [ ! -f /usr/local/bin/consul ]; then
	cd /usr/local/bin

	version='1.0.2'
	wget https://releases.hashicorp.com/consul/${version}/consul_${version}_linux_amd64.zip -O consul.zip
	unzip consul.zip
	rm consul.zip

	chmod +x consul
fi

# Step 4 - Make the Consul directory.
mkdir -p /etc/consul.d
mkdir /var/consul

# Step 5 - Copy the server configuration.
cp $1 /etc/consul.d/config.json

# Step 6 - Start Consul
#exec consul agent -config-file=/etc/consul.d/config.json -ui
