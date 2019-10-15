import Foundation

struct SellerAddressResponse: Codable {
    let city: CityDataResponse
    let state: StateDataResponse
    let country: CountryDataResponse
    let search_location: SearchLocationResponse
    let latitude: Double
    let longitude: Double
    let id: Int
}
