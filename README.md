# Turbit-task
Setting up a MongoDB server on Ubuntu Machine

Terraform is used to define AWS resources for setting up a primary and backup MongoDB server with security groups. This helps provide a consistent and reproducible infrastructure. 

Ansible is then used to configure the MongoDB servers:
1.	Enabling SSH Access. Some setups of managed nodes may not allow you to log in as root. As this may be problematic later, a playbook (enable-root-access.yml) to resolve this. This is saved in the role common. 
2.	The necessary inventory file is provided (inventory.ini) contains details of the two servers. primary-mongodb and backup-mongodb.
3.	The main-mongodb-server.yml in the main-db role is designed to configure a MongoDB server. It performs various tasks such as adding MongoDB APT keyring, adding the MongoDB repository, installing MongoDB, creating MongoDB users, enabling remote connections and authentication, and managing MongoDB service.
4.	The mongodb-backup.yml file in the backup-db role is configuring a MongoDB backup server. 
5.	The setup-openvpn.yml file sets up an OpenVPN connection between database servers. It installs OpenVPN on the database servers, generates OpenVPN configuration, forwards between clients, starts the OpenVPN service, and starts the OpenVPN Client as well. 
6.	Main.yml playbook is the main playbook. It is written such that all the individual tasks and plays are run together for use readability, layout and reusability. 
