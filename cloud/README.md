# Cloud Component

In this component, I will include two short Terraform definitions --- `instance` and
`k8s`. One will create a small Google Cloud compute instance (within their free tier),
which can then be further configured using the Ansible Component. The other will create
a Google Cloud k8s cluster and deploy the app to it.

Both will require a Google Cloud API key, stored in the environment variable
`$GCS_API_KEY`. The `k8s` variant will also require a personal Dockerhub (or another
Docker registry) instance with appropriate credentials, in order to pull the Docker
images from somewhere. The `instance` variant does not require that --- indeed, it
doesn't provision the instance at all, but instead defers that to the Ansible component,
which can deploy the Docker images from the local machine using `docker export`.
