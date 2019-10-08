import Foundation

struct AddressDataResponse: Codable {
    let stateId: String?
    let stateName: String?
    let cityId: String?
    let cityName: String?
    
    enum CodingKeys: String, CodingKey {
        case stateId = "state_id"
        case stateName = "state_name"
        case cityId = "city_id"
        case cityName = "city_name"
    }
}
