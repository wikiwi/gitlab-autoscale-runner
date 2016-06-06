# gitlab-ci-autoscale-runner
gitlab-ci-autoscale-runner is a docker container specialized in creating an [autoscale runner](https://gitlab.com/gitlab-org/gitlab-ci-multi-runner/blob/master/docs/configuration/autoscale.md) for gitlab. The default settings are geared towards creating a runner that allows building docker images.

## Environment Variables
Here are some of the relevant Environment Variables.

| Name | Default | Description |
| ---- |:-------:| ----------- |
| CI_SERVER_URL | https://gitlab.com/ci | The CI endpoint of gitlab |
| REGISTRATION_TOKEN | - | The Runners Registration Token|
| RUNNER_NAME | Autoscale Runner | Name of Runner |
| RUNNER_LIMIT | 5 | Maximum number of machines to be created |
| MACHINE_NAME | gitlab-autoscale-%s | Naming scheme for the VMs |
| MACHINE_MAX_BUILDS | 100 | Maximum builds until a machine is delete |
| MACHINE_IDLE_COUNT | 0 | Number of permanent idling hosts |
| MACHINE_IDLE_TIME | 600 | Seconds after which an idling host is deleted |
| MACHINE_DRIVER | - | Docker Machine driver e.g: 'digitalocean', 'google', 'aws', ... |
| DOCKER_IMAGE | docker:latest | Default image to run builds |
| DOCKER_PULL_POLICY | always | Image Pull Policy |
| DOCKER_PRIVILEDGED | true | Priviledged is required to run docker builds. *Attention*: Only allow trusted builds to run on this runner when this is true |
| CACHE_TYPE | - | Currently only s3 is supported for caching |
| S3_SERVER_ADDRESS | s3.amazonaws.com | Address of S3-compactible endpoint |
| S3_ACCESS_KEY | - | S3 Credentials |
| S3_SECRET_KEY | - | S3 Credentials |
| S3_BUCKET_NAME | - | Name of Bucket in S3 |
| S3_BUCKET_LOCATION | - | Region of Bucket in S3 |
| S3_CACHE_INSECURE | false | If true use http instead of https |
| DIGITALOCEAN_ACCESS_TOKEN | - | Access Token for creating VMs on DigitalOcean |
| DIGITALOCEAN_REGION | nyc3 | Region to run Droplets in |
| DIGITALOCEAN_SIZE | 512mb | Size of Droplets |
| DIGITALOCEAN_IMAGE | coreos-beta | Disk image of Droplets |
| DIGITALOCEAN_SSH_USER | core | SSH user to connect to Droplets |
| GOOGLE_APPLICATION_CREDENTIALS | - | If set docker machine will look for credentials at specified path, otherwise it will use credentials from metadata. Read more [here](https://developers.google.com/identity/protocols/application-default-credentials). |
| GOOGLE_PROJECT | - | Google Project ID |
| GOOGLE_ZONE | us-central1-a | Zone to provision the VM |
| GOOGLE_MACHINE_TYPE | f1-micro | Type of machine to provision |
| GOOGLE_MACHINE_IMAGE | projects/coreos-cloud/global/images/family/coreos-beta | Machine Image ID |
| GOOGLE_SCOPES | https://www.googleapis.com/auth/logging.write | Scopes of provisioned machines |
| GOOGLE_DISK_SIZE | 10 | Size of Disk in GB |
| GOOGLE_DISK_TYPE | pd-standard | Disk type of ephermal disk |
| GOOGLE_USERNAME | core | Username to connect to the VM |
| GOOGLE_USE_INTERNAL_IP | false | Use internal IP when connecting to VM |
| GOOGLE_TAGS | gitlab-autoscale | Tags to be attached to the VMs |
| GOOGLE_PREEMPTIBLE | false | Use preemtible VMs |

## Examples
### Start runner using GCE

    docker run -e CI_SERVER_URL=https://gitlab.example.io/ci \
               -e REGISTRATION_TOKEN=Xz5waDAF4sgfADEXAMPLE \
               -e MACHINE_DRIVER=google \
               -e GOOGLE_PROJECT=my-project \
               -e GOOGLE_APPLICATION_CREDENTIALS=/etc/credentials.json \
               -v $(pwd)/credentials.json:/etc/credentials.json \
               gitlab-runner

### Start runner using DigitalOcean

    docker run -e CI_SERVER_URL=https://gitlab.example.io/ci \
               -e REGISTRATION_TOKEN=Xz5waDAF4sgfADEXAMPLE \
               -e MACHINE_DRIVER=google \
               -e DIGITALOCEAN_ACCESS_TOKEN=2SBxEFaAWDe3AAWDEXAMPLE
               gitlab-runner

## Docker Hub
Automated build is available at the [Docker Hub](https://hub.docker.com/r/wikiwi/gitlab-ci-autoscale-runner).

## TODO
Integrate and document AWS driver.

