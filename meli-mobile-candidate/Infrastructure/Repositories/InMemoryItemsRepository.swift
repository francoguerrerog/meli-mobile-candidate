import Foundation

class InMemoryItemsRepository: ItemsRepository {
    private var items: [Item] = []
    
    func find() -> [Item] {
        return items
    }
    
    func put(_ items: [Item]) {
        self.items = items
    }
}
