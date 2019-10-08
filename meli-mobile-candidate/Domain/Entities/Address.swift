import Foundation

struct Address {
    let stateId: String
    let stateName: String
    let cityId: String
    let cityName: String
    
    init(addressDataResponse: AddressDataResponse) {
        self.stateId = addressDataResponse.stateId ?? ""
        self.stateName = addressDataResponse.stateName ?? ""
        self.cityId = addressDataResponse.cityId ?? ""
        self.cityName = addressDataResponse.cityName ?? ""
    }
}
