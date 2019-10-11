import Foundation
import RxSwift

protocol SetItemDetails {
    func execute(itemId: String) -> Completable
}

class SetItemDetailsDefault: SetItemDetails {
    private let itemsRepository: ItemsRepository
    private let itemDetailsRepository: ItemDetailsRepository
    
    init(itemsRepository: ItemsRepository, itemDetailsRepository: ItemDetailsRepository) {
        self.itemsRepository = itemsRepository
        self.itemDetailsRepository = itemDetailsRepository
    }
    
    func execute(itemId: String) -> Completable {
        
        let items = self.itemsRepository.find().filter{$0.id == itemId}
        guard let item = items.first else {
            return Completable.error(DomainError.itemNotFoundError)
        }
        
        self.itemDetailsRepository.put(item)
        return Completable.empty()
    }
}
