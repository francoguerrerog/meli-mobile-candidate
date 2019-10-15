import Foundation
import RxSwift

protocol ItemDetailRepository {
    func find(itemId: String) -> Single<ItemDetailResponse>
}
