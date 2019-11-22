// swift-tools-version:5.0

import PackageDescription

let package = Package(
  name: "EvDev",
  products: [
    .library(name: "EvDev", targets: ["EvDev"]),
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "EvDev",
      dependencies: ["Clibevdev"]
    ),
    .systemLibrary(
      name: "Clibevdev", 
      pkgConfig: "libevdev", 
      providers: [
        .apt(["libevdev-dev"])
      ]),
  ]
)
