//
//  DetailViewController.swift
//  AccessibilityLearning
//
//  Created by karan dhiman on 22/08/2025.
//

import UIKit

final class DetailViewController: UIViewController {
    private enum Constants {
        static let four: CGFloat = 4
        static let onePointEight: CGFloat = 1.8
    }

    // MARK: - UI Components
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = Layout.CornerRadius.medium
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.homeScreenDetailsSection1Title
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.homeScreenDetailsSection1Description
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    private let bottomRowStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = Layout.Spacing.small
        stack.alignment = .top
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Layout.Spacing.smallPlus
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let durationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = L10n.homeScreenDetailsSection1DurationText
        label.font = .preferredFont(forTextStyle: .footnote)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    private let playButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(L10n.genericPlayTitle, for: .normal)
        button.layer.cornerRadius = Layout.ButtonSize.large / 2
        button.backgroundColor = UIColor(red: 0/255, green: 64/255, blue: 128/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark // this should go to base view controller
        view.backgroundColor = .systemBackground
        title = L10n.homeScreenDetailsNavigationBarTitle

        setupViews()
        setupConstraints()
        setupAccessibility()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // Update accessibilityFrame
        let frameInWindow = playButton.convert(cardView.bounds, to: nil)
        playButton.accessibilityFrame = frameInWindow

        // Define circular accessibility path relative to frame
        let xValue = (playButton.frame.maxX - playButton.frame.minX) / Constants.four
        let yValue = (playButton.frame.maxY - playButton.frame.minY) * Constants.onePointEight
        let path = UIBezierPath(
            ovalIn: CGRect(
                origin: CGPoint(
                    x: playButton.frame.minX + xValue,
                    y: playButton.frame.minY + yValue), size: playButton.bounds.size)
        )
        playButton.accessibilityPath = path
    }

    // MARK: - Setup Methods
    private func setupViews() {
        bottomRowStackView.addArrangedSubview(durationLabel)
        bottomRowStackView.addArrangedSubview(playButton)

        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(descriptionLabel)
        contentStackView.addArrangedSubview(bottomRowStackView)

        cardView.addSubview(contentStackView)
        view.addSubview(cardView)
        
        durationLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        durationLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        playButton.setContentHuggingPriority(.required, for: .horizontal)
        playButton.setContentCompressionResistancePriority(.required, for: .horizontal)

        playButton.addTarget(self, action: #selector(playEpisode), for: .touchUpInside)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.Spacing.mediumPlus),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Layout.Spacing.mediumPlus),
            cardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Layout.Spacing.mediumPlus),
            cardView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -Layout.Spacing.mediumPlus),
            
            contentStackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Layout.Spacing.mediumPlus),
            contentStackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -Layout.Spacing.mediumPlus),
            contentStackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: Layout.Spacing.mediumPlus),
            contentStackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -Layout.Spacing.mediumPlus),
            
            playButton.widthAnchor.constraint(equalToConstant: Layout.ButtonSize.large),
            playButton.heightAnchor.constraint(equalToConstant: Layout.ButtonSize.large)
        ])
    }

    private func setupAccessibility() {
        // Group card content
        cardView.isAccessibilityElement = false
        cardView.shouldGroupAccessibilityChildren = true

        titleLabel.isAccessibilityElement = true
        titleLabel.accessibilityLabel = "\(L10n.accessibilityLabelHomeScreenDetailsSection1Title) \(titleLabel.text ?? "")"

        descriptionLabel.isAccessibilityElement = true
        descriptionLabel.accessibilityLabel = "\(L10n.accessibilityLabelHomeScreenDetailsSection1Description) \(descriptionLabel.text ?? "")"

        durationLabel.isAccessibilityElement = true
        durationLabel.accessibilityLabel = durationLabel.text

        playButton.isAccessibilityElement = true
        playButton.accessibilityLabel = L10n.accessibilityLabelHomeScreenDetailsSection1PlayButton
        playButton.accessibilityHint = L10n.accessibilityHintHomeScreenDetailsSection1PlayButton
        playButton.accessibilityTraits = [.button]
        playButton.accessibilityUserInputLabels = [
            L10n.accessibilityGenericUserInputLabelPlay,
            L10n.accessibilityGenericUserInputLabelStart,
            L10n.accessibilityGenericUserInputLabelBegin
        ]
        playButton.accessibilityRespondsToUserInteraction = true

        let customAction = UIAccessibilityCustomAction(
            name: L10n.accessibilityHomeScreenDetailsAddToPlaylistButtonText,
            target: self,
            selector: #selector(addToPlaylist)
        )
        playButton.accessibilityCustomActions = [customAction]

        // Explicit element ordering inside cardView
        cardView.accessibilityElements = [
            titleLabel,
            descriptionLabel,
            durationLabel,
            playButton
        ]
    }

    // MARK: - Actions
    @objc private func playEpisode() {
        print("Playing episode")
    }

    @objc private func addToPlaylist() -> Bool {
        print("Added to playlist")
        return true
    }
}
