import UIKit
import RxCocoa
import RxSwift

class ItemListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let disposeBag = DisposeBag()

    private let viewModel: ItemListViewModel
    
    private var query: QueryViewData?
    private var filters: [QueryViewData] = []
    
    init(viewModel: ItemListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
        setupTableView()
        
        bindItemsFromViewModel()
        bindSearchConfigurationsFromViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.register(UINib(nibName: ItemCellView.cellIdentifier, bundle: Bundle(for: type(of: self))), forCellReuseIdentifier: ItemCellView.cellIdentifier)
    }
    
    private func bindItemsFromViewModel() {
        viewModel.output.itemList.bind(to: tableView.rx.items(cellIdentifier: ItemCellView.cellIdentifier, cellType: ItemCellView.self)) { [weak self] row, element, cell in
                self?.configureCell(cell, with: element)
            }
            .disposed(by: disposeBag)
    }

    private func configureCell(_ cell: ItemCellView, with item: Item) {
        
        if let url = URL(string: item.thumbnail) {
            cell.itemImage.load(url: url)
        }
    
        cell.titleLabel.text = item.title
        cell.subtitleLabel.text = "\(item.price)"
    }
    
    private func search() {
        guard let q = query else { return }
        
        var queryParams = filters
        queryParams.append(q)
        viewModel.search(queryParams: queryParams)
    }
    
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isHeaderTableViewEmpty: Bool {
        return tableView.tableHeaderView == nil
    }
    
    private func loadHeaderTableView() {
        let headerView = HeaderView(height: 50.0)
        tableView.tableHeaderView = headerView
    }
    
    private func bindSearchConfigurationsFromViewModel() {
        viewModel.output.searchConfigurations
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (searchConfigurations) in
                if self.isHeaderTableViewEmpty {
                    self.loadHeaderTableView()
                }
            })
            .disposed(by: disposeBag)
    }
}

extension ItemListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}

extension ItemListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if isSearchBarEmpty {
            query = nil
        } else {
            query = QueryViewData(key: "q", value: searchController.searchBar.text!)
        }
    }
}

extension ItemListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        search()
    }
}

