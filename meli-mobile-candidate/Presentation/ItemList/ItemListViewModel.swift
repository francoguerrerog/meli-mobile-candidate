import Foundation
import RxSwift

class ItemListViewModel {
    
    struct Output {
        public let itemList: Observable<[Item]>
        public let searchConfigurations: Observable<SearchConfigurations>
    }
    
    lazy public var output: Output = {
        return Output(itemList: itemListSubject.asObservable(),
                      searchConfigurations: SearchConfigurationstSubject.asObservable())
    }()
    
    private let itemListSubject = PublishSubject<[Item]>()
    private let SearchConfigurationstSubject = PublishSubject<SearchConfigurations>()
    
    private let disposeBag = DisposeBag()
    
    private let searchItemsAction: SearchItems
    
    init(searchItemsAction: SearchItems) {
        self.searchItemsAction = searchItemsAction
    }
    
    func search(queryParams: [QueryViewData]) {
        searchItemsAction.execute(filters: queryParams.map{QueryFilter(key: $0.key, value: $0.value)})
            .subscribe(onSuccess: { (searchResponse) in
                self.itemListSubject.onNext(searchResponse.items)
                self.SearchConfigurationstSubject.onNext(searchResponse.searchConfigurations)
            })
            .disposed(by: disposeBag)
    }
}
