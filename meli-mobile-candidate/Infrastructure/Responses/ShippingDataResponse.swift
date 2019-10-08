import Foundation

struct ShippingDataResponse: Codable {
    let freeShipping: Bool?
    let mode: String?
    let tags: [String]?
    let logisticType: String?
    let storePickUp: Bool?
    
    enum CodingKeys: String, CodingKey {
        case freeShipping = "free_shipping"
        case mode = "mode"
        case tags = "tags"
        case logisticType = "logistic_type"
        case storePickUp = "store_pick_up"
    }
}
