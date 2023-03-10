//
//  Extensions.swift
//  Reflex
//
//  Created by Maaz on 26/07/22.
//

import Foundation
import UIKit

typealias Params = [String: Any]

//MARK: UIImage

extension UIImage {
    func imageResized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

//MARK: UIView

extension UIView {
    
    
    public var width: CGFloat {
        return self.frame.size.width
    }
    
    public var height: CGFloat{
        return frame.size.height
    }
    
    public var top: CGFloat{
        return frame.origin.y
    }
    
    public var bottom: CGFloat{
        return frame.size.height + frame.origin.y
    }
    
    public var left: CGFloat{
        return frame.origin.x
    }
    
    public var right: CGFloat{
        return frame.size.width + frame.origin.x
    }
    
    func tamic() {
        self.translatesAutoresizingMaskIntoConstraints = true
    }
    
    func Activate(_ Constraints: [NSLayoutConstraint]){
        NSLayoutConstraint.activate(Constraints)
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -(padding.right)).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -(padding.bottom)).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func centerToX() {
        
        guard let superview = self.superview else {
            
            print ("DEBUG: Could not find superview")
            return
        }
        
        self.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
    }
    
    func centerToY() {
        
        guard let superview = self.superview else {
            
            print ("DEBUG: Could not find superview")
            return
        }
        
        self.centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
    }
    
    func setWidth(_ width: CGFloat) {
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setHeight(_ height: CGFloat) {
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func widthGreaterThanOrEqualToConstant(_ width: CGFloat) {
        self.widthAnchor.constraint(greaterThanOrEqualToConstant: width).isActive = true
    }
    
    func heightGreaterThanOrEqualToConstant(_ height: CGFloat) {
        self.heightAnchor.constraint(greaterThanOrEqualToConstant: height).isActive = true
    }
    
    func widthLessThanOrEqualTo(_ width: CGFloat) {
        self.widthAnchor.constraint(lessThanOrEqualToConstant: width).isActive = true
    }
    
    func heightLessThanOrEqualTo(_ height: CGFloat) {
        self.heightAnchor.constraint(lessThanOrEqualToConstant: height).isActive = true
    }
    
    func drawLine(on view: UIView, lineThickness: CGFloat = 1, lineColor: UIColor = UIColor.black, lineWidth: CGFloat ) {
        
        let bp = UIBezierPath()
        bp.move(to: CGPoint(x: 0, y: 0))
        bp.addLine(to: CGPoint(x: lineWidth, y: 0))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.backgroundColor = lineColor.cgColor
        shapeLayer.path = bp.cgPath
        shapeLayer.lineWidth = lineThickness
        shapeLayer.contentsGravity = .center
        
        view.layer.addSublayer(shapeLayer)
    }
    
    func addInnerShadow() {
        
        let innerShadow = CALayer()
        innerShadow.frame = bounds
        
        // Shadow path (1pt ring around bounds)
        let radius = self.layer.cornerRadius
        let path = UIBezierPath(roundedRect: innerShadow.bounds.insetBy(dx: 0, dy:2), cornerRadius:radius)
        let cutout = UIBezierPath(roundedRect: .init(x: 0, y: 0, width: width, height: height - 2), cornerRadius:radius).reversing()
        
        path.append(cutout)
        innerShadow.shadowPath = path.cgPath
        innerShadow.masksToBounds = true
        
        // Shadow properties
        innerShadow.shadowColor = UIColor.black.cgColor
        innerShadow.shadowOffset = CGSize(width: 0, height: 0)
        innerShadow.shadowOpacity = 0.3
        innerShadow.shadowRadius = 5
        innerShadow.cornerRadius = self.layer.cornerRadius
        layer.addSublayer(innerShadow)
    }
    
    func setShadow(on view: UIView, color: UIColor = .black, shadowRadius:CGFloat = 5, shadowOpacity: Float = 5, shadowOffset: CGSize = .zero) {
        
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = .zero
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }

}

//MARK: CALayer

extension CALayer {
    
    func drawLine(onLayer layer: CALayer, fromPoint start: CGPoint, toPoint end: CGPoint) {
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)
        line.path = linePath.cgPath
        line.fillColor = nil
        line.opacity = 1.0
        line.strokeColor = UIColor.gray.cgColor
        layer.addSublayer(line)
    }
}

//MARK: Text Field

extension UITextField {
    
    
    func setPlaceholder(text: String, color: UIColor, underline: NSUnderlineStyle? = nil, font: UIFont? = nil) {
        
        if let underline = underline {
            
            self.attributedPlaceholder = NSAttributedString( string: text.localized(),
                                                             attributes: [.foregroundColor:color,
                                                                          .underlineStyle: underline.rawValue,
                                                             ])
        } else if  let font = font {
            
            self.attributedPlaceholder = NSAttributedString( string: text.localized(),
                                                             attributes: [.foregroundColor:color,
                                                                          .font: font
                                                             ])
        } else if let font = font, let underline = underline {
            
            self.attributedPlaceholder = NSAttributedString( string: text.localized(),
                                                             attributes: [.foregroundColor:color,
                                                                          .font: font,
                                                                          .underlineStyle: underline,
                                                             ])
        }  else {
            
            self.attributedPlaceholder = NSAttributedString( string: text.localized(),
                                                             attributes: [NSAttributedString.Key.foregroundColor:color])
        }
        
    }
    
