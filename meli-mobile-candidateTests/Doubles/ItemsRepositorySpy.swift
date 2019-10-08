import Foundation
@testable import meli_mobile_candidate

class ItemsRepositorySpy: ItemsRepository {
    var hasFind = false
    var hasPut = false
    
    func find() -> [ItemDataResponse] {
        hasFind = true
        return []
    }
    
    func put(_ items: [ItemDataResponse]) {
        hasPut = true
    }
}
