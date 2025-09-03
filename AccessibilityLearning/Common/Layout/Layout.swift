//
//  Layout.swift
//  AccessibilityLearning
//
//  Created by karan dhiman on 22/08/2025.
//

import CoreGraphics

enum Layout {
    enum Spacing {
        static let tiny: CGFloat = 4
        static let small: CGFloat = 8
        static let smallPlus: CGFloat = 12
        static let medium: CGFloat = 16
        static let mediumPlus: CGFloat = 20
        static let large: CGFloat = 24
        static let extraLarge: CGFloat = 32
        static let extraLargePlus: CGFloat = 40
    }

    enum ButtonSize {
        static let small: CGFloat = 20
        static let medium: CGFloat = 40
        static let mediumPlus: CGFloat = 40
        static let large: CGFloat = 60
    }

    enum CornerRadius {
        static let small: CGFloat = 4
        static let medium: CGFloat = 8
        static let large: CGFloat = 16
    }
}
