import Foundation

class InMemoryItemsRepository: ItemsRepository {
    private var items: [ItemDataResponse] = []
    func find() -> [ItemDataResponse] {
        return items
    }
    
    func put(_ items: [ItemDataResponse]) {
        self.items = items
    }
}
