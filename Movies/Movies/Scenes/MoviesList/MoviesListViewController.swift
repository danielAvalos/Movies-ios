//
//  MoviesListViewController.swift
//  Movies
//
//  Created by DESARROLLO on 6/01/21.
//

import UIKit

protocol MoviesDisplayLogic: class {
    func displayList(_ viewmodel: [MovieViewModel])
    func displayMessage(model: Message)
    func displayError(model: Error)
}

final class MoviesListViewController: UIViewController {

    var interactor: (MoviesListBusinessLogic & MoviesListDataStore)?
    var router: MoviesListRoutingLogic?
    var isopenSearch: Bool = false

    private var dataProvider = MovieDataProvider(rows: [])

    @IBOutlet private weak var collectionView: UICollectionView!

    static func instantiate() -> UIViewController? {
        let storyboard = UIStoryboard(name: StoryboardName.moviesList.rawValue,
                                      bundle: .main)
        let viewController = storyboard.instantiateInitialViewController()
        return viewController
    }

    lazy var searchController: UISearchController = {
        UISearchController()
    }()

    private lazy var refreshControl: UIRefreshControl = { [unowned self] in
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .black
        refreshControl.addTarget(self, action: #selector(refreshMovies(sender:)), for: .valueChanged)
        return refreshControl
    }()

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
        setupCollectionView()
        interactor?.prepareList()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }
}

extension MoviesListViewController: MoviesDisplayLogic {
    func displayList(_ viewmodel: [MovieViewModel]) {
        dataProvider.update(rows: viewmodel)
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }

    func displayMessage(model: Message) {
    }

    func displayError(model: Error) {
    }
}

// MARK: - Private functions

private extension MoviesListViewController {

    func setup() {
        MoviesListConfigurator.configure(self)
    }

    func setupNavigation() {
        navigationItem.title = "Popular movies"
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func setupCollectionView() {
        collectionView.registerCells([MoviesCollectionViewCell.self])
        collectionView.refreshControl = refreshControl
    }

    // MARK: - Actions

    @objc
    func refreshMovies(sender _: UIRefreshControl) {
        interactor?.prepareList()
        refreshControl.endRefreshing()
    }

}

// MARK: - UISearchBarDelegate
extension MoviesListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        interactor?.prepareList()
    }
}

// MARK: - UISearchResultsUpdating
extension MoviesListViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard isopenSearch else {
            return
        }
        interactor?.filterContent(forQuery: searchController.searchBar.text)
    }
}

// MARK: - UISearchBarDelegate
extension MoviesListViewController: UISearchControllerDelegate {

    func willPresentSearchController(_ searchController: UISearchController) {
        isopenSearch = true
    }

    func willDismissSearchController(_ searchController: UISearchController) {
        isopenSearch = false
    }

    func didDismissSearchController(_ searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            navigationItem.title = "Movies"
            return
        }
        navigationItem.title = "Search result"
    }
}

extension MoviesListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataProvider.numberOfItems(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // swiftlint:disable:next force_unwrapping
        let viewModel = self.dataProvider[indexPath]!
        let cell: MoviesCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(with: viewModel)
        return cell
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) { }
}

extension MoviesListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            let width = (collectionView.frame.width / 2)
            let height: CGFloat = width * (180 / 167)
            return CGSize(width: width, height: height)
        default:
            let width = collectionView.frame.width
            let height: CGFloat = (width + 20) * (114 / 345)
            return CGSize(width: width, height: height)
        }
    }
}
