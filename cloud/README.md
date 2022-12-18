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
* The following environment variables set:
  * `TF_VAR_GCP_PROJECT`: name of your GCP project
  * Optionally:
    * `TF_VAR_GCP_REGION`: region to work in for GCP (`us-west1` by default)
    * `TF_VAR_GCP_ZONE`: zone in the region (`us-west1-a` by default)

**Note:** Both Terraform definitions use local state storage. This is done for the
purposes of this evaluation only --- for _any_ shared environment, the TF State should
be placed in a shared location.

## Instance

Terraform variant which simply creates a simple Google Cloud Compute Engine instance
which can then be used to deploy the Ansible Component on, or for general development.

### Specific requirements

In addition to the common requirements listed above, this variant requires:

* Your Google Cloud Project needs to have the Compute Engine API enabled.
* Optional environment variables:
  * `TF_VAR_GCP_SSH_KEYS`: SSH key metadata string (see [GCP
    Documentation](https://cloud.google.com/compute/docs/metadata/default-metadata-values#project-attributes-metadata)
    for details; defaults to my SSH key.)
  * `TF_VAR_GCP_CE_TYPE`: Machine type of the Google Cloud Compute Engine instance (see
    [GCP
    Documentation](https://cloud.google.com/compute/docs/general-purpose-machines#e2-shared-core)
    for details; defaults to `e2-micro`.)

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

Then, in order to run Terraform, creating the compute instance, run
```
terraform apply
```
Verify that the Terraform plan looks right, then enter `yes` in order to start
Terraform. After some time, Terraform will have finished, and will print out the IP you
can use to connect to your new compute instance (assuming you have set the SSH keys
string accordingly).

Note that the above step may prompt for additional information. If it does that, make
sure you have set all the required environment variables.

Once you are done, you can tear down your instance by running
```
terraform destroy
```
again validating the plan, then confirming by entering `yes`.

## k8s

Terraform variant which creates a _whatever the Google Cloud k8s thing is called_ and
deploys our Weather app to it.

### Specific requirements

In addition to the common requirements listed above, this variant requires:

* The k8s api thing enabled
* A personal Dockerhub (or another Docker registry) account and credentials, where the
  Weather app docker containers are pushed. Terraform is (regrettably) _not_ able to
  pull Docker images from the local machine, so some third party host is required.
