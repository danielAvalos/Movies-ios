//
//  MoviesListCollectionViewCell.swift
//  Movies
//
//  Created by DESARROLLO on 6/01/21.
//

import UIKit
import Alamofire
import SDWebImage

final class MoviesCollectionViewCell: UICollectionViewCell, NibLoadableView {

    @IBOutlet private weak var containerView: UIView! {
        didSet {
            containerView.backgroundColor = UIColor.secondarySystemBackground
        }
    }
    @IBOutlet private weak var movieImageView: UIImageView! {
        didSet {
            movieImageView.layer.cornerRadius = 8
        }
    }

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
        guard let viewModel = viewModel as? MovieViewModel,
              let path = viewModel.model.posterPath else {
            return
        }
        guard let url = URL(string: "\(Config.apiImageBaseUrl)\(path)") else {
            return
        }
        movieImageView.sd_setImage(with: url,
                                 placeholderImage: UIImage.init(named: "placeholder"),
                                 options: .lowPriority) { [weak self] (image, _, _, _) in
            guard let image = image else {
                return
            }
            self?.movieImageView.image = image
        }
    }
}
