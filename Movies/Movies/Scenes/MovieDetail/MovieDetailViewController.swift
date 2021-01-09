//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by DESARROLLO on 6/01/21.
//

import UIKit

protocol MovieDetailDisplayLogic: class {
    func displayData(_ viewModel: MovieDetailViewModel)
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
    @IBOutlet private weak var genresLabel: UILabel!
    @IBOutlet private weak var languagesLabel: UILabel!
    @IBOutlet private weak var isAdultLabel: UILabel!
    @IBOutlet private weak var homePageButton: UIButton!
    @IBOutlet private weak var videoButton: CustomizedButton!

    static func instantiate() -> UIViewController? {
        let storyboard = UIStoryboard(name: StoryboardName.movieDetail.rawValue,
                                      bundle: .main)
        let viewController = storyboard.instantiateInitialViewController()
        return viewController
    }

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.prepare()
        setupNavigation()
    }
}

// MARK: - MovieDetailDisplayLogic
extension MovieDetailViewController: MovieDetailDisplayLogic {

    func displayData(_ viewModel: MovieDetailViewModel) {
        let model = viewModel.model
        guard let path = model.backdropPath else {
            return
        }
        guard let url = URL(string: "\(Config.apiImageBaseUrl)\(path)") else {
            return
        }
        setupImage(url: url)
        setupText(model: model)
        setupButtons(model)
    }

    func displayMessage(model: Message) {
        showAlert(title: model.title ?? "",
                  message: model.description ?? "")
    }
    func displayError(model: Error) {
        showAlert(title: model.title,
                  message: model.description)
    }
}

// MARK: - Private functions

private extension MovieDetailViewController {

    func setup() {
        MovieDetailConfigurator.configure(self)
    }

    func setupNavigation() {
        navigationItem.title = "Movie Detail"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func setupText(model: MovieDetail) {
        if let title = model.title {
            titleLabel.text = title
        } else {
            titleLabel.isHidden = true
        }
        if let overview = model.overview {
            descriptionLabel.isHidden = false
            descriptionLabel.text = overview
        } else {
            descriptionLabel.isHidden = true
        }
        if let popularity = model.popularity {
            popularityLabel.isHidden = false
            popularityLabel.text = "Popularity: \(popularity)"
        } else {
            popularityLabel.isHidden = true
        }
        if let genres = model.genres {
            genresLabel.isHidden = false
            var genresText = "Genres: ["
            genres.forEach {
                guard let name = $0.name else {
                    return
                }
                genresText += "\(name),"
            }
            genresText += "]"
            genresLabel.text = genresText
        } else {
            genresLabel.isHidden = true
        }
        if model.adult == true {
            isAdultLabel.isHidden = false
            isAdultLabel.text = "adult content"
        } else {
            isAdultLabel.text = "Content for all ages"
        }
        languagesLabel.isHidden = true
    }

    func setupButtons(_ model: MovieDetail) {
        videoButton.isHidden = !(model.video ?? false)
        if let homePage = model.homepage,
           URL(string: homePage) != nil {
            homePageButton.isHidden = false
            homePageButton.setTitle(homePage, for: .normal)
        } else {
            homePageButton.isHidden = true
        }
    }

    func setupImage(url: URL) {
        image.sd_setImage(with: url,
                                 placeholderImage: UIImage.init(named: "placeholder"),
                                 options: .lowPriority) { [weak self] (image, _, _, _) in
            guard let image = image else {
                return
            }
            self?.image.image = image
        }
    }

    // MARK: - IB Actions
    @IBAction func didTapHomePage(_ sender: Any) {
        if let homePage = interactor?.movie?.homepage,
           let url = URL(string: homePage) {
            UIApplication.shared.open(url,
                                      options: [:],
                                      completionHandler: nil)
        } else {
            showToast(message: "Invalid URL")
        }
    }

    @IBAction func didTapVideo(_ sender: Any) {
    }
}
