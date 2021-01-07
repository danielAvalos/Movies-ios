//
//  GenresListTableViewController.swift
//  Movies
//
//  Created by DESARROLLO on 6/01/21.
//

import UIKit

protocol GenresListDisplayLogic: class {
    func displayGenresList(_ viewmodel: [GenreListViewModel])
    func displayMessage(model: MessageModel)
    func displayError(model: ErrorModel)
}

final class GenresListTableViewController: UITableViewController {

    var interactor: (GenresListBusinessLogic & GenresListDataStore)?
    var router: GenresListRoutingLogic?
    var isopenSearch: Bool = false

    private var dataProvider = GenreListDataProvider(rows: [])

    static func instantiate() -> UIViewController? {
        let storyboard = UIStoryboard(name: StoryboardName.genresList.rawValue,
                                      bundle: .main)
        let viewController = storyboard.instantiateInitialViewController()
        return viewController
    }

    lazy var searchController: UISearchController = {
        UISearchController()
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
        setupTableView()
        interactor?.prepareGenresList()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }
}

// MARK: - GenresListDisplayLogic

extension GenresListTableViewController: GenresListDisplayLogic {

    func displayMessage(model: MessageModel) {
    }

    func displayError(model: ErrorModel) {
    }

    func displayGenresList(_ viewmodel: [GenreListViewModel]) {
        dataProvider.update(rows: viewmodel)
        if !viewmodel.isEmpty {
            tableView.tableHeaderView = nil
        }
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - Table view data source

extension GenresListTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataProvider.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.numberOfItems(in: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable:next force_unwrapping
        let viewModel = self.dataProvider[indexPath]!
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GenreTableViewCell.reuseIdentifier) else {
            fatalError("GenreTableViewCell Cell Not Found - Reuse identifier: \(GenreTableViewCell.reuseIdentifier)")
        }
        guard let configurableCell = cell as? GenreListConfigurable else {
            fatalError("GenreTableViewCell Must Conform with MainnConfigurable")
        }
        configurableCell.configure(with: viewModel)
        return cell
    }
}

// MARK: - Private functions

private extension GenresListTableViewController {

    func setup() {
        GenresListConfigurator.configure(self)
    }

    func setupNavigation() {
        navigationItem.title = "Movies Genres"
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func setupTableView() {
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = .black
        refreshControl?.addTarget(self, action: #selector(refreshList(sender:)), for: .valueChanged)
        tableView.layer.shadowOpacity = 0.05
        tableView.layer.shadowOffset = CGSize(width: 0, height: 3)
        tableView.registerCells([GenreTableViewCell.self])
        tableView.refreshControl = refreshControl
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
    }

    // MARK: - Actions

    @objc
    func refreshList(sender _: UIRefreshControl) {
        interactor?.prepareGenresList()
        refreshControl?.endRefreshing()
    }
}

// MARK: - UISearchBarDelegate
extension GenresListTableViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        interactor?.prepareGenresList()
    }
}

// MARK: - UISearchResultsUpdating
extension GenresListTableViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard isopenSearch else {
            return
        }
        interactor?.filterContent(forQuery: searchController.searchBar.text)
    }
}

// MARK: - UISearchBarDelegate
extension GenresListTableViewController: UISearchControllerDelegate {

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
