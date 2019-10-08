import Foundation

struct Item {
    let id: String
    let siteId: String
    let title: String
    let seller: Seller
    let price: Double
    let currencyId: String
    let availableQuantity: Int
    let buyingMode: String
    let listingTypeId: String
    let stopTime: Date
    let condition: String
    let permalink: String
    let thumbnail: String
    let acceptsMercadopago: Bool
    let installments: Installments
    let address: Address
    let shipping: Shipping
    let sellerAddress: SellerAddress
    let attributes: [Attributes]
    let originalPrice: Double
    let categoryId: String
    let officialStoreId: Int
    let catalogProductId: String
    let tags: [String]
    
    init(itemDataResponse: ItemDataResponse) {
        self.id = itemDataResponse.id ?? ""
        self.siteId = itemDataResponse.siteId ?? ""
        self.title = itemDataResponse.title ?? ""
        self.seller = Seller(sellerDataResponse: itemDataResponse.seller)
        self.price = itemDataResponse.price ?? 0
        self.currencyId = itemDataResponse.currencyId ?? ""
        self.availableQuantity = itemDataResponse.availableQuantity ?? 0
        self.buyingMode = itemDataResponse.buyingMode ?? ""
        self.listingTypeId = itemDataResponse.listingTypeId ?? ""
        self.stopTime = itemDataResponse.stopTime ?? Date()
        self.condition = itemDataResponse.condition ?? ""
        self.permalink = itemDataResponse.permalink ?? ""
        self.thumbnail = itemDataResponse.thumbnail ?? ""
        self.acceptsMercadopago = itemDataResponse.acceptsMercadopago ?? false
        self.installments = Installments(installmentsDataResponse: itemDataResponse.installments)
        self.address = Address(addressDataResponse: itemDataResponse.address)
        self.shipping = Shipping(shippingDataResponse: itemDataResponse.shipping)
        self.sellerAddress = SellerAddress(sellerAddressDataResponse: itemDataResponse.sellerAddress)
        self.attributes = itemDataResponse.attributes.map{Attributes(attributesDataResponse: $0)}
        self.originalPrice = itemDataResponse.originalPrice ?? 0
        self.categoryId = itemDataResponse.categoryId ?? ""
        self.officialStoreId = itemDataResponse.officialStoreId ?? 0
        self.catalogProductId = itemDataResponse.catalogProductId ?? ""
        self.tags = itemDataResponse.tags ?? []
    }
}