    func setUnderLine(_ color: UIColor) {
        
        let border = CALayer()
        border.borderColor = color.cgColor
        let underlineWidth = self.width/1.05
        border.frame = CGRect(x: self.width - (self.width/2) - (underlineWidth/2), y: self.height - 1, width: underlineWidth, height: 1)
        border.borderWidth = 1
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
}

//MARK: TextView

extension UITextView {
    
}

//MARK: UIColor

extension UIColor
{
    var isDarkColor: Bool {
        var r, g, b, a: CGFloat
        (r, g, b, a) = (0, 0, 0, 0)
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let lum = 0.2126 * r + 0.7152 * g + 0.0722 * b
        return  lum < 0.50
    }
}

//MARK: Button

extension UIButton {
    
    func setButton(title: String, textColor: UIColor, font: UIFont, underline: NSUnderlineStyle? = nil) {
        
        var yourAttributes = [NSAttributedString.Key : Any]()
        
        if let underline = underline {
            
            yourAttributes = [
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: textColor,
                NSAttributedString.Key.underlineStyle: underline.rawValue,
            ] as [NSAttributedString.Key : Any]
            
        } else {
            
            yourAttributes = [
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: textColor,
            ] as [NSAttributedString.Key : Any]
            
        }
        
        let attributeString = NSMutableAttributedString(
            string: title, attributes: yourAttributes
        )
        
        self.setAttributedTitle(attributeString, for: .normal)
        
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

//MARK: UIImage

extension UIImage {
    
    func resizedImage(at url: URL, for size: CGSize) -> UIImage? {
        guard let image = UIImage(contentsOfFile: url.path) else {
            return nil
        }
        
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
    func createSelectionIndicator(color: UIColor, size: CGSize, lineWidth: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: size.width - ((size.width/1.2)/2) - size.width/2, y: 0, width: size.width/1.2, height: lineWidth))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
    
    func withAlpha(_ a: CGFloat) -> UIImage {
        return UIGraphicsImageRenderer(size: size, format: imageRendererFormat).image { (_) in
            draw(in: CGRect(origin: .zero, size: size), blendMode: .normal, alpha: a)
        }
    }
    
    func withInset(_ insets: UIEdgeInsets) -> UIImage? {
        let cgSize = CGSize(width: self.size.width + insets.left * self.scale + insets.right * self.scale,
                            height: self.size.height + insets.top * self.scale + insets.bottom * self.scale)
        
        UIGraphicsBeginImageContextWithOptions(cgSize, false, self.scale)
        defer { UIGraphicsEndImageContext() }
        
        let origin = CGPoint(x: insets.left * self.scale, y: insets.top * self.scale)
        self.draw(at: origin)
        
        return UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(self.renderingMode)
    }
    
    func resizeImageTo(size: CGSize) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resizedImage
    }
}

//MARK: URL

extension URL {
    
    static func localURLForXCAsset(name: String) -> URL? {
        let fileManager = FileManager.default
        guard let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {return nil}
        let url = cacheDirectory.appendingPathComponent("\(name).png")
        let path = url.path
        if !fileManager.fileExists(atPath: path) {
            guard let image = UIImage(named: name), let data = image.pngData() else {return nil}
            fileManager.createFile(atPath: path, contents: data, attributes: nil)
        }
        return url
    }
}

//MARK: UIColor

extension UIColor {
    
}


//MARK: UILabel

extension UITextView {
    
    func setParagraphProperties(lineSpacing: CGFloat, lineHeight: CGFloat, text: String, font: UIFont?, textColor: UIColor?) {
        
        
        let AttributedString = NSAttributedString(string: text).withLineSpacing(lineSpacing, lineHeight: lineHeight, font: font, textColor: textColor)
        
        self.attributedText = AttributedString
    }
}

extension UILabel {
    
