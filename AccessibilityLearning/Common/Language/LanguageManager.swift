//
//  LanguageManager.swift
//  AccessibilityLearning
//
//  Created by karan dhiman on 22/08/2025.
//

import Foundation

final class LanguageManager {
    private enum Constants {
        static let lProjFolderName = "lproj"
    }

    static let shared = LanguageManager()
    private init() {}

    private let selectedLanguageKey = Keys.UserDefaults.selectedLanguage

    var currentLanguage: String {
        return UserDefaults.standard.string(forKey: selectedLanguageKey) ?? Locale.preferredLanguages.first ?? Language.Code.en.rawValue
    }

    func setLanguage(_ languageCode: String) {
        guard currentLanguage != languageCode else { return }

        UserDefaults.standard.set(languageCode, forKey: selectedLanguageKey)
        UserDefaults.standard.set([languageCode], forKey: Keys.UserDefaults.appleLanguages)
        UserDefaults.standard.synchronize()
    }

    var bundle: Bundle {
        guard let path = Bundle.main.path(forResource: currentLanguage, ofType: Constants.lProjFolderName),
              let bundle = Bundle(path: path) else {
            assertionFailure("Localization bundle for language '\(currentLanguage)' not found. Falling back to Bundle.main.")
            return Bundle.main
        }
        return bundle
    }
}
