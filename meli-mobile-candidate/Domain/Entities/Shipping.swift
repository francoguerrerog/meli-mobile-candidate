import Foundation

struct Shipping {
    let freeShipping: Bool
    let mode: String
    let tags: [String]
    let logisticType: String
    let storePickUp: Bool
    
    init(shippingDataResponse: ShippingDataResponse) {
        self.freeShipping = shippingDataResponse.freeShipping ?? false
        self.mode = shippingDataResponse.mode ?? ""
        self.tags = shippingDataResponse.tags ?? []
        self.logisticType = shippingDataResponse.logisticType ?? ""
        self.storePickUp = shippingDataResponse.storePickUp ?? false
    }
}
