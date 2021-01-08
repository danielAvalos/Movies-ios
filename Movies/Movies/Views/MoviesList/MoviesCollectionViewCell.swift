//
//  MoviesListCollectionViewCell.swift
//  Movies
//
//  Created by DESARROLLO on 6/01/21.
//

import UIKit
import Alamofire

final class MoviesCollectionViewCell: UICollectionViewCell, NibLoadableView {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var movieImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Private functions
private extension MoviesCollectionViewCell {
    func updateUI() {
    }
}

// MARK: - GenreListConfigurable
extension MoviesCollectionViewCell: MovieConfigurable {

    func configure(with viewModel: MovieRepresentable) {
        guard let viewModel = viewModel as? MovieViewModel else {
            return
        }
    }
}
