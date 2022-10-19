import SwiftUI

enum FontWeight: String {
    case helvetica = "helveticacyrillicupright"
    case uzSansBold = "UZSans-Bold"
    case uzSansLight = "UZSans-Light"
    case uzSansMedium = "UZSans-Medium"
    case uzSansRegular = "UZSans-Regular"
    case uzSansSemiBold = "UZSans-SemiBold"
}

extension UIFont {
    static func fontLibrary(_ size: CGFloat, _ weight: FontWeight) -> UIFont {
        UIFont(name: weight.rawValue, size: size) ?? .systemFont(ofSize: 16)
    }
}

extension Font {
    init(uiFont: UIFont) {
        self = Font(uiFont as CTFont)
    }
}
