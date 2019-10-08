import Foundation

struct SellerDataResponse: Codable {
    let id: Int?
    let powerSellerStatus: String?
    let carDealer: Bool?
    let realEstateAgency: Bool?
    let tags: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case powerSellerStatus = "power_seller_status"
        case carDealer = "car_dealer"
        case realEstateAgency = "real_estate_agency"
        case tags = "tags"
    }
}
