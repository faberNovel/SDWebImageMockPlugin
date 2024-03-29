# Change Log
All notable changes to this project will be documented in this file.
`CompositionalLayoutDSL` adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

## [0.1.0] - 2022-02-28Z

### Created

#### Classes
- `ImageCacheMocker`

#### Structures
- `ImageProvider`

#### Extensions
- `ImageProvider.sizeImageProvider`
- `ImageProvider.ratioImageProvider`
- `ImageProvider.bundleImageProvider(bundlesWithIdentifiers:)`

#### External extensions
- `URL.imageMock(forWidth: Double, height: Double)`
- `URL.imageMock(withRatio ratio: Double)`
- `URL.imageMock(named imageName: String, inBundleID bundleID: String)`
