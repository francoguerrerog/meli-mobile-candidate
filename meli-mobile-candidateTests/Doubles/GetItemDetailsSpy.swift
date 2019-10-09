import Foundation
@testable import meli_mobile_candidate

class GetItemDetailsSpy: GetItemDetails {
    var hasExecuted = false
    
    func execute(itemId: String) -> Item? {
        hasExecuted = true
        return Item(itemDataResponse: ItemDataResponse(id: nil, siteId: nil, title: nil, seller: SellerDataResponse(id: nil, powerSellerStatus: nil, carDealer: nil, realEstateAgency: nil, tags: nil), price: nil, currencyId: nil, availableQuantity: nil, buyingMode: nil, listingTypeId: nil, stopTime: nil, condition: nil, permalink: nil, thumbnail: nil, acceptsMercadopago: nil, installments: InstallmentsDataResponse(quantity: nil, amount: nil, rate: nil, currencyId: nil), address: AddressDataResponse(stateId: nil, stateName: nil, cityId: nil, cityName: nil), shipping: ShippingDataResponse(freeShipping: nil, mode: nil, tags: nil, logisticType: nil, storePickUp: nil), sellerAddress: SellerAddressDataResponse(id: nil, comment: nil, addressLine: nil, zipCode: nil, country: nil, state: nil, city: nil, latitude: nil, longitude: nil), attributes: [], originalPrice: nil, categoryId: nil, officialStoreId: nil, catalogProductId: nil, tags: nil))
    }
}
