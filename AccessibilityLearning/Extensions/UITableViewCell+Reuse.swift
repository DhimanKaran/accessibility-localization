//
//  UITableViewCell+Reuse.swift
//  AccessibilityLearning
//
//  Created by karan dhiman on 22/08/2025.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        String(describing: self)
    }
}
