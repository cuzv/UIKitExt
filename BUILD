load("@build_bazel_rules_apple//apple:resources.bzl", "apple_resource_bundle")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "UIKitExt",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    data = [
        ":UIKitExtResources",
    ],
    module_name = "UIKitExt",
    visibility = [
        "//visibility:public",
    ],
)

apple_resource_bundle(
    name = "UIKitExtResources",
    bundle_name = "UIKitExt",
    resources = glob([
        "Resources/*",
    ]),
)
