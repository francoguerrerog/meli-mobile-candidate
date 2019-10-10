import UIKit
import RxCocoa
import RxSwift

class ItemListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filtersTableViewContainer: UIView!
    @IBOutlet weak var filtersTableView: UITableView!
    @IBOutlet weak var closeFiltersButton: UIButton!
    
    private var headerView: HeaderView?
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let disposeBag = DisposeBag()

    private let viewModel: ItemListViewModel
    
    private var query: QueryViewData?
    private var filters: [QueryViewData] = []
    
    private var searchConfigurations: SearchConfigurations?
    
    private var sectionExpanded:Int?
    
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
        setupFiltersTableView()
        
        bindTapFiltersContainer()
        
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
        searchController.searchBar.placeholder = "Search..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.register(UINib(nibName: ItemCellView.cellIdentifier, bundle: Bundle(for: type(of: self))), forCellReuseIdentifier: ItemCellView.cellIdentifier)
    }
    
    private func setupFiltersTableView() {
        filtersTableView.delegate = self
        filtersTableView.dataSource = self
        filtersTableView.register(UINib(nibName: FilterCellView.cellIdentifier, bundle: Bundle(for: type(of: self))), forCellReuseIdentifier: FilterCellView.cellIdentifier)
    }
    
    private func bindItemsFromViewModel() {
        viewModel.output.itemList
            .bind(to: tableView.rx.items(cellIdentifier: ItemCellView.cellIdentifier, cellType: ItemCellView.self)) { [weak self] row, element, cell in
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
        headerView = HeaderView(height: 50.0)
        tableView.tableHeaderView = headerView
        bindHeaderFilterAction()
    }
    
    private func bindHeaderFilterAction() {
        guard let header = headerView else { return }
        
        header.filterButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.filtersTableViewContainer.isHidden = false
            })
            .disposed(by: disposeBag)
    }
    
    private func bindTapFiltersContainer() {
        closeFiltersButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.filtersTableViewContainer.isHidden = true
            })
            .disposed(by: disposeBag)
    }
    
    private func bindSearchConfigurationsFromViewModel() {
        viewModel.output.searchConfigurations
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (searchConfigurations) in
                if self.isHeaderTableViewEmpty {
                    self.loadHeaderTableView()
                }
                self.setTableViewConfigurations(searchConfigurations)
            })
            .disposed(by: disposeBag)
    }
    
    private func setTableViewConfigurations(_ searchConfigurations: SearchConfigurations) {
        self.searchConfigurations = searchConfigurations
        filtersTableView.reloadData()
    }
    
    private func bindTapHeaderInSection(_ header: FilterHeaderView) {
        let tapGesture = UITapGestureRecognizer()
        header.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event
            .bind(onNext: { [weak self] recognizer in
                guard let section = recognizer.view?.tag else { return }
                let currentSection = self?.sectionExpanded
                if self?.sectionExpanded == section {
                    self?.sectionExpanded = nil
                } else {
                    self?.sectionExpanded = section
                }
                var array = [section]
                if currentSection != nil {
                    array.append(currentSection!)
                }
                self?.filtersTableView.reloadSections(IndexSet(array), with: .automatic)
            })
            .disposed(by: disposeBag)
    }
}

extension ItemListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let configurations = searchConfigurations else { return 0 }
        
        return 1 + configurations.availableFilters.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let expanded = sectionExpanded else { return 0 }
        
        if section == expanded {
            guard let configurations = searchConfigurations else { return 0 }
            
            if section == 0 {
                return configurations.availableSorts.count
            } else {
                guard let values = configurations.availableFilters[section-1].values else { return 0 }
                return values.count
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterCellView.cellIdentifier, for: indexPath) as! FilterCellView
        
        if indexPath.section == 0 {
            if let data = searchConfigurations?.availableSorts[indexPath.row] {
                cell.titleLabel.text = data.name
            }
        } else {
            if let sectionData = searchConfigurations?.availableFilters[indexPath.section-1],
                let values = sectionData.values {
                cell.titleLabel.text = values[indexPath.row].name
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView != filtersTableView {
            return nil
        }
        
        guard let configurations = searchConfigurations else { return nil }
        
        let header = FilterHeaderView(frame: CGRect(x: 0, y: 0, width: filtersTableView.bounds.width, height: 50.0))
        header.tag = section
        
        if section == 0 {
            header.titleLabel.text = "Sorted by"
            header.subtitleLabel.text = configurations.sort.name
        } else {
            let data = configurations.availableFilters[section-1]
            header.titleLabel.text = data.name
            let selected = configurations.filters.filter{$0.id == data.id}.first
            header.subtitleLabel.text = (selected != nil) ? selected!.name : ""
        }
        
        bindTapHeaderInSection(header)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView != filtersTableView {
            return 0
        }
        return 50.0
    }
    
}

extension ItemListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case self.tableView:
            return 100.0
        case self.filtersTableView:
            return 50.0
        default:
            return 100.0
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case self.tableView:
            // ir a pantalla de detalle
            break
        case self.filtersTableView:
            // verificar seleccionado y llamar search()
            sectionExpanded = nil
            filtersTableViewContainer.isHidden = true
            guard let configurations = searchConfigurations else { return }
            if indexPath.section == 0 {
                let sort = configurations.availableSorts[indexPath.row]
                self.setSortFilter(sort)
            } else {
                let filter = configurations.availableFilters[indexPath.section-1]
                guard let filterValue = filter.values?[indexPath.row] else { return }
                self.setFilter(filter, filterValue)
            }
            break
        default:
            break
        }
    }
    
    private func setSortFilter(_ sort: SortDataResponse) {
        if let index = filters.firstIndex(where: {$0.key == "sort"}) {
            filters[index] = QueryViewData(key: "sort", value: sort.id!)
        } else {
            filters.append(QueryViewData(key: "sort", value: sort.id!))
        }
        search()
    }
    
    private func setFilter(_ filter: FilterDataResponse, _ filterValue: FilterValuesDataResponse) {
        if let index = filters.firstIndex(where: {$0.key == filter.id!}) {
            filters[index] = QueryViewData(key: filter.id!, value: filterValue.id!)
        } else {
            filters.append(QueryViewData(key: filter.id!, value: filterValue.id!))
        }
        search()
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

