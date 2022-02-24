//
//  ImageResolver.swift
//  
//
//  Created by Alexandre Podlewski on 24/02/2022.
//

import UIKit

struct ImageResolver {

    static let defaultImage = UIImage.placeholder(width: 500, height: 500)

    private var providers: [String: ImageProvider] = [:]

    // MARK: - ImageCache

    mutating func registerProvider(_ provider: ImageProvider) {
        providers[provider.scheme] = provider
    }

    func image(for url: URL) -> UIImage {
        guard
            let scheme = url.scheme,
            let provider = providers[scheme],
            let image = provider.imageProvider(url)
        else {
            return Self.defaultImage
        }
        return image
    }
}
