# Ansible Component

In this component, I include, as requested, _several_ playbooks which install Docker
and, later, deploy our weather app. I just want to state for the record that the way I
would normally have done this is to write one large playbook with multiple, tagged
plays, but I will follow the letter of the instructions.

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
