//
//  UIStackView+Utils.swift
//  SDWebImageMockPlugin
//
//  Created by Alexandre Podlewski on 23/02/2022.
//

import UIKit

func HStack(
    alignment: UIStackView.Alignment = .fill,
    distribution: UIStackView.Distribution = .fill,
    spacing: CGFloat,
    @ListResultBuilder<UIView> subviews: () -> [UIView]
) -> UIStackView {
    let stack = UIStackView(arrangedSubviews: subviews())
    stack.axis = .horizontal
    stack.alignment = alignment
    stack.distribution = distribution
    stack.spacing = spacing
    return stack
}

func VStack(
    alignment: UIStackView.Alignment = .fill,
    distribution: UIStackView.Distribution = .fill,
    spacing: CGFloat,
    @ListResultBuilder<UIView> subviews: () -> [UIView]
) -> UIStackView {
    let stack = UIStackView(arrangedSubviews: subviews())
    stack.axis = .vertical
    stack.alignment = alignment
    stack.distribution = distribution
    stack.spacing = spacing
    return stack
}
