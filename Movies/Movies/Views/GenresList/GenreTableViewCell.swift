//
//  GenreTableViewCell.swift
//  Movies
//
//  Created by DESARROLLO on 6/01/21.
//

import UIKit

final class GenreTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Private functions
private extension GenreTableViewCell {
    func updateUI() {
    }
}

// MARK: - GenreListConfigurable
extension GenreTableViewCell: GenreListConfigurable {

    func configure(with viewModel: GenreListRepresentable) {
        guard let viewModel = viewModel as? GenreListViewModel else {
            return
        }
        titleLabel.text = viewModel.model.name
    }
}
