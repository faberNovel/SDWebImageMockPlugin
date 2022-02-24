//
//  ImageProvider.swift
//
//
//  Created by Alexandre Podlewski on 24/02/2022.
//

import UIKit

/// This structure is responsible for provide image for urls with the specified scheme
public struct ImageProvider {
    let scheme: String
    let imageProvider: (URL) -> UIImage?

    public init(scheme: String, imageProvider: @escaping (URL) -> UIImage?) {
        self.scheme = scheme
        self.imageProvider = imageProvider
    }
}
