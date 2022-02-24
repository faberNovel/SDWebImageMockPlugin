//
//  ImageCacheMocker.swift
//  
//
//  Created by Alexandre Podlewski on 23/02/2022.
//

import Foundation
import UIKit
import SDWebImage

// swiftlint:disable discouraged_optional_collection

/// This cache make possible to mock images requested by SDWebImage.
///
/// When installed it will returns an image for any url given. This preventing any network request.
public class ImageCacheMocker: NSObject {

    private var imageResolver = ImageResolver()

    private static let sampleImage = UIImage.placeholder(with: CGSize(width: 500, height: 500))
    private static let sampleImageData = sampleImage.pngData()

    // MARK: - ImageCacheMocker

    /// Initialize the cache with image providers
    ///
    /// The default providers installed are:
    /// - `.sizeImageProvider`: It returns an image of the specified size in the url
    ///     "size://<width>x<height>"
    /// - `.ratioImageProvider`: It returns an image with an height of 500pt and the specified
    ///     ratio in the url "ratio://<widthFactor>:<heightFactor>"
    /// - `.bundleImageProvider(bundlesWithIdentifiers: ["main": Bundle.main])`: It returns an image
    ///     from the bundle with the name specified in the url url "bundle://<bundleID>/<imageName>".
    ///     By default only images present in the main bundle are accessible, you need to provide a
    ///     custom image provider if you want to access other bundles
    public init(imageProviders: [ImageProvider] = .defaultProviders) {
        super.init()
        imageProviders.forEach {
            imageResolver.registerProvider($0)
        }
    }

    /// Register a new image provider.
    ///
    /// If the provider have the same scheme as a provider already registered, then it will replace it.
    public func registerProvider(_ provider: ImageProvider) {
        imageResolver.registerProvider(provider)
    }

    /// Install itself as the cache of every image requested by SDWebImage.
    ///
    /// Once installed no web request will be done by SDWebImage as this cache always returns an image.
    public func setupSDWebImageMocking() {
        SDWebImageManager.shared.optionsProcessor = SDWebImageOptionsProcessor { _, options, context in
            var mutableOptions = options
            mutableOptions.insert(.fromCacheOnly)
            var mutableContext: [SDWebImageContextOption: Any] = context ?? [:]
            mutableContext[.imageCache] = self
            return SDWebImageOptionsResult(options: mutableOptions, context: mutableContext)
        }
    }

    // MARK: - Private

    private func handleImageRequest(
        forKey key: String?,
        completion completionBlock: SDImageCacheQueryCompletionBlock? = nil
    ) {
        guard
            let stringURL = key,
            let url = URL(string: stringURL)
        else {
            completionBlock?(Self.sampleImage, Self.sampleImageData, .memory)
            return
        }
        let image = imageResolver.image(for: url)
        completionBlock?(image, image.pngData(), .memory)
    }
}

extension ImageCacheMocker: SDImageCacheProtocol {

    // MARK: - SDImageCacheProtocol

    public func queryImage(
        forKey key: String?,
        options: SDWebImageOptions = [],
        context: [SDWebImageContextOption: Any]?,
        completion completionBlock: SDImageCacheQueryCompletionBlock? = nil
    ) -> SDWebImageOperation? {
        handleImageRequest(forKey: key, completion: completionBlock)
        return nil
    }

    public func queryImage(
        forKey key: String?,
        options: SDWebImageOptions = [],
        context: [SDWebImageContextOption: Any]?,
        cacheType: SDImageCacheType,
        completion completionBlock: SDImageCacheQueryCompletionBlock? = nil
    ) -> SDWebImageOperation? {
        handleImageRequest(forKey: key, completion: completionBlock)
        return nil
    }

    public func store(
        _ image: UIImage?,
        imageData: Data?,
        forKey key: String?,
        cacheType: SDImageCacheType,
        completion completionBlock: SDWebImageNoParamsBlock? = nil
    ) {
        completionBlock?()
    }

    public func removeImage(
        forKey key: String?,
        cacheType: SDImageCacheType,
        completion completionBlock: SDWebImageNoParamsBlock? = nil
    ) {
        completionBlock?()
    }

    public func containsImage(
        forKey key: String?,
        cacheType: SDImageCacheType,
        completion completionBlock: SDImageCacheContainsCompletionBlock? = nil
    ) {
        completionBlock?(.memory)
    }

    public func clear(
        with cacheType: SDImageCacheType,
        completion completionBlock: SDWebImageNoParamsBlock? = nil
    ) {
        completionBlock?()
    }
}
