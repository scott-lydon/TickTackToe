import Foundation
import UIKit

// No need to modify during the interview
extension UIView {
    func build(
        titleLabel: UILabel,
        playersStackView: UIStackView,
        currentPlayerLabel: UILabel,
        collectionView: UICollectionView,
        undoButton: UIButton
    ) {
        let views: [UIView] = [
            titleLabel,
            playersStackView,
            currentPlayerLabel,
            collectionView,
            undoButton
        ]

        views.forEach { addSubview($0) }

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),

            playersStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            playersStackView.centerXAnchor.constraint(equalTo: centerXAnchor),

            currentPlayerLabel.topAnchor.constraint(equalTo: playersStackView.bottomAnchor, constant: 20),
            currentPlayerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            collectionView.topAnchor.constraint(equalTo: currentPlayerLabel.bottomAnchor, constant: 20),
            collectionView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.95),
            collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor),
            collectionView.centerXAnchor.constraint(equalTo: centerXAnchor),

            undoButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            undoButton.heightAnchor.constraint(equalToConstant: 75),
            undoButton.widthAnchor.constraint(equalToConstant: 75),
            undoButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}

extension UIStackView {
    static func build(
        players: [Player]
    ) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: players.map { PlayerView(player: $0) })
        stackView.axis = .horizontal
        stackView.spacing = 50
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
}

extension UILabel {
    static func build(
        font: UIFont,
        text: String
    ) -> UILabel {
        let label = UILabel()
        label.font = font
        label.text = text
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

extension UICollectionView {
    static func build(rowCount: Int = 3) -> UICollectionView {
        let fraction: CGFloat = 1 / CGFloat(rowCount)
        let inset: CGFloat = 1

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(fraction),
            heightDimension: .fractionalHeight(1)
        )
        // The most basic component of a collection view's layout.
        // An item is a blueprint for how to size, space, and arrange an individual piece of content in your collection view. An item represents a single view that's rendered onscreen. Generally, an item is a cell, but items can be supplementary views like headers, footers, and other decorations.
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: inset,
            leading: inset,
            bottom: inset,
            trailing: inset
        )

        // The width and the height of an item in a collection view.
        // A size is a pair of dimensions (NSCollectionLayoutDimension): a width dimension and a height dimension. Every component of a collection view layout has an explicit size.
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(fraction)
        )
        // A container for a set of items that lays out the items along a path.
        // Groups determine how the items in a collection view are laid out in relation to each other. A group might lay out its items in a horizontal row, a vertical column, or a custom arrangement. A group determines the rules for how items are rendered in relation to each other, but in itself does not render any content.
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        // A container that combines a set of groups into distinct visual groupings.
        // A collection view layout has one or more sections. Sections provide a way to separate the layout into distinct pieces.
        // Each section can have the same layout or a different layout than the other sections in the collection view. A section's layout is determined by the properties of the group (NSCollectionLayoutGroup) that's used to create the section.
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: inset,
            bottom: 0,
            trailing: inset
        )

        let collectionView = UICollectionView(
            frame: .zero,
            // A layout object that lets you combine items in highly adaptive and flexible visual arrangements.
            // A compositional layout is a type of collection view layout. It's designed to be composable, flexible, and fast, letting you build any kind of visual arrangement for your content by combining — or compositing — each smaller component into a full layout.
            collectionViewLayout: UICollectionViewCompositionalLayout(section: section)
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = false
        return collectionView
    }
}
