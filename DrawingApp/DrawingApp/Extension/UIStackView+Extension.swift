//
//  UIStackView+Extension.swift
//  DrawingApp
//
//  Created by Gagan  Vishal on 1/26/21.
//

import UIKit
extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
}
