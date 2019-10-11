import Foundation

protocol GetItemDetails {
    func execute() -> Item?
}

class GetItemDetailsDefault: GetItemDetails {
    let itemDetailsRepository: ItemDetailsRepository
    
    init(itemDetailsRepository: ItemDetailsRepository) {
        self.itemDetailsRepository = itemDetailsRepository
    }
    
    func execute() -> Item? {
        return itemDetailsRepository.find()
    }
}
