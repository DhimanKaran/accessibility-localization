//
//  TopicCardCollectionViewCell.swift
//  AccessibilityLearning
//
//  Created by karan dhiman on 22/08/2025.
//

import UIKit

final class TopicCardCollectionViewCell: UICollectionViewCell {
    // MARK: - Reuse Identifier
    static let reuseIdentifier = String(describing: TopicCardCollectionViewCell.self)

    // MARK: - Subviews
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .label
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Configure Method
    func configure(title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description

        // Accessibility: Group cell content into a single element
        isAccessibilityElement = true
        accessibilityLabel = "\(title). \(description)"
        accessibilityHint = L10n.accessibilityHintHomeScreenSection1CellTapAction
        accessibilityTraits = [.button]

        // Prevent subviews from being individually accessible
        titleLabel.isAccessibilityElement = false
        descriptionLabel.isAccessibilityElement = false
    }

    // MARK: - Setup UI
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)

        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = Layout.CornerRadius.medium
        contentView.clipsToBounds = true
    }

    // MARK: - Constraints
    private func setupConstraints() {
        let maxWidthConstraint = contentView.widthAnchor.constraint(
            greaterThanOrEqualToConstant: UIScreen.main.bounds.width - Layout.Spacing.mediumPlus)
        maxWidthConstraint.priority = .required
        maxWidthConstraint.isActive = true

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.Spacing.small),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.Spacing.small),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.Spacing.small),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Layout.Spacing.tiny),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -Layout.Spacing.small)
        ])
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard previousTraitCollection?.preferredContentSizeCategory != traitCollection.preferredContentSizeCategory else { return }

        invalidateIntrinsicContentSize()
        layoutIfNeeded()
    }
}
