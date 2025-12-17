import Foundation

struct CurrencyFormatter: CurrencyFormatterProtocol {
    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.locale = Locale(identifier: "en_US")
        formatter.maximumFractionDigits = 0
        return formatter
    }()
    
    func format(_ amount: Int) -> String {
        Self.formatter.string(from: NSNumber(value: amount)) ?? "$\(amount)"
    }
}

