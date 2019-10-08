import Foundation

struct Installments {
    let quantity: Int
    let amount: Double
    let rate: Double
    let currencyId: String
    
    init(installmentsDataResponse: InstallmentsDataResponse) {
        self.quantity = installmentsDataResponse.quantity ?? 0
        self.amount = installmentsDataResponse.amount ?? 0
        self.rate = installmentsDataResponse.rate ?? 0
        self.currencyId = installmentsDataResponse.currencyId ?? ""
    }
}
