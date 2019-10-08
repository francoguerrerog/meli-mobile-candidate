import Foundation
@testable import meli_mobile_candidate

class ItemsRepositorySpy: ItemsRepository {
    var hasFind = false
    var hasPut = false
    
    func find() -> [Item] {
        hasFind = true
        return []
    }
    
    func put(_ items: [Item]) {
        hasPut = true
    }
}
