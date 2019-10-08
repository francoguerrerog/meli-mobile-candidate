import Foundation

struct SellerAddressDataResponse: Codable {
    let id: String?
    let comment: String?
    let addressLine: String?
    let zipCode: String?
    let country: CountryDataResponse?
    let state: StateDataResponse?
    let city: CityDataResponse?
    let latitude: String?
    let longitude: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case comment = "comment"
        case addressLine = "address_line"
        case zipCode = "zip_code"
        case country = "country"
        case state = "state"
        case city = "city"
        case latitude = "latitude"
        case longitude = "longitude"
    }
}
