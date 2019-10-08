import Foundation

protocol GetItems {
    func execute() -> [Item]
}

class GetItemsDefault: GetItems {
    private let itemsRepository: ItemsRepository
    
    init(itemsRepository: ItemsRepository) {
        self.itemsRepository = itemsRepository
    }
    
    func execute() -> [Item] {
        return itemsRepository.find()
    }
}
