package(default_visibility = ["PUBLIC"])

go_toolchain(
    name = "tool",
    hashes = [
        "be333ef18b3016e9d7cb7b1ff1fdb0cac800ca0be4cf2290fe613b3d069dfe0d",  # linux-amd64
    ],
    version = "1.16.6",
)

go_module(
    name = "terratest",
    install = [
        "modules/terraform",
        "modules/http-helper",
        "modules/logger",
        "modules/testing",
        "modules/retry",
        "modules/collections",
        "modules/shell",
        "modules/ssh",
        "modules/files",
    ],
    module = "github.com/gruntwork-io/terratest",
    version = "v0.37.11",
    licences = ["Apache-2.0"],
    deps = [
        ":stretchr_testify",
        ":x_net",
        ":x_crypto",
        ":hashicorp_multierror",
        ":jinzhu_copier",
        ":hashicorp_terraform-json",
        ":hashicorp_hcl2",
    ]
)

go_module(
    name = "stretchr_testify",
    module = "github.com/stretchr/testify",
    install = [
        "assert",
        "require",
    ],
    version = "v1.7.0",
    licences = ["MIT"],
    deps = [
        ":davecgh_spew",
        ":pmezard_difflib",
        ":yaml_v3",
    ],
)

go_module(
    name = "davecgh_spew",
    module = "github.com/davecgh/go-spew",
    install = ["spew"],
    licences = ["ISC"],
    version = "v1.1.1"
)

go_module(
    name = "pmezard_difflib",
    module = "github.com/pmezard/go-difflib",
    install = ["difflib"],
    version = "v1.0.0",
    licences = ["BSD-3-Clause"],
)

go_module(
    name = "yaml_v3",
    module = "gopkg.in/yaml.v3",
    version = "496545a6307b2a7d7a710fd516e5e16e8ab62dbc",
    licences = ["Apache-2.0", "MIT"],
)

go_module(
    name = "x_net",
    module = "golang.org/x/net",
    install = ["context"],
    licences = ["BSD-3-Clause"],
    version = "v0.0.0-20210928044308-7d9f5e0b762b",
)

go_module(
    name = "x_crypto",
    module = "golang.org/x/crypto",
    install = [
        "ssh",
        "ssh/agent",
        "ed25519",
        "chacha20",
        "internal/poly1305",
        "curve25519",
        "ssh/internal/bcrypt_pbkdf",
        "internal/subtle",
        "curve25519/internal/field",
        "blowfish",
    ],
    licences = ["BSD-3-Clause"],
    version = "v0.0.0-20210921155107-089bfa567519",
)

go_module(
    name = "hashicorp_multierror",
    module = "github.com/hashicorp/go-multierror",
    licences = ["MPL-2.0"],
    version = "v1.1.1",
    deps = [
        ":hashicorp_errwrap"
    ]
)

go_module(
    name = "hashicorp_errwrap",
    module = "github.com/hashicorp/errwrap",
    licences = ["MPL-2.0"],
    version = "v1.1.0",
)

go_module(
    name = "jinzhu_copier",
    module = "github.com/jinzhu/copier",
    licences = ["MIT"],
    version = "v0.3.2",
)

go_module(
    name = "hashicorp_terraform-json",
    module = "github.com/hashicorp/terraform-json",
    licences = ["MPL-2.0"],
    version = "v0.12.0",
    deps = [
        ":zclconf_cty",
    ]
)

go_module(
    name = "zclconf_cty",
    module = "github.com/zclconf/go-cty",
    install = [
        "cty",
        "cty/function",
        "cty/function/stdlib",
        "cty/convert",
        "cty/gocty",
        "cty/json",
        "cty/set",
    ],
    licences = ["MIT"],
    version = "v1.9.1",
    deps = [
        ":x_text",
        ":apparentlymart_textseg",
    ]
)

go_module(
    name = "x_text",
    module = "golang.org/x/text",
    install = [
        "unicode/norm",
        "transform",
    ],
    version = "v0.3.7",
    licences = ["BSD-3-Clause"],
)

go_module(
    name = "hashicorp_hcl2",
    module = "github.com/hashicorp/hcl/v2",
    version = "v2.10.1",
    install = [
        ".",
        "hclparse",
        "json",
        "hclsyntax",
        "ext/customdecode",
    ],
    licences = ["MPL-2.0"],
    deps = [
        ":mitchellh_wordwrap",
        ":zclconf_cty",
        ":agext_levenshtein",
        ":apparentlymart_textseg",
    ]
)

go_module(
    name = "mitchellh_wordwrap",
    module = "github.com/mitchellh/go-wordwrap",
    version = "v1.0.1",
    licences = ["MIT"],
)

go_module(
    name = "agext_levenshtein",
    module = "github.com/agext/levenshtein",
    version = "v1.2.3",
    licences = ["Apache-2.0"],
)

go_module(
    name = "apparentlymart_textseg",
    module = "github.com/apparentlymart/go-textseg/v13",
    install = [
        "textseg",
    ],
    version = "v13.0.0",
    licences = ["Apache-2.0", "MIT", "Unicode-DFS-2016"],
)

go_module(
    name = "inet_tcpproxy",
    module = "inet.af/tcpproxy",
    version = "v0.0.0-20210824174053-2e577fef49e2",
    licences = ["Apache-2.0"],
)
