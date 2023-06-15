import Foundation
import SwiftUI
enum FontWeight: String {
    case helvetica = "helveticacyrillicupright"
    case uzSansBold = "UZSans-Bold"
    case uzSansLight = "UZSans-Light"
    case uzSansMedium = "UZSans-Medium"
    case uzSansRegular = "UZSans-Regular"
    case uzSansSemiBold = "UZSans-SemiBold"
    case pFBeauSansProItalic = "PFBeauSansPro-Italic"
    case pFBeauSansProLight = "PFBeauSansPro-Light"
    case pFBeauSansProRegular = "PFBeauSansPro-Regular"
    case pFBeauSansProSemiBold = "PFBeauSansPro-SemiBold"
    case pFBeauSansProThin = "PFBeauSansPro-Thin"
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

