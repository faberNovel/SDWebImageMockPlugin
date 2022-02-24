//
//  ImageProvider+DefaultProviders.swift
//  
//
//  Created by Alexandre Podlewski on 24/02/2022.
//

import UIKit

extension Array where Element == ImageProvider {
    public static var defaultProviders: [ImageProvider] {
        [
            .sizeImageProvider,
            .ratioImageProvider,
            .bundleImageProvider(bundlesWithIdentifiers: ["main": Bundle.main])
        ]
    }
}

extension ImageProvider {

    public static var sizeImageProvider = ImageProvider(scheme: "size") { url in
        guard
            let dimensions = url.host?.split(separator: "x").compactMap({ Double($0) }),
            dimensions.count == 2,
            isValidSize(width: dimensions[0], height: dimensions[1])
        else { fatalError("Invalid url format") }

        return UIImage.placeholder(width: dimensions[1], height: dimensions[0])
    }

    public static var ratioImageProvider = ImageProvider(scheme: "ratio") { url in
        let imageHeight: Double = 500
        guard
            let stringWidthFactor = url.host,
            let widthFactor = Double(stringWidthFactor),
            widthFactor > 0,
            url.path.count > 1,
            let stringHeightFactor = url.path[url.path.index(after: url.path.startIndex)...].removingPercentEncoding,
            let heightFactor = Double(stringHeightFactor),
            heightFactor > 0,
            let imageWidth = .some(imageHeight * (widthFactor / heightFactor)),
            isValidSize(width: imageWidth, height: imageHeight)
        else { fatalError("Invalid url format") }

        return UIImage.placeholder(width: imageWidth, height: imageHeight)
    }

    public static func bundleImageProvider(bundlesWithIdentifiers bundles: [String: Bundle]) -> ImageProvider {
        ImageProvider(scheme: "bundle") { url in
            guard
                let bundleIdentifier = url.host,
                url.path.count > 1,
                let imageName = url.path[url.path.index(after: url.path.startIndex)...].removingPercentEncoding
            else { fatalError("Invalid url format") }

            guard
                let bundle = bundles[bundleIdentifier],
                let image = UIImage(named: imageName, in: bundle, compatibleWith: nil)
            else { fatalError("Image not found in bundle \(bundleIdentifier)") }

            return image
        }
    }

    // MARK: - Private

    private static func isValidSize(width: Double, height: Double) -> Bool {
        return width > 0 && height > 0
    }
}
