//
//  ResourceCellDelegate.swift
//  AccessibilityLearning
//
//  Created by karan dhiman on 22/08/2025.
//

import Foundation

protocol ResourceCellDelegate: AnyObject {
    func cellDidTapLink(_ url: URL)
}
