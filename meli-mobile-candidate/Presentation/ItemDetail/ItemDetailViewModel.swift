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
    
    func getItemDetails() {
        guard let item = getItemDetailsAction.execute() else { return }
        
        itemSubject.onNext(item)
    }
}
