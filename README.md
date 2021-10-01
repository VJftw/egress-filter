# egress-proxy

This project aims to provide a **cloud agnostic** VPC egress filter appliance which replaces the role of a NAT instance as presented in the [*How to add DNS filtering to your NAT instance with Squid* AWS Blog post](https://aws.amazon.com/blogs/security/how-to-add-dns-filtering-to-your-nat-instance-with-squid/) using free and open-source technologies.


## High Availability

Use a load balancer and auto-scaling-groups with healthchecks.

### Self Healing

Use a "witness" instance in another AZ to verify if the current instance is healthy. If it's not, become the current instance and terminate the unhealthy instance. A new back-up should be created.

## Configuration Changes / Updates

Terraform, utilise ASG health-checking

### New instance

Replace the backup instance, then mark the current instance as unhealthy.


## Logging

Ship access logs to Cloud provider storage (S3, GCS). 

Also optionally output logs to Cloud provider logging (CloudWatch, StackDriver).

## Monitoring

 * Prometheus (can be scraped or via pushgateway?)
 * CSP monitoring (CloudWatch, StackDriver)
