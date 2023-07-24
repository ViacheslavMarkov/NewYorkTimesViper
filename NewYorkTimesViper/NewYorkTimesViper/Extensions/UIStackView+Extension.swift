//
//  UIStackView+Extension.swift
//  NewYorkTimesViper
//
//  Created by Viacheslav Markov on 24.07.2023.
//

import UIKit

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis = .horizontal) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
    }

    func add(arrangedSubviews: [UIView]) {
        arrangedSubviews.forEach {
            addArrangedSubview($0)
        }
    }

    func removeArrangedSubviews() {
        arrangedSubviews.forEach {
            removeArrangedSubview($0)
        }
    }
}

