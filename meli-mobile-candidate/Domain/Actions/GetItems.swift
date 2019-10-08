import Foundation

protocol GetItems {
    func execute() -> [ItemDataResponse]
}

class GetItemsDefault: GetItems {
    private let itemsRepository: ItemsRepository
    
    init(itemsRepository: ItemsRepository) {
        self.itemsRepository = itemsRepository
    }
    
    func execute() -> [ItemDataResponse] {
        return itemsRepository.find()
    }
}