    func setParagraphProperties(lineSpacing: CGFloat, lineHeight: CGFloat, text: String, font: UIFont?, textColor: UIColor?) {
        
        let AttributedString = NSAttributedString(string: text).withLineSpacing(lineSpacing, lineHeight: lineHeight, font: font, textColor: textColor)
        self.attributedText = AttributedString
    }
}

//MARK: NSAttributedString

extension NSAttributedString{
    
    func withLineSpacing(_ spacing: CGFloat, lineHeight: CGFloat, font: UIFont?, textColor: UIColor?) -> NSAttributedString {
        
        let attributedString = NSMutableAttributedString(attributedString: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        paragraphStyle.alignment = .center
        paragraphStyle.paragraphSpacing = 0
        //paragraphStyle.paragraphSpacing = 0
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        paragraphStyle.lineSpacing = spacing
        
        attributedString.addAttribute(.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSRange(location: 0, length: string.count))
        if let font {
        
            attributedString.addAttribute(.font, value: font, range: NSRange(location: 0, length: string.count))
            
        }
        
        if let textColor {
            
            attributedString.addAttribute(.foregroundColor, value: textColor, range: NSRange(location: 0, length: string.count))
        }
        
        return NSAttributedString(attributedString: attributedString)
    }
}

//MARK: UINavigationController

extension UINavigationController {
    
    func hideNavigationBackground() {
        
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.view.backgroundColor = UIColor.clear
    }
    
    
    var rootViewController: UIViewController? {
        return viewControllers.first
    }
    
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
            popToViewController(vc, animated: animated)
        }
    }
}

//MARK: UIScrollView

extension UIScrollView {
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.next?.touchesBegan(touches, with: event)
        print("touchesBegan")
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.next?.touchesMoved(touches, with: event)
        print("touchesMoved")
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.next?.touchesEnded(touches, with: event)
        print("touchesEnded")
    }
    
}

//MARK: Notification Center

extension Notification.Name {
    
    static let didTapTAndCButton = Notification.Name("didTapTAndCButton")
    
    static let didLogin = Notification.Name("didLogin")
    
    static let didLogOut = Notification.Name("didLogOut")
}


//MARK: URLSession

extension URLSession {
    
    
}

//MARK: String

extension String {
    
    
    func isEmailNotValid() -> Bool {
        
        guard self.count > 0 else {
            return true
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        let result = emailTest.evaluate(with: self)
        
        return !result
        
    }
  
    func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }

        guard let characterSpacing = characterSpacing else {return attributedString}

        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))

        return attributedString
    }
    
    func localized() -> String {
        
        return NSLocalizedString(self,
                                 tableName: "Localizable",
                                 bundle: Bundle.localizedBundle(),
                                 value: self,
                                 comment: self)
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            let font = UIFont.systemFont(ofSize: 18)
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,          .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
}


public func updateUserInterface(_ block: @escaping() -> Void) {
    DispatchQueue.main.async(execute: block)
}


//MARK: Date

extension Date {
  func addDays(_ days: Int) -> Date {
    Calendar.autoupdatingCurrent.date(byAdding: .day, value: days, to: self)!
  }
}

//MARK: Dictionary

