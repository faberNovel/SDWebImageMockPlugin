//
//  MultipleImagesViewController.swift
//  testSDWebImageApps
//
//  Created by Alexandre Podlewski on 16/02/2022.
//

import UIKit

class MultipleImagesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private

    private func setupView() {
        let stack = VStack(distribution: .fillEqually, spacing: 16) {
            configuredImage()
            HStack(distribution: .fillEqually, spacing: 8) {
                configuredImage()
                configuredImage()
                configuredImage()
                configuredImage()
            }
            HStack(distribution: .fillEqually, spacing: 8) {
                configuredImage()
                configuredImage()
            }
        }

        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    private func configuredImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.sd_setImage(with: URL(string: "http://127.0.0.1/"))
        return imageView
    }
}
