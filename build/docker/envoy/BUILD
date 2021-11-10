subinclude("//third_party/defs:docker")

docker_image(
    name = "image",
    srcs = [
        "config.yaml",
    ],
    dockerfile = "Dockerfile",
    image = "envoy",
    run_args = "--env DOMAIN_WHITELIST=.google.com,bbc.com --publish 9901:9901 --publish 443:443",
)
