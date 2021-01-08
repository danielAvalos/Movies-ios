//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by DESARROLLO on 6/01/21.
//

import UIKit

final class MovieDetailViewController: UIViewController {

    // MARK: - IB Outlets

    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var popularityLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
