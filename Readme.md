TITLE: Vagrant based APICAST development.
=======================================================================

This project allows you to stand up a vagrant based VM, bootstrapped using ansible to compile / configure the apicast gateway.

This will allow you to write LUA on your host and the changes be picked up directly in on the gateway.


//necessary to sync the host and client.
 vagrant rsync-auto

 //
 turn off the luacache under /apicast_home/apicast/conf/nginx.conf

Prerequisites
=============
A running Vagrant installation - typically virtualbox + vagrant.
You will also need to have Ansible installed.

You will need to go onto the 3Scale portal and configure an API to manage.

Installation.
=============

Check out the apicast gateway under the root of this project
 So:

  $APICAST_WORKBENCH_HOME/apicast-3.0.0

#######################################
#### VARS You WILL have to customise
#######################################

Now edit the start script found under
$APICAST_WORKBENCH_HOME/bin

Update the gateway with your 3Scale params.

GATEWAY_URI: "@somedomain-admin.3scale.net"
GATEWAY_TOKEN: "ec255f933asl3302lsf075b8e1c767ea9206ac885ef744f657bc3c279a"



- vars you might have to customise.
if you are NOT using version 3.0.0 of apicast then you will need to edit the vars/defaults.yml

and particularly the line:
apicast_deployment: apicast-3.0.0



The redhat SSO param may not be necessary depending on whether or not you wish to have Oauth2 working.


Once this is done then type 'vagrant up' - vagrant will spin up your new gateway vm and then provision it using the ansible playbooks being bootstrapped.
-- Look at the Vagrantfile to see how this is done.
The apicast you cloned will be the apicast that gets compiled and run as the gateway.


Once this has finished then type 'vagrant rsync-auto' - this will sync your host workspace to that of the vagrant machine.



Playtime.
=============
Now open up a couple of terminals - I suggest four.
if you get a permissions issue then chmod 777 * - never to be used for anything that looks like production!

1. from here you will run the vagrant up / halt / destroy / provision /  rsync-auto, so you will always be on the host with this term.

2. (make sure you are at the root of $APICAST_WORKBENCH_HOME) then type 'vagrant ssh' you are now on the box.
  Type cd /vagrant and you should now be in the root of the synced APICAST_WORKBENCH_HOME.
  from here cd ./bin then type ./apicast.sh start
  (You might need to be root here - sudo su, vagrant if it wants a password.)

  ./apicast.sh stop - kills the nginx proxy.

  you are on the vm on this term.

3. (make sure you are at the root of $APICAST_WORKBENCH_HOME) then type 'vagrant ssh' you are now on the box.
  Type cd /vagrant and you should now be in the root of the synced APICAST_WORKBENCH_HOME.
  then cd /vagrant/apicast-3.0.0/apicast/logs
  tail -f error.log

you are on the vm on this term.

4. (make sure you are at the root of $APICAST_WORKBENCH_HOME) then type 'vagrant ssh' you are now on the box.
  Type cd /vagrant and you should now be in the root of the synced APICAST_WORKBENCH_HOME.
  then cd /vagrant I would use this one for misc. poking about!

you are on the vm on this term.

The apicast proxy should be reachable from the host using curl or a browser on the IP of http://192.168.33.10:8080/your_stuff


Your custom lua code will be placed under the the following path - via an editor on the host.
$APICAST_WORKBENCH_HOME/apicast-3.0.0/apicast/src


One last thing....
===================
Make certain that you are calling proxy via the same entered value in the 'public api' section of the portal.

So in otherwords the value that you type to call this proxy might look something like this:

curl -v -X GET "http://192.168.33.10:8080/search?term=beyonce&entity=musicVideo&user_key=7b86fdea742e29594449ab12f0b487c0"

NOTE:

Your user_key is not the access_token used previously, so in the above connection string we are using the user_key,
this allows the gateway to auth. against the portal.


The 'http://192.168.33.10' must appear in your 'Public Base URL' in the api definition within the portal.

Finally
========
Enjoy!


Vagranting...

from the directory containing the Vagrantfile :

vagrant up - starts the vm (and provision)
vagrant provision - run the playbook on the vm.
vagrant destroy - flatten and start again.
vagrant ssh - takes you into the vm.
-- vagrant will map the root of your project (where the vagrantfile is located ) to the /vagrant
