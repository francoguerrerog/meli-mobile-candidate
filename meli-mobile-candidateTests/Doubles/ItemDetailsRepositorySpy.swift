import Foundation
@testable import meli_mobile_candidate

class ItemDetailsRepositorySpy: ItemDetailsRepository {
    var hasFind = false
    var hasPut = false
    
    func find() -> Item? {
        hasFind = true
        return Item(itemDataResponse: ItemDataResponse(id: "itemId", siteId: "siteId", title: "title", seller: SellerDataResponse(id: 1, powerSellerStatus: "", carDealer: false, realEstateAgency: false, tags: []), price: 0.0, currencyId: "", availableQuantity: 0, soldQuantity: 0, buyingMode: "", listingTypeId: "", stopTime: nil, condition: "", permalink: "", thumbnail: "", acceptsMercadopago: false, installments: nil, address: AddressDataResponse(stateId: "", stateName: "", cityId: "", cityName: ""), shipping: ShippingDataResponse(freeShipping: false, mode: "", tags: [], logisticType: "", storePickUp: false), sellerAddress: SellerAddressDataResponse(id: "", comment: "", addressLine: "", zipCode: "", country: nil, state: nil, city: nil, latitude: "", longitude: ""), attributes: [], originalPrice: 0.0, categoryId: "", officialStoreId: 1, catalogProductId: "", tags: []))
    }
    
    func put(_ item: Item) {
        hasPut = true
    }
}
