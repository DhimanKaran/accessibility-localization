//
//  UIViewController.swift
//  AccessibilityLearning
//
//  Created by karan dhiman on 22/08/2025.
//

import UIKit

extension UIViewController {
    func presentRespectingReduceMotion(
        _ viewController: UIViewController,
        animatedIfAllowed: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        let shouldAnimate = animatedIfAllowed && !UIAccessibility.isReduceMotionEnabled
        present(viewController, animated: shouldAnimate, completion: completion)
    }

    func dismissRespectingReduceMotion(
        animatedIfAllowed: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        let shouldAnimate = animatedIfAllowed && !UIAccessibility.isReduceMotionEnabled
        dismiss(animated: shouldAnimate, completion: completion)
    }
}