extension Dictionary {
    func percentEncoded() -> Data? {
        map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

//MARK: UserDefaults

extension UserDefaults {
    
    static let UserDefault = UserDefaults.standard
    
    private enum Keys {
        
        static let isFirstLaunch = "isFirstLaunch"
        
        static let isUserLoggedIn = "isUserLoggedIn"
        
        static let username = "username"
        
        static let userPhoneNumber = "userPhoneNumber"
        
        static let userEmail = "userEmail"
        
        static let isGuest = "isGuest"
        
        static let isArabic = "isArabic"
        
        static let staffID = "staffID"
        
        static let categoryID = "categoryid"
        
        static let serviceID = "serviceID"
    }
    
    func valueExists(forKey key: String) -> Bool {
        return object(forKey: key) != nil
    }
    
    class var isUserLoggedIn: Bool {
        
        get {
            return UserDefaults.standard.bool(forKey: Keys.isUserLoggedIn)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.isUserLoggedIn)
        }
    }
    
    class var username: String {
        
        get {
            
            return UserDefaults.standard.string(forKey: Keys.username) ?? ""
            
        }
        set {
            
            UserDefaults.standard.set(newValue, forKey: Keys.username)
        }
    }
    
    class var userPhoneNumber: String {
        
        get {
            
            return UserDefaults.standard.string(forKey: Keys.userPhoneNumber) ?? ""
            
        }
        
        set {
            
            UserDefaults.standard.set(newValue, forKey: Keys.userPhoneNumber)
        }
    }
    
    class var staffID: String {
        
        get {
            
            return UserDefaults.standard.string(forKey: Keys.staffID) ?? ""
            
        }
        
        set {
            
            UserDefaults.standard.set(newValue, forKey: Keys.staffID)
        }
    }
    
    class var userEmail: String {
        
        get {
            
            return UserDefaults.standard.string(forKey: Keys.userEmail) ?? ""
            
        }
        
        set {
            
            UserDefaults.standard.set(newValue, forKey: Keys.userEmail)
        }
    }
    
    class var isGuest: Bool {
        
        get {
            
            return UserDefaults.standard.bool(forKey: Keys.isGuest)
            
        }
        
        set {
            
            UserDefaults.standard.set(newValue, forKey: Keys.isGuest)
        }
    }
    
    class var isArabic: Bool {
        
        get {
            
            return UserDefaults.standard.bool(forKey: Keys.isArabic)
            
        }
        
        set {
            
            UserDefaults.standard.set(newValue, forKey: Keys.isArabic)
        }
    }
    
    class var serviceID: String {
        
        get {
            
            return UserDefaults.standard.string(forKey: Keys.serviceID) ?? ""
            
        }
        
        set {
            
            UserDefaults.standard.set(newValue, forKey: Keys.serviceID)
        }
    }
    
    ///For checking if the application is being launched for the first time
    class func isFirstLaunch() -> Bool {
        if !UserDefaults.standard.bool(forKey: Keys.isFirstLaunch) {
            UserDefaults.standard.set(true, forKey: Keys.isFirstLaunch)
            return true
        }
        return false
    }
    
}

//MARK: UIApplication

extension UIApplication {

}

//MARK: NSObject

extension NSObject {
    
    private func changeRootViewController(to vc: UIViewController?) {
        
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
          fatalError("could not get scene delegate ")
        }
        
        sceneDelegate.window?.rootViewController = vc
      }
}

//MARK: Bundle

enum Language: String {
    
    case ar
    case en
}

extension Bundle {
    
    private static var bundle: Bundle!

    public static func localizedBundle() -> Bundle! {
        
        if bundle == nil {
            var appLang = UserDefaults.standard.string(forKey: "app_lang") ?? "en"
            if Bundle.main.path(forResource: appLang, ofType: "lproj") == nil {
                appLang = "en"
            }
            let path = Bundle.main.path(forResource: appLang, ofType: "lproj")
            bundle = Bundle(path: path!)
        }

        return bundle;
    }

    static func setLanguage(lang: Language) {
        
        UserDefaults.standard.set(lang.rawValue, forKey: "app_lang")
        let path = Bundle.main.path(forResource: lang.rawValue, ofType: "lproj")
        bundle = Bundle(path: path!)
        
        if lang == .ar {
            
            UserDefaults.isArabic = true
            
        } else {
            
            UserDefaults.isArabic = false
        }
        
        Global.reloadUI()
    }
    
    static func setCurrentlySelectedLanguage() {
        
        let language: Language = UserDefaults.isArabic ? .ar : .en
        
        UserDefaults.standard.set(language.rawValue, forKey: "app_lang")
        let path = Bundle.main.path(forResource: language.rawValue, ofType: "lproj")
        Bundle.bundle = Bundle(path: path ?? "")
        Global.reloadUI()
    }
}

//MARK: UIDevice

public extension UIDevice {
    
    
    
}

enum CallMethod: String {
    
    case get = "GET"
    case post = "POST"
}

extension URLSession {
    
    enum CustomError: Error {
        
        case invalidUrl
        case invalidData
    }
    
    func request<T: Codable> (
        
        url: URL?,
        expecting: T.Type,
        params: Params? = nil,
        method: CallMethod = .get,
        completion: @escaping (Result<T, Error>) -> Void) {
            
            guard let url = url else {
                completion(.failure(CustomError.invalidUrl))
                return
            }
            
            var urlRequest = URLRequest(url: url)
            
            if let params {
                
                urlRequest.httpBody = params.percentEncoded()
            }
            
            urlRequest.httpMethod = method.rawValue
            
            //urlRequest.setValue(Constants.authToken, forHTTPHeaderField: "Token")
            
            let task = dataTask(with: urlRequest) { data, _, error in
                
                guard let data = data else {
                    
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.failure(CustomError.invalidData))
                    }
                    
                    return
                }
                
                do {
                    
                    let result = try JSONDecoder().decode(expecting, from: data)
                    completion(.success(result))
                    
                } catch {
                    
                    completion(.failure(error))
                    
                }
            }
            
            task.resume()
        }
    
    
}
