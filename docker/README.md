# Docker Component

In this component, I include some useful scripts for wrangling the Docker containers for
the front- and backend. The Dockerfiles, which are also part of this component, have to
go live in their respective directory.

## `build.sh`

The build script is a simple shell script that ensures that both Docker containers are
built using known names on the local machine.

Before running the build script, you must set the following environment variables:
* `OWM_API_KEY`: The Open Weather Map API key. This is fed into the backend container
  during build time, so is never stored on disk or in the repository.
