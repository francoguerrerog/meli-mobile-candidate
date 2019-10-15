import Foundation
import RxSwift

protocol GetItemFullDetails {
    func execute(itemId: String) -> Single<ItemDetailResponse>
}

class GetItemFullDetailsDefault: GetItemFullDetails {
    private let itemDetailRepository: ItemDetailRepository
    
    init(itemDetailRepository: ItemDetailRepository) {
        self.itemDetailRepository = itemDetailRepository
    }
    
    func execute(itemId: String) -> Single<ItemDetailResponse> {
        return itemDetailRepository.find(itemId: itemId)
    }
}
