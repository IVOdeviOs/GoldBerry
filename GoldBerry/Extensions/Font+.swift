import SwiftUI

enum FontWeight: String {
    case helvetica = "helveticacyrillicupright"
}

enum FontSize: CGFloat {
    case size12 = 12
    case size16 = 16
    case size18 = 18
    case size20 = 20
    case size24 = 24
    case size32 = 32
}

extension UIFont {
    static func fontLibrary(_ size: FontSize, _ weight: FontWeight) -> UIFont {
        UIFont(name: weight.rawValue, size: size.rawValue) ?? .systemFont(ofSize: 16)
    }
}

extension Font {
    init(uiFont: UIFont) {
        self = Font(uiFont as CTFont)
    }
}
