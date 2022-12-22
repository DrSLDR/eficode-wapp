# Cloud Component

In this component, I will include a short Terraform definition which creates a small
Google Cloud compute instance (within their free tier), which can then be further
configured using the Ansible Component.

## Requirements

* A Google Cloud Project and associated service account (see [this
  documentation](https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build#set-up-gcp),
  bullet 3 for instructions on exactly how to create that). The resultant JSON key
  should be stored in `cloud/key.json`, relative to the repository root.
* Your Google Cloud Project needs to have the Compute Engine API enabled.
* The following environment variables set:
  * `TF_VAR_GCP_PROJECT`: name of your GCP project
  * Optionally:
    * `TF_VAR_GCP_REGION`: region to work in for GCP (`us-west1` by default)
    * `TF_VAR_GCP_ZONE`: zone in the region (`us-west1-a` by default)
    * `TF_VAR_GCP_SSH_KEYS`: SSH key metadata string (see [GCP
    Documentation](https://cloud.google.com/compute/docs/metadata/default-metadata-values#project-attributes-metadata)
    for details; defaults to my SSH key.)
    * `TF_VAR_GCP_CE_TYPE`: Machine type of the Google Cloud Compute Engine instance
    (see [GCP
    Documentation](https://cloud.google.com/compute/docs/general-purpose-machines#e2-shared-core)
    for details; defaults to `e2-micro`.)

**Note:** This Terraform definition uses local state storage. This is done for the
purposes of this evaluation only --- for _any_ shared environment, the TF State should
be placed in a shared location.

## Usage

To use the Instance Terraform, start by initializing Terraform using
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
