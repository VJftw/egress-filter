subinclude("//third_party/defs:docker")

docker_image(
    name = "image",
    srcs = [
        "//build/docker/squid/fs",
        "//cmd/squid-configurer",
    ],
    dockerfile = "Dockerfile",
    image = "vjftw/squid",
    run_args = "--env DOMAIN_WHITELIST=.google.com,bbc.com --publish 3128:3128",
)
