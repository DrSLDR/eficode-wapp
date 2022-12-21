# Ansible Component

In this component, I include, as requested, _several_ playbooks which install Docker
and, later, deploy our weather app. I just want to state for the record that the way I
would normally have done this is to write one large playbook with multiple, tagged
plays, but I will follow the letter of the instructions.

**General note:** I _normally_ maintain a small library of roles that do often repeated
tasks. Since I don't host them publicly anywhere, I will just inline their functionality
into the playbook here, marking where they start and end.

## Inventory

**Note:** The inventory is currently set up in a very simple manner. Under normal
circumstances, I would enumerate things like administrator accounts to create and SSH
keys to pull, but that's _a little_ out of scope here. Moreover, the IP listed as the
server to connect to is the Google Cloud instance that I was using during development.
There is no guarantee that _that specific IP_ will work, nor that you will have access
to it.

That being said, the inventory contains the key information needed to run any of the
playbooks contained in this directory. Specifically, it contains the following
information:

* The `cert_email`, informing Let's Encrypt of who to contact with certificate expiry
  notices.
* The `domain` for which to request a certificate (and configure `nginx`).
* The `ansible_host` for the `test-instance` that we want to operate on.
* The `development` flag determines if Docker Compose should also be installed on the
  server, so it can be used for Compose development.

## Provisioning playbook

The `provision.yml` file contains the play which provisions a new (Ubuntu) server to get
it ready to host our weather app. The point of this playbook is to install and configure
system users and core system applications.

**Note:** Under normal circumstances, the first step in my Ansible work would be to set
up an `ansible` user to be used specifically for all Ansible access. However, that's a
little beyond the scope of what we're trying to do here.

To invoke the provisioning playbook, just run
```
ansible-playbook -i inventory.yml provision.yml
```

### Synopsis

1. Perform a general system update
2. Installs [neofetch](https://github.com/dylanaraps/neofetch), patches it, and sets it
   as systemwide MOTD.
3. Installs/ensures and configures UFW
4. Creates/ensures a usergroup that allows sudo
5. Creates a new user and grants it sudo
6. Flush registered handlers (possibly rebooting)
7. Installs Docker & Docker Compose
8. Adds our users to the Docker group
9. Installs nginx, for use as a proxy later
10. Installs certbot
11. Install administration tools


## Deploy playbook

The `deploy.yml` file contains a play which, given a server provisioned using the
playbook above, installs the Docker Images needed to run the weather service, sets it up
as a `systemd` service, starts it, adds an `nginx` proxy, and makes sure that has a TLS
certificate (via Let's Encrypt).

A couple of notes:
* Firstly, the `docker-compose.yml` file, in `files/` is a slight modification from the
  one used in the Docker component. Specifically, this does _not_ expose the source
  files as volumes, and adds an environment variable to the Frontend image so that it
  will call the API at a different URL. Specifically, it will use the same URL as the
  Frontend, where the `/api` redirect gets handled by `nginx`.
* We are not assuming any Docker registry will be available to pull our images from, nor
  do we want to build them on-server. Consequently **this playbook requires the Docker
  images are build on the local machine** using the `docker/build.sh` script. Images
  with those names will be exported, and the resulting tarball will be sent to the
  server.

### Synopsis

1. Prepare a directory where the Docker Compose file can live
2. Transfer the Docker images
   1. [Localhost] Create a temporary directory and save out the images there
   2. Copy the images to the host
   3. Load the tarballs into Docker
   4. [Localhost] Destroy the temporary directory
   5. Destroy the tarballs
