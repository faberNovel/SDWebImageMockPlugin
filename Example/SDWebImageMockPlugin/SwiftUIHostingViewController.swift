//
//  SwiftUIHostingViewController.swift
//  SDWebImageMockPlugin_Example
//
//  Created by Alexandre Podlewski on 29/03/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import SwiftUI

final class SwiftUIHostingViewController: UIHostingController<ImageListView> {

    let viewModel = ImageListViewModel()

    init() {
        super.init(rootView: ImageListView(viewModel: viewModel))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
