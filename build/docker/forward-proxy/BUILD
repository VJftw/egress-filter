subinclude("//third_party/defs:docker")

docker_image(
    name = "image",
    srcs = [
        "//cmd/forward-proxy",
    ],
    dockerfile = "Dockerfile",
    image = "forward-proxy",
    run_args = "--env DOMAIN_WHITELIST=.google.com,bbc.com --publish 443:443",
)
