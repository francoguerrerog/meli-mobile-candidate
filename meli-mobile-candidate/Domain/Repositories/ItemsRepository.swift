import Foundation

protocol ItemsRepository {
    func find() -> [Item]
    func put(_ items: [Item])
}
