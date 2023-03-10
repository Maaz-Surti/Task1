//
//  Fonts Enum.swift
//  Reflex
//
//  Created by Maaz on 21/08/22.
//

import Foundation
import UIKit

extension UIFont {

    public enum CustomType: String {
        
        case regular = "-Regular"
        case light = "-Light"
        case extraBold = "-Extrabold"
        case bold = "-Bold"
    }

    static func CustomFont(_ type: CustomType = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        
        guard let almarai = UIFont(name: "Almarai\(type.rawValue)", size: size + 1.0),
                      let poppins = UIFont(name: "Poppins\(type.rawValue)", size: size) else {
                    return .systemFont(ofSize: size)
                }

                let poppinsFontWithCustomAlmaraiFallback = poppins.fontDescriptor.addingAttributes(
                    [.cascadeList: [almarai.fontDescriptor]]
                )

                return UIFont(descriptor: poppinsFontWithCustomAlmaraiFallback, size: size)
    }
    
    static func arabicFont(size: CGFloat = UIFont.systemFontSize) -> UIFont {
        
        return UIFont(name: "GEDinarOne-Medium", size: size) ?? .systemFont(ofSize: 32)
    }
    
    static func englishFont(size: CGFloat = UIFont.systemFontSize) -> UIFont {
        
        return UIFont(name: "Montserrat-Regular", size: size) ?? .systemFont(ofSize: 32)
    }
    
    static func customFont(size: CGFloat = UIFont.systemFontSize) -> UIFont{
        
        if UserDefaults.isArabic {
            
            return UIFont(name: "GEDinarOne-Medium", size: size) ?? .systemFont(ofSize: 32)
            
        } else {
            
            return UIFont(name: "Montserrat-Regular", size: size) ?? .systemFont(ofSize: 50)
        }
        
    }
    
    public enum FontSize: CGFloat {
        
        case footnote
        
        public var rawValue: CGFloat {
            
            switch self {
                
            case .footnote: return UIScreen.main.bounds.size.width * 0.03
                
            }
        }
    }
    
    //For the next project
    
//    static func CustomFont(_ type: CustomType = .regular, size: FontSize) -> UIFont {
//
//        if UserDefaults.isArabic {
//
//            return UIFont(name: "Almarai\(type.rawValue)", size: size.rawValue)!
//
//        } else {
//
//            return UIFont(name: "Poppins\(type.rawValue)", size: size.rawValue)!
//
//        }
//    }
//
//    public enum FontSize: CGFloat {
//
//        case footnote
//
//        public var rawValue: CGFloat {
//
//            switch self {
//
//            case .footnote: return UIScreen.main.bounds.size.width * 0.08
//
//            }
//        }
//    }

}
