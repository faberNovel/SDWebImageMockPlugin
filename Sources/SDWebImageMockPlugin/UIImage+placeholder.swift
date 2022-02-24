//
//  UIImage+placeholder.swift
//  
//
//  Created by Alexandre Podlewski on 24/02/2022.
//

import UIKit

extension UIImage {

    static func placeholder(width: Double, height: Double) -> UIImage {
        return placeholder(with: CGSize(width: width, height: height))
    }

    static func placeholder(with size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            let bounds = renderer.format.bounds
            let cgContext = context.cgContext

            UIColor.gray.setFill()
            cgContext.fill(bounds)
            UIColor.lightGray.setStroke()
            cgContext.stroke(bounds)
            cgContext.stroke(bounds)

            cgContext.move(to: CGPoint(x: 0, y: 0))
            cgContext.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
            cgContext.move(to: CGPoint(x: bounds.width, y: 0))
            cgContext.addLine(to: CGPoint(x: 0, y: bounds.height))
            cgContext.strokePath()
        }
    }
}
