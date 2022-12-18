# Cloud Component

In this component, I will include two short Terraform definitions --- `instance` and
`k8s`. One will create a small Google Cloud compute instance (within their free tier),
which can then be further configured using the Ansible Component. The other will create
a Google Cloud k8s cluster and deploy the app to it.

## Common requirements

* A Google Cloud Project and associated service account (see [this
  documentation](https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build#set-up-gcp),
  bullet 3 for instructions on exactly how to create that). The resultant JSON key
  should be stored in `cloud/gcp_key.json`, relative to the repository root.

**Note:** Both Terraform definitions use local state storage. This is done for the
purposes of this evaluation only --- for _any_ shared environment, the TF State should
be placed in a shared location.

## Instance

Terraform variant which simply creates a simple Google Cloud Compute Engine instance
which can then be used to deploy the Ansible Component on, or for general development.

### Specific requirements

In addition to the common requirements listed above, this variant requires:

* Your Google Cloud Project needs to have the Compute Engine API enabled.

### Usage

To use the Instance Terraform, navigate into the `instance` directory and initialize
Terraform using
```
terraform init
```

You can, if you so wish, validate the Terraform configuration by running
```
terraform validate
```

## k8s

Terraform variant which creates a _whatever the Google Cloud k8s thing is called_ and
deploys our Weather app to it.

### Specific requirements

In addition to the common requirements listed above, this variant requires:

* The k8s api thing enabled
* A personal Dockerhub (or another Docker registry) account and credentials, where the
  Weather app docker containers are pushed. Terraform is (regrettably) _not_ able to
  pull Docker images from the local machine, so some third party host is required.
