# iOS Accessibility & Localization Exploration

This iOS UIKit project explores how to make apps more accessible and usable across different languages and regions.

The main goal of this project is to **build awareness and gain hands-on experience** with:

- Accessibility features (VoiceOver, Dynamic Type, Reduce Motion, Color Contrast)
- Localization and internationalization (multi-language and RTL support)

---

## What I Explored

### Accessibility
- Used `UIAccessibility` APIs to:
  - Add labels, hints, traits to UI elements
  - Respect system settings like **Reduce Motion**
  - Improve screen reader navigation using element grouping
  - Add custom accessibility actions (e.g., *Add to Playlist*)
  -  **Color contrast compliant** UI elements

### Localization
- Localized all app strings using `L10n` enum pattern
- Supported in-app language switching (English, French, Hindi, German, Arabic, Spanish)
- Handled **RTL layout** for Arabic using `semanticContentAttribute`

---

## Purpose of This Repo

This is a **learning-focused project** to:
- Understand iOS accessibility and localization concepts
- Practice implementing them in a small UIKit-based app
- Share progress publicly for feedback and visibility

---

## What's Inside

- A main screen with:
  - Horizontal collection of topic cards
  - Vertical list of info/resource cards
  - Continue button leading to detail screen
- A detail screen with:
  - Accessible labels and a play button
  - Custom accessibility actions
- Support for voiceover, dynamic type, and motion reduction
- Language switcher with live UI update

---

## Tech

- Swift 5
- UIKit
- Auto Layout + Dynamic Type
- iOS 18+

---

## Notes

This code is shared as a **personal learning project** to document my understanding of accessibility and localization in iOS.
