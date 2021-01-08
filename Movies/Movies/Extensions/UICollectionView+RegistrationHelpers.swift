//
//  UICollectionView+RegistrationHelpers.swift
//  Movies
//
//  Created by DESARROLLO on 7/01/21.
//

import UIKit

// MARK: - UICollectionViewCell

public extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) where T: NibLoadableView {
        let nib = UINib(nibName: T.identifier, bundle: Bundle(for: T.self))

        register(nib, forCellWithReuseIdentifier: T.identifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: NibLoadableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Cell with identifier: \(T.identifier) could not be dequeued!")
        }

        return cell
    }
}

// MARK: - UICollectionReusableView

public extension UICollectionView {
    func register<T: UICollectionReusableView>(_: T.Type, forSupplementaryViewOfKind kind: String) where T: NibLoadableView {
        let nib = UINib(nibName: T.identifier, bundle: Bundle(for: T.self))

        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.identifier)
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: String, for indexPath: IndexPath) -> T where T: NibLoadableView {
        guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Supplementary view with identifier: \(T.identifier) could not be dequeued!")
        }

        return view
    }
}
