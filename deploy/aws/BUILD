subinclude("//third_party/defs:terraform")

terraform_root(
    name = "aws",
    srcs = [
        "main.tf",
        "vpc.tf",
        "public-subnets.tf",
        "private-subnets.tf",
    ],
    modules = [
        "//deploy/module/aws:aws",
    ]
)
