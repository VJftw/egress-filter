subinclude("//third_party/defs:terraform")

terraform_root(
    name = "gcp",
    srcs = [
        "main.tf",
        "vpc.tf",
        "subnets.tf",
    ],
    modules = [
        "//deploy/module/gcp:gcp",
    ]
)
