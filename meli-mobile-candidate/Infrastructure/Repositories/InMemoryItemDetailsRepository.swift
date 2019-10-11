import Foundation

class InMemoryItemDetailsRepository: ItemDetailsRepository {
    private var item: Item?
    
    func find() -> Item? {
        return item
    }
    
    func put(_ item: Item) {
        self.item = item
    }
}
