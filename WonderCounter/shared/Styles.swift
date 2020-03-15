
import UIKit

// Styles handles all static content delivered
//   - sizes
//   - colors
//   - fonts
//   - padding
//   - non-device relatable sizin (see Devices class)

// MARK: Styles
final class Styles {
    
    // table view cells will have an additional padding to create spacing that collectionview has built in
    struct CellSizes {
        
        static let project: CGFloat = CGFloat(121).addPadding(.medium, multiplier: 2)
        static let toDo: CGFloat = CGFloat(75).addPadding(.small, multiplier: 2)
        static let message: CGFloat = CGFloat(70).addPadding(.small)
        static let client: CGFloat = 90
        static let quote: CGFloat = 95
        static let noContent: CGFloat = 310

    }
    
    
    
    // font size
    enum FontSize: CGFloat {
        case xXSmall = 8.0
        case xSmall  = 10.0
        case small   = 12.0
        case medium  = 14.0
        case large   = 16.0
        case xLarge  = 18.0
        case xXLarge = 20.0
        case xxXLarge = 30.0
        case max     = 40.0
        case emoji   = 60.0
    }

    // font
    // font is named "poppins", backup being system default
    struct Font {
        static func title(ofSize size: FontSize = FontSize.xXLarge) -> UIFont {
            if let font = UIFont(name: "Poppins-Bold", size: size.rawValue) { return font }
            
            return UIFont.systemFont(ofSize: size.rawValue, weight: .bold)
        }
        static func mediumTitle(ofSize size: FontSize = FontSize.xLarge) -> UIFont {
            if let font = UIFont(name: "Poppins-SemiBold", size: size.rawValue) { return font }
            return UIFont.systemFont(ofSize: size.rawValue, weight: .medium)
        }
        static func body(ofSize size: FontSize = FontSize.medium) -> UIFont {
            if let font = UIFont(name: "Poppins-Regular", size: size.rawValue) { return font }
            return UIFont.systemFont(ofSize: size.rawValue, weight: .regular)
        }
        static func lightBody(ofSize size: FontSize = FontSize.small) -> UIFont {
            if let font = UIFont(name: "Poppins-Light", size: size.rawValue) { return font }
            return UIFont.systemFont(ofSize: size.rawValue, weight: .light)
        }
    }
    
    // colors
    struct Colors {
        
        // background
        static let darkGray      = UIColor(hex: "5C5C5C")
        static let lightGray     = UIColor(hex: "ECECEC")
        static let overlayWhite  = UIColor(hex: "ffffff").withAlphaComponent(0.24)
        static let offWhite      = UIColor(hex: "F4F4F5")
        static let yellow        = UIColor(hex: "FFC260")
        static let primaryRed    = UIColor(hex: "EF5350")
        static let primaryBlue   = UIColor(hex: "475AF0")
        static let secondaryBlue = UIColor(hex: "84A3FB")
        static let accentBlue    = UIColor(hex: "A1BAFF")
        static let primaryGreen     = UIColor(hex: "4DB6AC")
        static let white         = UIColor(hex: "FFFFFE")
        static let black         = UIColor(hex: "010000")
        
        // misc
        static let secondaryGray  = UIColor(hex: "7D7D7D")
        static let secondaryGreen = UIColor(hex: "318B82")
        static let bglightBlue    = UIColor(hex: "D9E0F5")
        static let bglightClay    = UIColor(hex: "EBF0FF")
        static let darkBlue       = UIColor(hex: "132749")
    }
    
    
}

// padding
enum Padding: CGFloat {
    case xSmall = 2.0
    case small  = 5.0
    case medium = 10.0
    case large  = 15.0
    case xLarge = 20.0
    case xXLarge = 35.0
}


// MARK: CGFLoat padding helper methods
extension CGFloat {
    
    // add standard defined padding to given float
    func addPadding(_ padding: Padding = .large, multiplier: CGFloat = 1) -> CGFloat {
        return self + (padding.rawValue * multiplier)
    }
    
    // subtract standard defined padding to given float
    func subtractPadding(_ padding: Padding = .large, multiplier: CGFloat = 1) -> CGFloat {
        return self - (padding.rawValue * multiplier)
    }
}


final class Device {
    
    static let width  = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let frame  = UIScreen.main.bounds
    static let tabBarheight = CGFloat(88)

}
