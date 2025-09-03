//
//  ResourceTableViewCell.swift
//  AccessibilityLearning
//
//  Created by karan dhiman on 22/08/2025.
//

import UIKit

final class ResourceTableViewCell: UITableViewCell {
    // MARK: - Public
    static let reuseIdentifier = String(describing: ResourceTableViewCell.self)

    weak var delegate: ResourceCellDelegate?

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = SystemImage.person
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0
        label.textColor = .systemGray
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let linkLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.textColor = .systemBlue
        label.isUserInteractionEnabled = true
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var linkURL: URL?

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .systemBackground
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupViews() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(linkLabel)

        let tap = UITapGestureRecognizer(target: self, action: #selector(linkTapped))
        linkLabel.addGestureRecognizer(tap)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.Spacing.medium),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.Spacing.medium),
            iconImageView.widthAnchor.constraint(equalToConstant: Layout.Spacing.extraLargePlus),
            iconImageView.heightAnchor.constraint(equalToConstant: Layout.Spacing.extraLargePlus),

            titleLabel.topAnchor.constraint(equalTo: iconImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: Layout.Spacing.smallPlus),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.Spacing.medium),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Layout.Spacing.small),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            linkLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Layout.Spacing.smallPlus),
            linkLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            linkLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            linkLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Layout.Spacing.medium)
        ])
    }

    // MARK: - Configuration
    func configure(title: String, description: String, link: String, image: UIImage?) {
        titleLabel.text = title
        descriptionLabel.text = description
        linkLabel.text = link
        iconImageView.image = image
        linkURL = URL(string: link)

        setupAccessibility()
    }

    // MARK: - Accessibility
    private func setupAccessibility() {
        isAccessibilityElement = false

        titleLabel.isAccessibilityElement = true
        titleLabel.accessibilityLabel = titleLabel.text
        titleLabel.accessibilityTraits = .header

        descriptionLabel.isAccessibilityElement = true
        descriptionLabel.accessibilityLabel = descriptionLabel.text

        linkLabel.isAccessibilityElement = true
        linkLabel.accessibilityLabel = "\(L10n.accessibilityLabelHomeScreenSection2Link) \(linkLabel.text ?? "")"
        linkLabel.accessibilityHint = L10n.accessibilityHintHomeScreenSection2Link
        linkLabel.accessibilityTraits = .link

        accessibilityElements = [titleLabel, descriptionLabel, linkLabel]
    }

    // MARK: - Actions
    @objc private func linkTapped() {
        guard let url = linkURL else { return }
        delegate?.cellDidTapLink(url)
    }
}

