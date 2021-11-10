package(default_visibility = ["PUBLIC"])

remote_file(
    name = "docker",
    hashes = ["9c0a6d6312dc36e23d8738d2d15d0dfa06cb996ab7f45e0d124cb6d65fbdb40f"],
    url = "https://raw.githubusercontent.com/thought-machine/pleasings/7fa34bc749ff31008680f5d113ad958a73d84e07/docker/docker.build_defs",
)

TERRAFORM_DEF_VERSION = "0385c38ae86becc619e8fcb98644ee98e403f63f"

remote_file(
    name = "terraform",
    url = f"https://raw.githubusercontent.com/thought-machine/pleasings/{TERRAFORM_DEF_VERSION}/terraform/terraform.build_defs",
    hashes = ["8a4477f00d81f0670bfae8ce21fe1976a39d164c074ce2c32c1b57f0e9069230"],
    visibility = ["PUBLIC"],
)

# remote_file(
#     name = "plz_tool",
#     url = f"https://raw.githubusercontent.com/thought-machine/pleasings/{TERRAFORM_DEF_VERSION}/terraform/scripts/terraform.sh",
#     hashes = ["56c1aad366aa3374a9d3e09c3f388d913498cddf5a9f7c0c39ee69d9329d8641"],
#     visibility = ["PUBLIC"],
#     binary = True,
# )

sh_binary(
    name = "plz_tool",
    main = "terraform.sh",
    visibility = ["PUBLIC"],
)
