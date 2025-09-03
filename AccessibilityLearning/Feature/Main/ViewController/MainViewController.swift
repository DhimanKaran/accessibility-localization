//
//  MainViewController.swift
//  AccessibilityLearning
//
//  Created by karan dhiman on 22/08/2025.
//

import UIKit

final class MainViewController: UIViewController {
    private enum Constants {
        static let collectionViewHeightConstant: CGFloat = 300
        static let tableViewEstimatedRowHeightConstant: CGFloat = 300
        static let numberOfItemsInCollectionView: Int = 6
        static let one: Int = 1
        static let animationDuration: TimeInterval = 0.3
        static let lineSpacing: CGFloat = 10
    }

    // MARK: - UI Components
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = Constants.lineSpacing
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            TopicCardCollectionViewCell.self,
            forCellWithReuseIdentifier: TopicCardCollectionViewCell.reuseIdentifier
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Constants.tableViewEstimatedRowHeightConstant
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        tableView.register(
            ResourceTableViewCell.self,
            forCellReuseIdentifier: ResourceTableViewCell.identifier
        )
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(L10n.homeScreenContinueButtonTitle, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = Layout.CornerRadius.medium
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(continueButtonTapped), for: .touchUpInside)
        
        // Accessibility
        button.isAccessibilityElement = true
        button.accessibilityLabel = L10n.accessibilityLabelHomeScreenContinueButton
        button.accessibilityHint = L10n.accessibilityHintHomeScreenContinueButton
        button.accessibilityTraits = .button
        
        return button
    }()
    
    // MARK: - Data
    private let infoCards: [InfoCard] = [
        InfoCard(
            title: L10n.homeScreenSection2Item1Title,
            description: L10n.homeScreenSection2Item1Description,
            link: L10n.homeScreenSection2Item1Link,
            icon: SystemImage.eye
        ),
        InfoCard(
            title: L10n.homeScreenSection2Item2Title,
            description: L10n.homeScreenSection2Item2Description,
            link: L10n.homeScreenSection2Item2Link,
            icon: SystemImage.speakerWave
        )
    ]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark // this should go to base view controller
        title = L10n.homeScreenNavigationBarTitle
        view.backgroundColor = .systemBackground
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: L10n.genericBackButtonTitle,
            style: .plain,
            target: nil,
            action: nil
        )
        let languageButton = UIBarButtonItem(
            image: SystemImage.globe, // SF Symbol for language icon
                style: .plain,
                target: self,
                action: #selector(languageButtonTapped)
        )
        navigationItem.leftBarButtonItem = languageButton
        setupLayout()
    }

    @objc func languageButtonTapped() {
        let selectedCode = UserDefaults.standard.string(
            forKey: Keys.UserDefaults.selectedLanguage) ?? Locale.current.language.languageCode?.identifier ?? Language.Code.en.rawValue
        
        let alert = UIAlertController(title: L10n.homeScreenSelectLanguage, message: nil, preferredStyle: .actionSheet)

        let languages: [(code: String, name: String)] = [
            (Language.Code.en.rawValue, Language.name.english.rawValue),
            (Language.Code.fr.rawValue, Language.name.french.rawValue),
            (Language.Code.hi.rawValue, Language.name.hindi.rawValue),
            (Language.Code.de.rawValue, Language.name.german.rawValue),
            (Language.Code.ar.rawValue, Language.name.arabic.rawValue),
            (Language.Code.es.rawValue, Language.name.spanish.rawValue)
        ]

        let sortedLanguages = languages.sorted { $0.name < $1.name }
        for lang in sortedLanguages {
            let isSelected = lang.code == selectedCode
            let title = isSelected ? "✓ \(lang.name)" : lang.name
            
            let action = UIAlertAction(title: title, style: .default) { [weak self] _ in
                if !isSelected {
                    // Change language only if it's a new selection
                    self?.changeLanguage(to: lang.code)
                }
            }
            alert.addAction(action)
        }

        alert.addAction(UIAlertAction(title: L10n.genericCancelTitle, style: .cancel))

        // For iPad compatibility:
        if let popover = alert.popoverPresentationController {
            popover.barButtonItem = navigationItem.leftBarButtonItem
        }

        presentRespectingReduceMotion(alert, animatedIfAllowed: true)
    }

    func changeLanguage(to code: String) {
        LanguageManager.shared.setLanguage(code)
        if code == Language.Code.ar.rawValue {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        reloadRootViewController()
    }

    func reloadRootViewController() {
        guard let windowScene = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .compactMap({ $0 as? UIWindowScene })
            .first,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
            return
        }

        let newRootVC = UINavigationController(rootViewController: MainViewController())
        window.rootViewController = newRootVC
        window.makeKeyAndVisible()
        AccessibilityMotion.safeAnimate(
            with: window,
            withDuration: Constants.animationDuration,
            animations: nil
        )
    }

    // MARK: - Layout
    private func setupLayout() {
        [collectionView, tableView, continueButton].forEach(view.addSubview)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.Spacing.mediumPlus),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Layout.Spacing.mediumPlus),
            collectionView.heightAnchor.constraint(equalToConstant: Constants.collectionViewHeightConstant),
            
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: Layout.Spacing.mediumPlus),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.Spacing.mediumPlus),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Layout.Spacing.mediumPlus),
            tableView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -Layout.Spacing.medium),
            
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.Spacing.mediumPlus),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Layout.Spacing.mediumPlus),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Layout.Spacing.mediumPlus),
            continueButton.heightAnchor.constraint(equalToConstant: Layout.ButtonSize.mediumPlus)
        ])
    }

    // MARK: - Navigation
    @objc private func continueButtonTapped() {
        let detailVC = DetailViewController()
        navigationController?.pushViewControllerRespectingReduceMotion(detailVC, animated: true)
    }
}

// MARK: - UICollectionViewDataSource & Delegate
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.numberOfItemsInCollectionView
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TopicCardCollectionViewCell.reuseIdentifier,
            for: indexPath) as? TopicCardCollectionViewCell
        else {
            return UICollectionViewCell()
        }

        let item = indexPath.item + Constants.one
        cell.configure(title: "\(L10n.homeScreenSection1ItemTitle) \(item)", description: "\(L10n.homeScreenSection1ItemDescription) \(item).")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        continueButtonTapped()
    }
}

// MARK: - UITableViewDataSource & Delegate
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoCards.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ResourceTableViewCell.identifier,
            for: indexPath
        ) as! ResourceTableViewCell
        let card = infoCards[indexPath.row]
        cell.configure(title: card.title, description: card.description, link: card.link, image: card.icon)
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        continueButtonTapped()
    }
}

// MARK: - ResourceCellDelegate
extension MainViewController: ResourceCellDelegate {
    func cellDidTapLink(_ url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Cannot open URL: \(url)")
        }
    }
}

