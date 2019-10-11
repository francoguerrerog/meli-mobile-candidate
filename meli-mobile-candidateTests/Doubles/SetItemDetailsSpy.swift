import Foundation
import RxSwift
@testable import meli_mobile_candidate

class SetItemDetailsSpy: SetItemDetails {
    var hasExecuted = false
    
    func execute(itemId: String) -> Completable {
        hasExecuted = true
        return Completable.empty()
    }
}
