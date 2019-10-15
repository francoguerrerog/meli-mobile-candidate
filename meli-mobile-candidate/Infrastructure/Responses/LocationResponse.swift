import Foundation

struct LocationResponse: Codable {
    let address_line: String?
    let zip_code: String?
    let neighborhood: NeighborhoodResponse?
    let city: CityDataResponse?
    let state: StateDataResponse?
    let country: CountryDataResponse?
    let latitude: Double?
    let longitude: Double?
}
