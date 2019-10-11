import UIKit
import RxCocoa
import RxSwift

class ItemListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filtersTableViewContainer: UIView!
    @IBOutlet weak var filtersTableView: UITableView!
    @IBOutlet weak var closeFiltersButton: UIButton!
    
    private var headerView: HeaderView?
    private var headerFilterView: HeaderView?
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let disposeBag = DisposeBag()

    private let viewModel: ItemListViewModel
    
    private var query: QueryViewData?
    private var selectedFilters: [QueryViewData] = []
    
    private var filters: [FilterViewData] = []
    
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
        bindFiltersFromViewModel()
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
        loadHeaderFilterTableView()
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
        
        var queryParams = selectedFilters
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
    
    private func loadHeaderFilterTableView() {
        headerFilterView = HeaderView(height: 50.0)
        headerFilterView!.filterButton.setTitle("Remove all filters", for: .normal)
        filtersTableView.tableHeaderView = headerFilterView
        bindRemoveAllFiltersAction()
    }
    
    private func bindHeaderFilterAction() {
        guard let header = headerView else { return }
        
        header.filterButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.filtersTableViewContainer.isHidden = false
            })
            .disposed(by: disposeBag)
    }
    
    private func bindRemoveAllFiltersAction() {
        guard let header = headerFilterView else { return }
        
        header.filterButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.filtersTableViewContainer.isHidden = true
                self?.selectedFilters = []
                self?.search()
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
    
    private func bindFiltersFromViewModel() {
        viewModel.output.filterList
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (filtersViewData) in
                if self.isHeaderTableViewEmpty {
                    self.loadHeaderTableView()
                }
                self.filters = filtersViewData
                self.filtersTableView.reloadData()
            })
            .disposed(by: disposeBag)
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
    
    private func selectFilter(_ filter: FilterViewData, _ filterValue: ValueViewData) {
        if let index = selectedFilters.firstIndex(where: {$0.key == filter.id}) {
            selectedFilters[index] = QueryViewData(key: filter.id, value: filterValue.id)
        } else {
            selectedFilters.append(QueryViewData(key: filter.id, value: filterValue.id))
        }
        search()
    }
    
    private func unselectFilter(_ filter: FilterViewData) {
        if let index = selectedFilters.firstIndex(where: {$0.key == filter.id}) {
            selectedFilters.remove(at: index)
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

extension ItemListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return filters.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == sectionExpanded {
            return max(filters[section].values.count, 1)
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterCellView.cellIdentifier, for: indexPath) as! FilterCellView
        
        let dataFilter = filters[indexPath.section]
        
        if dataFilter.values.count == 0 {
            cell.titleLabel.text = "Remove filter"
        } else {
            let dataValue = dataFilter.values[indexPath.row]
            cell.titleLabel.text = dataValue.name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView != filtersTableView {
            return nil
        }
        
        let header = FilterHeaderView(frame: CGRect(x: 0, y: 0, width: filtersTableView.bounds.width, height: 50.0))
        header.tag = section
        let data = filters[section]
        
        header.titleLabel.text = data.name
        header.subtitleLabel.text = (data.selected != nil) ? (data.selected?.name)! : ""
        
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
            sectionExpanded = nil
            filtersTableViewContainer.isHidden = true
            let dataFilter = filters[indexPath.section]
            if dataFilter.values.count == 0 {
                unselectFilter(dataFilter)
            } else {
                selectFilter(dataFilter, dataFilter.values[indexPath.row])
            }
        default:
            break
        }
    }
}
