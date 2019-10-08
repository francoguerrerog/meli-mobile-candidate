import Foundation

protocol GetItemDetails {
    func execute(itemId: String) -> Item?
}

class GetItemDetailsDefault: GetItemDetails {
    let itemsRepository: ItemsRepository
    
    init(itemsRepository: ItemsRepository) {
        self.itemsRepository = itemsRepository
    }
    
    func execute(itemId: String) -> Item? {
        return itemsRepository.find().filter{$0.id == itemId}.first
    }
}
