import UIKit

enum Theme {
    enum Colors {
        static let primary = UIColor(hex: "#9B8FE8")
        static let secondary = UIColor(hex: "#00F5FF")
        static let accent = UIColor(hex: "#FF2D95")
        static let gold = UIColor(hex: "#FCD34D")
        static let success = UIColor(hex: "#10B981")
        static let background = UIColor(hex: "#0F0F14")
        static let backgroundLight = UIColor(hex: "#1A1A2E")
        static let cardBackground = UIColor(hex: "#1E1E2E")
        static let textPrimary = UIColor.white
        static let textSecondary = UIColor(hex: "#A0A0B0")
        static let locked = UIColor(hex: "#4A4A5A")
    }

    enum Fonts {
        static func bold(_ size: CGFloat) -> UIFont {
            return UIFont.systemFont(ofSize: size, weight: .bold)
        }
        static func semibold(_ size: CGFloat) -> UIFont {
            return UIFont.systemFont(ofSize: size, weight: .semibold)
        }
        static func medium(_ size: CGFloat) -> UIFont {
            return UIFont.systemFont(ofSize: size, weight: .medium)
        }
        static func regular(_ size: CGFloat) -> UIFont {
            return UIFont.systemFont(ofSize: size, weight: .regular)
        }
        static func mono(_ size: CGFloat) -> UIFont {
            return UIFont.monospacedSystemFont(ofSize: size, weight: .medium)
        }
    }

    enum Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 16
        static let lg: CGFloat = 24
        static let xl: CGFloat = 32
        static let xxl: CGFloat = 48
    }

    enum CornerRadius {
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
    }
}

extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            red: CGFloat(r) / 255,
            green: CGFloat(g) / 255,
            blue: CGFloat(b) / 255,
            alpha: CGFloat(a) / 255
        )
    }
}