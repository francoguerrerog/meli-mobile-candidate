import Foundation
import RxSwift

class ItemListViewModel {
    
    struct Output {
        public let itemList: Observable<[Item]>
        public let filterList: Observable<[FilterViewData]>
        public let goToItemDetails: Observable<Void>
        public let errorMessage: Observable<String>
    }
    
    lazy public var output: Output = {
        return Output(itemList: itemListSubject.asObservable(),
                      filterList: filterListSubject.asObservable(),
                      goToItemDetails: goToItemDetailsSubject.asObservable(),
                      errorMessage: errorMessageSubject.asObservable())
    }()
    
    private let itemListSubject = PublishSubject<[Item]>()
    private let filterListSubject = PublishSubject<[FilterViewData]>()
    private let goToItemDetailsSubject = PublishSubject<Void>()
    private let errorMessageSubject = PublishSubject<String>()
    
    private let disposeBag = DisposeBag()
    
    private let searchItemsAction: SearchItems
    private let setItemDetailsAction: SetItemDetails
    
    init(searchItemsAction: SearchItems, setItemDetailsAction: SetItemDetails) {
        self.searchItemsAction = searchItemsAction
        self.setItemDetailsAction = setItemDetailsAction
    }
    
    func search(queryParams: [QueryViewData]) {
        searchItemsAction.execute(filters: queryParams.map{QueryFilter(key: $0.key, value: $0.value)})
            .subscribe(onSuccess: { [weak self] (searchResponse) in
                self?.itemListSubject.onNext(searchResponse.items)
                self?.emitSearchFilters(searchResponse.searchConfigurations)
            }) { [weak self] (error) in
                print("Error------- \(error)")
                self?.errorMessageSubject.onNext("Ops!, Error searching, please try again!.")
            }
            .disposed(by: disposeBag)
    }
    
    func selectItem(itemId: String) {
        setItemDetailsAction.execute(itemId: itemId)
            .subscribe(onCompleted: { [weak self] in
                self?.goToItemDetailsSubject.onNext(())
            }) { [weak self] (error) in
                print("Error------- \(error)")
                self?.errorMessageSubject.onNext("Ops!, It's not possible to load that item, please try another!.")
            }
            .disposed(by: disposeBag)
    }
    
    private func emitSearchFilters(_ searchConfigurations: SearchConfigurations) {
        var filterList:[FilterViewData] = []
        
        let sort = FilterViewData(id: "sort", name: "Sorted by", values: searchConfigurations.availableSorts.map{ValueViewData(id: $0.id!, name: $0.name!)}, selected: ValueViewData(id: searchConfigurations.sort.id!, name: searchConfigurations.sort.name!))
        filterList.append(sort)
        
        let filters = searchConfigurations.filters
            .filter{!self.isInAvailables($0, searchConfigurations.availableFilters)}
            .map{FilterViewData(id: $0.id!, name: $0.name!, values: [], selected: ValueViewData(id: ($0.values?.first?.id)!, name: ($0.values?.first?.name)!))}
        filterList.append(contentsOf: filters)
        
        let availableFilters = searchConfigurations.availableFilters.map{self.createAvailableFilter($0, searchConfigurations.filters)}
        filterList.append(contentsOf: availableFilters)
        
        filterListSubject.onNext(filterList)
    }
    
    private func isInAvailables(_ filter: FilterDataResponse, _ availableFilters: [FilterDataResponse]) -> Bool {
        return availableFilters.firstIndex(where: {$0.id == filter.id}) != nil
    }
    
    private func createAvailableFilter(_ availableFilter: FilterDataResponse, _ filters: [FilterDataResponse]) -> FilterViewData {
        let selectedFilter = filters.filter{$0.id! == availableFilter.id!}.first
        
        var selectedValue: ValueViewData?
        if let selected = selectedFilter {
            selectedValue = ValueViewData(id: (selected.values?.first?.id)!, name: (selected.values?.first?.name)!)
        }
        
        let values = availableFilter.values?.map{ValueViewData(id: $0.id!, name: $0.name!)} ?? []
        return FilterViewData(id: availableFilter.id!, name: availableFilter.name!, values: values, selected: selectedValue)
    }
}
