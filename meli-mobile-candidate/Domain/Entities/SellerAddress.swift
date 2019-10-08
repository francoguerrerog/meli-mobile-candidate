import Foundation

struct SellerAddress {
    let id: String
    let comment: String
    let addressLine: String
    let zipCode: String
    let country: CountryDataResponse?
    let state: StateDataResponse?
    let city: CityDataResponse?
    let latitude: String
    let longitude: String
    
    init(sellerAddressDataResponse: SellerAddressDataResponse) {
        self.id = sellerAddressDataResponse.id ?? ""
        self.comment = sellerAddressDataResponse.comment ?? ""
        self.addressLine = sellerAddressDataResponse.addressLine ?? ""
        self.zipCode = sellerAddressDataResponse.zipCode ?? ""
        self.country = sellerAddressDataResponse.country
        self.state = sellerAddressDataResponse.state
        self.city = sellerAddressDataResponse.city
        self.latitude = sellerAddressDataResponse.latitude ?? ""
        self.longitude = sellerAddressDataResponse.longitude ?? ""
    }
}
