import Foundation

struct SearchLocationResponse: Codable {
    let neighborhood: NeighborhoodResponse?
    let city: CityDataResponse?
    let state: StateDataResponse?
}
