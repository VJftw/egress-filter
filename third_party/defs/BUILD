package(default_visibility = ["PUBLIC"])

remote_file(
    name = "docker",
    hashes = ["9c0a6d6312dc36e23d8738d2d15d0dfa06cb996ab7f45e0d124cb6d65fbdb40f"],
    url = "https://raw.githubusercontent.com/thought-machine/pleasings/7fa34bc749ff31008680f5d113ad958a73d84e07/docker/docker.build_defs",
)

TERRAFORM_DEF_VERSION = "97b76773815d36aa1571408aa482767574c5e2a7"

remote_file(
    name = "terraform",
    url = f"https://raw.githubusercontent.com/VJftw/pleasings/{TERRAFORM_DEF_VERSION}/terraform/terraform.build_defs",
    hashes = ["86cd7bc96df478bbae96f9de5709cdc6caf8f9d3d474f03b9927c3fc0d065e83"],
    visibility = ["PUBLIC"],
)

remote_file(
    name = "plz_tool",
    url = f"https://raw.githubusercontent.com/VJftw/pleasings/{TERRAFORM_DEF_VERSION}/terraform/scripts/terraform.sh",
    hashes = ["4fd4e78b33205a6ccc8b902709e919f5e4be42f9f2ecca9a53757949efc14055"],
    visibility = ["PUBLIC"],
    binary = True,
)
