//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by DESARROLLO on 6/01/21.
//

import UIKit

protocol MovieDetailDisplayLogic: class {
    func displayData(_ viewmodel: MovieDetailViewModel)
    func displayMessage(model: Message)
    func displayError(model: Error)
}

final class MovieDetailViewController: UIViewController {

    var interactor: (MovieDetailBusinessLogic & MovieDetailDataStore)?

    // MARK: - IB Outlets

    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var popularityLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MovieDetailViewController: MovieDetailDisplayLogic {
    func displayData(_ viewmodel: MovieDetailViewModel) {}
    func displayMessage(model: Message) {}
    func displayError(model: Error) {}
}
