MySQLFabric
===========

Create a fabric HA cluster with vagrant and virtualbox

This is a complete implementation of a Fabric Cluster with 3 data nodes and a controller node.

Software installed on Windows:-
   git-bash
   vagrant
   virtualbox
   optional - putty (my preferred ssh tool)

Base box is a minimal Centos 6.5 OS with puppet pre-installed and the Mysql 5.6 repo configured.

With that installed, just run 'vagrant up' in the git-bash window.

Uses the puppetlabes mysql engine and stdlibs.
