
import UIKit


// MARK: UILabel helper methods
extension UILabel {

    // padding helper struct
    private struct AssociatedKeys {
        static var padding = UIEdgeInsets()
    }
    
    //add padding to  label
    public var padding: UIEdgeInsets? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.padding) as? UIEdgeInsets
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.padding, newValue as UIEdgeInsets?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    override open func draw(_ rect: CGRect) {
        if let insets = padding {
            self.drawText(in: rect.inset(by: insets))
        } else {
            self.drawText(in: rect)
        }
    }
    
    // add image to right of text
    
    // add image to label on right or lft (exclusively) throw error on other edges
    public static func  labelWithImage(_ text: String,  image: UIImage?, location: UIRectEdge)-> UILabel {
        let lbl = UILabel()
        lbl.font = Styles.Font.mediumTitle(ofSize: .xXLarge)
        let fullString = NSMutableAttributedString(string: "  " + text)
        let image1Attachment = NSTextAttachment()
        
        image1Attachment.image = image
        let image1String = NSMutableAttributedString(attachment: image1Attachment)
        
        if location == .right {
            fullString.append(image1String)
            lbl.attributedText = fullString
        } else if location == .left {
            image1String.append(fullString)
            lbl.attributedText = image1String
        } else {
            fatalError("label images must be added to the left or right")
        }
        
        return lbl
    }
    
    // set text to date
    func getStringFromDate(date: Date, withStyle style: DateFormatter.Style) {
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = style
            formatter.timeStyle = .none
            formatter.doesRelativeDateFormatting = false
            formatter.formattingContext = .standalone
            return formatter
        }()
        let output = dateFormatter.string(from: date)
        self.text = output
    }
    
    // set text to date time
    func setStringFromDateTime(date: Date, withStyle style: DateFormatter.Style) {
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = style
            formatter.timeStyle = .short
            formatter.doesRelativeDateFormatting = false
            formatter.formattingContext = .standalone
            return formatter
        }()
        let output = dateFormatter.string(from: date)
        self.text = output
    }
    
    // API date format is a string  with SWAPI conformance
    // method  takes string,  and  outputs an optional date
    func setDateFromStringFormat(_ payload: String, length: DateFormatter.Style) {
        
        let df = DateFormatter()
        if let date = df.date(rawString: payload) {
            setStringFromDateTime(date: date, withStyle: length)
        }
        
    }
    
    // find minimum heoght of label from desired text
    public func minimumHeight(forWidth desiredWidth: CGFloat) -> CGFloat {
        if desiredWidth == Device.width {
            return requiredHeight
        }
        
        let label = UILabel(frame: CGRect(origin: .zero, size: .init(desiredWidth, CGFloat.greatestFiniteMagnitude)))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }
    
    // Required height for a label
    public var requiredHeight: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: Device.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }
    
    // add shadow to label (usually used on top of images)
    public func set(textWithShadow content: String, lightShadow light: Bool = false, color: UIColor = .black) {
        
        // init shadow and set blur radius
        let shadow = NSShadow()
        shadow.shadowBlurRadius = 10
        // give color based on param
        if light { shadow.shadowColor = UIColor.white.cgColor }
        else { shadow.shadowColor = UIColor.black.cgColor }
        
        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 36),
            .foregroundColor: color,
            .shadow: shadow
        ]
        
        let attributedText = NSAttributedString(string: content, attributes: attrs)
        
        // set attribute to self
        self.attributedText = attributedText
    }
    
    // add drop shadow to text(not background)
    // use on backgrounds
    func textDropShadow(_ color: UIColor = .black) {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.35
        self.layer.shadowOffset = CGSize(width: 1, height: 2)
        self.layer.shadowColor = color.cgColor
    }
    
    /// initializer with no argument title
    convenience init(_ payload: String?) {
        self.init()
        text = payload
    }
}


// extensions for label with preset fonts & sizes
extension UILabel {
    
    // titlelabel
    static func title(_ payload: String? = nil, _ fontSize: Styles.FontSize = .xXLarge) -> UILabel {
        let lbl = UILabel(payload)
        lbl.font = Styles.Font.title(ofSize: fontSize)
        lbl.textColor = Styles.Colors.darkGray
        
        
        return lbl
    }
    
    // underline label
    func underline() {
        let attributedString = NSMutableAttributedString(string: text ?? "")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
        
        text = ""
        attributedText = attributedString
    }
    
    // titlelabel
    static func body(_ payload: String? = nil, _ fontSize: Styles.FontSize = .medium) -> UILabel {
        let lbl = UILabel(payload)
        lbl.font = Styles.Font.body(ofSize: fontSize)
        lbl.sizeToFit()
        
        return lbl
    }
    
    // mediumtitle
    static func mediumTitle(_ payload: String? = nil, _ fontSize: Styles.FontSize = .xLarge) -> UILabel {
        let lbl = UILabel(payload)
        lbl.font = Styles.Font.mediumTitle(ofSize: fontSize)
        lbl.sizeToFit()
        
        return lbl
    }
    
    // titlelabel
    static func lightBody(_ payload: String? = nil, _ fontSize: Styles.FontSize = .medium) -> UILabel {
        let lbl = UILabel(payload)
        lbl.font = Styles.Font.lightBody(ofSize: fontSize)
        lbl.sizeToFit()
        
        return lbl
    }
}
