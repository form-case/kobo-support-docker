# kobo-support-docker

This repository handles redirection and reverse proxying for our
support-related websites.

* support.kobotoolbox.org:
    1. If the request path matches something in `files/redirections.conf`,
       then the request is redirected;
    1. The request is reverse-proxied to https://kobotoolbox.github.io, which
       is our documentation website.
* help.kobotoolbox.org:
    1. Requests to the base hostname are now redirected to the Discourse forum,
       https://community.kobotoolbox.org;
    1. Requests for anything else are redirected to
       https://support.kobotoolbox.org.
* forum.kobotoolbox.org: this was the very short-lived original hostname for
    our Discourse forum. This redirect could probably be removed, but for
    now, it steers people to https://community.kobotoolbox.org.


This also handles redirection for the "apex" kobotoolbox.org domain and
secondary domain names:

* kobotoolbox.org:
    1. Requests to https://kobotoolbox.org/anything are redirected to
       https://www.kobotoolbox.org/anything;
* kobo.ngo:
    1. Requests to the base hostname and `www` sub-domain are redirected to
       https://www.kobotoolbox.org;
* kobo.ong:
    1. Requests to the base hostname and `www` sub-domain are redirected to
       https://www.kobotoolbox.org;
* eu.kobotoolbox.org:
    1. Requests to the base hostname are redirected to
       https://kobo.humanitarianresponse.info;

## How to use

After making any modifications to the redirect rules or other NGINX
configuration settings, build a new Docker image and push it to Docker Hub. Use
the tag `kobotoolbox/kobo-support-docker`:
```
docker build -t kobotoolbox/kobo-support-docker .
```
Once the build completes, push it to Docker Hub:
```
docker push kobotoolbox/kobo-support-docker
```
The new image can now be used with cloud container services such as AWS ECS.

### AWS Elastic Container Service (ECS)

To update this service running on ECS:
1. Build and push a new Docker image as described above;
1. Go to the ECS "Task definitions", currently at https://us-east-1.console.aws.amazon.com/ecs/v2/task-definitions;
1. Select the latest revision and then click "Create new revision";
1. Verify that "Image URI" is "kobotoolbox/kobo-support-docker:latest";
1. Scroll all the way down and click "Create";
1. You should now be viewing the new revision.
1. Click "Deploy" and choose "Update service";
1. Verify that "Cluster" is "support-redirector-cluster" and "Service" is "support-redirector-service";
1. Scroll all the way down and hit "Update"!
