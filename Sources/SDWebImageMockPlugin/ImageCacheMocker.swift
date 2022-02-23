//
//  ImageCacheMocker.swift
//  
//
//  Created by Alexandre Podlewski on 23/02/2022.
//

import Foundation
import UIKit
import SDWebImage

public class ImageCacheMocker: NSObject, SDImageCacheProtocol {

    static let sampleImage = placeholderImage(size: CGSize(width: 500, height: 500))
    static let sampleImageData = sampleImage.sd_imageData(as: .PNG)!

    // MARK: - ImageCacheMocker

    public func setupSDWebImageMocking() {
        SDWebImageManager.shared.optionsProcessor = SDWebImageOptionsProcessor() { url, options, context in
            var mutableOptions = options
            mutableOptions.insert(.fromCacheOnly)
            var mutableContext: [SDWebImageContextOption : Any] = context ?? [:]
            mutableContext[.imageCache] = self
            return SDWebImageOptionsResult(options: mutableOptions, context: mutableContext)
        }
    }

    // MARK: - SDImageCacheProtocol

    public func queryImage(
        forKey key: String?,
        options: SDWebImageOptions = [],
        context: [SDWebImageContextOption : Any]?,
        completion completionBlock: SDImageCacheQueryCompletionBlock? = nil
    ) -> SDWebImageOperation? {
        handleImageRequest(forKey: key, completion: completionBlock)
        return nil
    }

    public func queryImage(
        forKey key: String?,
        options: SDWebImageOptions = [],
        context: [SDWebImageContextOption : Any]?,
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
    ) {}

    // MARK: - Private

    private func handleImageRequest(
        forKey key: String?,
        completion completionBlock: SDImageCacheQueryCompletionBlock? = nil
    ) {
        if #available(iOS 13.0, *) {
            guard
                let stringURL = key,
                let url = URL(string: stringURL),
                url.scheme == "sample",
                let imageName = url.host,
                let image = UIImage(named: imageName, in: Bundle(for: ImageCacheMocker.self), with: nil)
            else {
                completionBlock?(Self.sampleImage, Self.sampleImageData, .memory)
                return
            }
            completionBlock?(image, image.sd_imageData(as: .PNG), .memory)
        } else {
            completionBlock?(Self.sampleImage, Self.sampleImageData, .memory)
        }
    }

    private static func placeholderImage(size: CGSize = CGSize(width: 100, height: 100)) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            UIColor.gray.setFill()
            context.fill(renderer.format.bounds)
            UIColor.lightGray.setStroke()
            context.stroke(renderer.format.bounds)

            let bounds = renderer.format.bounds
            let cgContext = context.cgContext
            cgContext.move(to: CGPoint(x: 0, y: 0))
            cgContext.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
            cgContext.move(to: CGPoint(x: bounds.width, y: 0))
            cgContext.addLine(to: CGPoint(x: 0, y: bounds.height))
            cgContext.strokePath()
        }
    }
}
