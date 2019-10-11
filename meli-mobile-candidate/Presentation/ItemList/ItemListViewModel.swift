import Foundation
import RxSwift

class ItemListViewModel {
    
    struct Output {
        public let itemList: Observable<[Item]>
        public let searchConfigurations: Observable<SearchConfigurations>
        public let filterList: Observable<[FilterViewData]>
    }
    
    lazy public var output: Output = {
        return Output(itemList: itemListSubject.asObservable(),
                      searchConfigurations: searchConfigurationstSubject.asObservable(),
                      filterList: filterListSubject.asObservable())
    }()
    
    private let itemListSubject = PublishSubject<[Item]>()
    private let searchConfigurationstSubject = PublishSubject<SearchConfigurations>()
    private let filterListSubject = PublishSubject<[FilterViewData]>()
    
    private let disposeBag = DisposeBag()
    
    private let searchItemsAction: SearchItems
    
    init(searchItemsAction: SearchItems) {
        self.searchItemsAction = searchItemsAction
    }
    
    func search(queryParams: [QueryViewData]) {
        searchItemsAction.execute(filters: queryParams.map{QueryFilter(key: $0.key, value: $0.value)})
            .subscribe(onSuccess: { (searchResponse) in
                self.itemListSubject.onNext(searchResponse.items)
                self.emitSearchFilters(searchResponse.searchConfigurations)
            })
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
        
        searchConfigurationstSubject.onNext(searchConfigurations)
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
