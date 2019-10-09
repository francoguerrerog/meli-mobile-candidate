import Foundation
import RxSwift

class ItemDetailViewModel {
    
    struct Output {
        public let item: Observable<Item>
    }
    
    lazy public var output: Output = {
        return Output(item: itemSubject.asObservable())
    }()
    
    private let itemSubject = PublishSubject<Item>()
    
    private let getItemDetailsAction: GetItemDetails
    
    init(getItemDetailsAction: GetItemDetails) {
        self.getItemDetailsAction = getItemDetailsAction
    }
    
    func getItemDetails(itemId: String) {
        guard let item = getItemDetailsAction.execute(itemId: itemId) else { return }
        
        itemSubject.onNext(item)
    }
}
