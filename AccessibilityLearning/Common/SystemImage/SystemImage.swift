//
//  SystemImage.swift
//  AccessibilityLearning
//
//  Created by karan dhiman on 22/08/2025.
//

import UIKit

enum SystemImage {
    static func named(_ name: String) -> UIImage {
        UIImage(systemName: name) ?? UIImage() // empty image fallback
    }

    static let eye = named("eye")
    static let speakerWave = named("speaker.wave.2")
    static let globe = named("globe")
    static let person = named("person.circle")
}
