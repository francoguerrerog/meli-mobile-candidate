import Foundation

protocol ItemsRepository {
    func find() -> [ItemDataResponse]
    func put(_ items: [ItemDataResponse])
}
