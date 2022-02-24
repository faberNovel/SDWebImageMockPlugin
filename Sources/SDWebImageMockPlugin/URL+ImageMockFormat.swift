//
//  URL+ImageMockFormat.swift
//  
//
//  Created by Alexandre Podlewski on 24/02/2022.
//

import Foundation

// swiftlint:disable force_unwrapping

extension URL {

    /// Return an url with the format expected by `ImageResolver.sizeImageProvider`
    public static func imageMock(forWidth width: Double, height: Double) -> URL {
        return URL(string: "size://\(width)x\(height)")!
    }

    /// Return an url with the format expected by `ImageResolver.ratioImageProvider`
    public static func imageMock(withRatio ratio: Double) -> URL {
        return URL(string: "ratio://\(ratio)/1")!
    }

    /// Return an url with the format expected by `ImageResolver.bundleImageProvider(bundlesWithIdentifiers:)`
    ///
    /// To work properly, the bundleId must have been configured in the Mocker.
    public static func imageMock(named imageName: String, inBundleID bundleID: String) -> URL {
        let bundleIDCharacters = CharacterSet(charactersIn: bundleID)
        assert(bundleIDCharacters.isSubset(of: CharacterSet.urlHostAllowed), "Invalid characters in bundleID")
        let imageName = imageName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        return URL(string: "bundle://\(bundleID)/\(imageName)")!
    }
}
