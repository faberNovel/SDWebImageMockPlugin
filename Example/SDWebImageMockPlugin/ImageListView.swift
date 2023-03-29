//
//  ImageListView.swift
//  SDWebImageMockPlugin_Example
//
//  Created by Alexandre Podlewski on 29/03/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

class ImageListViewModel: ObservableObject {

    @Published
    private var urlsAndContentMode: [(URL?, ContentMode?)] = []

    func configure(with urlsAndContentMode: [(URL?, ContentMode?)]) {
        self.urlsAndContentMode = urlsAndContentMode
    }

    func urlWithContentMode(atIndex index: Int) -> (URL?, ContentMode?) {
        guard urlsAndContentMode.indices.contains(index) else {
            return (URL(string: "http://127.0.0.1/"), nil)
        }
        return urlsAndContentMode[index]
    }
}

struct ImageListView: View {

    @ObservedObject
    var viewModel: ImageListViewModel

    var body: some View {
        SwiftUI.VStack(spacing: 16) {
            image(atIndex: 0)
            SwiftUI.HStack(spacing: 8) {
                image(atIndex: 1)
                image(atIndex: 2)
                image(atIndex: 3)
                image(atIndex: 4)

            }
            SwiftUI.HStack(spacing: 8) {
                image(atIndex: 5)
                image(atIndex: 6)
            }
        }
    }

    // MARK: - Private

    @ViewBuilder
    private func image(atIndex index: Int) -> some View {
        let (url, contentMode) = viewModel.urlWithContentMode(atIndex: index)
        if let contentMode {
            WebImage(url: url)
                .resizable()
                .aspectRatio(contentMode: contentMode)
        } else {
            WebImage(url: url)
                .resizable()
        }
    }
}
