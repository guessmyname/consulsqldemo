#!/bin/bash

# Step 1 - Get the necessary utilities and install them.
# update and unzip
dpkg -s unzip &>/dev/null || {
	apt-get -y update && apt-get install -y unzip
}

# Step 2 - Copy the upstart script to the /etc/init folder.
cp /vagrant/consul.conf /etc/init/consul.conf

# Step 3 - Get the Consul Zip file and extract it.  


# install consul 
if [ ! -f /usr/local/bin/consul ]; then
	cd /usr/local/bin

	version='1.0.2'
	wget https://releases.hashicorp.com/consul/${version}/consul_${version}_linux_amd64.zip -O consul.zip
	unzip consul.zip
	rm consul.zip

	chmod +x consul
fi
# step 4 - Get the Consul UI
wget https://dl.bintray.com/mitchellh/consul/0.5.2_web_ui.zip
unzip *.zip
rm *.zip

# Step 5 - Make the Consul directory.
mkdir -p /etc/consul.d
mkdir /var/consul

# Step 6 - Copy the server configuration.
cp $1 /etc/consul.d/config.json

# Step 7 - Start Consul
exec consul agent -config-file=/etc/consul.d/config.json
