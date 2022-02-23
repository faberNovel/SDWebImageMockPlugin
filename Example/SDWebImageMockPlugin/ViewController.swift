//
//  ViewController.swift
//  SDWebImageMockPlugin
//
//  Created by Alexandre Podlewski on 02/23/2022.
//  Copyright (c) 2022 Alexandre Podlewski. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

    private let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        imageView.contentMode = .scaleAspectFit
    }

    // MARK: - ViewController

    func configure(with url: URL?) {
        imageView.sd_setImage(with: url)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configure(with: URL(string: "https://raw.githubusercontent.com/SDWebImage/SDWebImage/master/SDWebImage_logo.png"))
    }
}
