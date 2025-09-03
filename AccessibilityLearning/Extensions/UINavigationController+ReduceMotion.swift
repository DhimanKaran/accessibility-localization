//
//  UINavigationController.swift
//  AccessibilityLearning
//
//  Created by karan dhiman on 22/08/2025.
//

import UIKit

extension UINavigationController {
    func pushViewControllerRespectingReduceMotion(
        _ viewController: UIViewController,
        animated: Bool = true
    ) {
        let shouldAnimate = animated && !UIAccessibility.isReduceMotionEnabled
        pushViewController(viewController, animated: shouldAnimate)
    }

    func popViewControllerRespectingReduceMotion(animated: Bool = true) {
        let shouldAnimate = animated && !UIAccessibility.isReduceMotionEnabled
        popViewController(animated: shouldAnimate)
    }
}

