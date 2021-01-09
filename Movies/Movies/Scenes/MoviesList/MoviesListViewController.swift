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
        setupNavigationTitle()
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }

    func displayMessage(model: Message) {
        showToast(message: model.title ?? "")
    }

    func displayError(model: Error) {
        showAlert(title: model.title, message: model.description)
    }
}

// MARK: - NavigationConfigureProtocol
extension MoviesListViewController: NavigationConfigureProtocol {
    func didTapBarItem(sender: UIBarButtonItem) {
        switch sender.tag {
        case BarButtonItemTag.categories.rawValue:
            showOptionsCategories()
        case BarButtonItemTag.sort.rawValue:
            showOptionsSorts()
        default:
            break
        }
    }
}

// MARK: - Private functions

private extension MoviesListViewController {

    func showOptionsSorts() {
        let alertController = getAlertController()
        let alphabeticAZ = UIAlertAction(title: "A-Z",
                                         style: .default) { [weak self] _ in
            self?.interactor?.movieType = .latest
            self?.interactor?.sort(sortType: .aToZ)
        }
        let alphZA = UIAlertAction(title: "Z-A",
                                         style: .default) { [weak self] _ in
            self?.interactor?.movieType = .latest
            self?.interactor?.sort(sortType: .zToA)
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        cancelAction.setValue(UIColor.color(named: .orange),
                              forKey: "titleTextColor")
        alertController.addAction(alphabeticAZ)
        alertController.addAction(alphZA)
        alertController.addAction(cancelAction)
        present(alertController,
                animated: true,
                completion: nil)
    }

    func showOptionsCategories() {
        let alertController = getAlertController()
        let latestAction = UIAlertAction(title: "Latest",
                                         style: .default) { [weak self] _ in
            self?.interactor?.movieType = .latest
            self?.interactor?.prepareList()
        }
        let nowPlayingAction = UIAlertAction(title: "Now Playings",
                                            style: .default) { [weak self] _ in
            self?.interactor?.movieType = .nowPlaying
            self?.interactor?.prepareList()
        }
        let popularAction = UIAlertAction(title: "Populars",
                                          style: .default) { [weak self] _ in
            self?.interactor?.movieType = .popular
            self?.interactor?.prepareList()
        }
        let topRatedAction = UIAlertAction(title: "Top Rated",
                                           style: .default) { [weak self] _ in
            self?.interactor?.movieType = .topRated
            self?.interactor?.prepareList()
        }
        let upcommingAction = UIAlertAction(title: "Upcomings",
                                            style: .default) { [weak self] _ in
            self?.interactor?.movieType = .upcoming
            self?.interactor?.prepareList()
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        cancelAction.setValue(UIColor.color(named: .orange),
                              forKey: "titleTextColor")
        alertController.addAction(latestAction)
        alertController.addAction(nowPlayingAction)
        alertController.addAction(popularAction)
        alertController.addAction(topRatedAction)
        alertController.addAction(upcommingAction)
        alertController.addAction(cancelAction)
        present(alertController,
                animated: true,
                completion: nil)
    }

    func setup() {
        MoviesListConfigurator.configure(self)
    }

    func setupNavigationTitle() {
        guard let movieType = interactor?.movieType else {
            return
        }
        switch movieType {
        case .popular:
            navigationItem.title = "Populars movies"
        case .latest:
            navigationItem.title = "Latest movie"
        case .topRated:
            navigationItem.title = "Top Rated movies"
        case .upcoming:
            navigationItem.title = "Upcomings movies"
        case .nowPlaying:
            navigationItem.title = "Now playings movies"
        }
    }

    func setupNavigation() {
        setupNavigationTitle()
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
        showLeftBarButtonItems(navigationItem: navigationItem,
                               items: [.categories])
        showRightBarButtonItems(navigationItem: navigationItem,
                                items: [.sort])
    }

    func setupCollectionView() {
        collectionView.registerCells([MoviesCollectionViewCell.self])
        collectionView.refreshControl = refreshControl
        let screenWidth = self.collectionView.frame.width / 2
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: screenWidth, height: screenWidth * 1.5)
        collectionView.collectionViewLayout = layout
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
}

extension MoviesListViewController: UICollectionViewDelegate {

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // swiftlint:disable:next force_unwrapping
        let viewModel = self.dataProvider[indexPath]!
        guard let id = viewModel.model.id else {
            return
        }
        router?.navigateToMovieDetail(id: id)
    }
}
