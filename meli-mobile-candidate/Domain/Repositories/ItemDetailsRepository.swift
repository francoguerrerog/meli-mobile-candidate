import Foundation

protocol ItemDetailsRepository {
    func find() -> Item?
    func put(_ item: Item)
}
