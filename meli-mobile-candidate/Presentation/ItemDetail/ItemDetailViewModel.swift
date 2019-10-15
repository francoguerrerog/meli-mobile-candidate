import Foundation
import RxSwift

class ItemDetailViewModel {
    
    struct Output {
        public let item: Observable<Item>
        public let itemDetails: Observable<ItemDetailResponse>
        public let errorMessage: Observable<String>
    }
    
    lazy public var output: Output = {
        return Output(item: itemSubject.asObservable(),
                      itemDetails: itemDetailsSubject.asObservable(),
                      errorMessage: errorMessageSubject.asObservable())
    }()
    
    private let itemSubject = PublishSubject<Item>()
    private let itemDetailsSubject = PublishSubject<ItemDetailResponse>()
    private let errorMessageSubject = PublishSubject<String>()
    
    private let disposeBag = DisposeBag()
    
    private let getItemDetailsAction: GetItemDetails
    private let getItemFullDetailsAction: GetItemFullDetails
    
    init(getItemDetailsAction: GetItemDetails, getItemFullDetailsAction: GetItemFullDetails) {
        self.getItemDetailsAction = getItemDetailsAction
        self.getItemFullDetailsAction = getItemFullDetailsAction
    }
    
    func getItemDetails() {
        guard let item = getItemDetailsAction.execute() else { return }
        
        itemSubject.onNext(item)
        
        getItemFullDetails(item)
    }
    
    func getItemFullDetails(_ item: Item) {
        getItemFullDetailsAction.execute(itemId: item.id)
            .subscribe(onSuccess: { [weak self] (itemDetail) in
                self?.itemDetailsSubject.onNext(itemDetail)
                }, onError: { [weak self] (error) in
                    print("Error------- \(error)")
                    self?.errorMessageSubject.onNext("Ops!. We coudn't find full description of the product, try again")
            })
            .disposed(by: disposeBag)
    }
}
