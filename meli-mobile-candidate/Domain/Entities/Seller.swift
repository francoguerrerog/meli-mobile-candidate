import Foundation

struct Seller {
    let id: Int
    let powerSellerStatus: String
    let carDealer: Bool
    let realEstateAgency: Bool
    let tags: [String]
    
    init(sellerDataResponse: SellerDataResponse) {
        self.id = sellerDataResponse.id ?? 0
        self.powerSellerStatus = sellerDataResponse.powerSellerStatus ?? ""
        self.carDealer = sellerDataResponse.carDealer ?? false
        self.realEstateAgency = sellerDataResponse.realEstateAgency ?? false
        self.tags = sellerDataResponse.tags ?? []
    }
}
