//
//  Global.swift
//  Reflex
//
//  Created by RCD on 11/10/2022.
//

import Foundation
import UIKit

public typealias Callback = (() -> Void)

class Global{
    
    static let shared = Global()
    
    static func reloadUI() {
        
        if !UserDefaults.isArabic {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UINavigationController().navigationBar.semanticContentAttribute = .forceLeftToRight
            if let keyWindow = UIApplication.shared.keyWindow {
                keyWindow.rootViewController?.view.semanticContentAttribute = .forceLeftToRight
                keyWindow.semanticContentAttribute = .forceLeftToRight
            }
        }
        else {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UINavigationController().navigationBar.semanticContentAttribute = .forceRightToLeft
            if let keyWindow = UIApplication.shared.keyWindow {
                keyWindow.rootViewController?.view.semanticContentAttribute = .forceRightToLeft
                keyWindow.semanticContentAttribute = .forceRightToLeft
            }
        }
    }
    
    static func setRootVC(with viewController: UIViewController) {
        
        if let window = UIApplication.shared.keyWindow {
            
            let vc = viewController
            let rootViewController = UINavigationController(rootViewController: vc)
            rootViewController.setNavigationBarHidden(true, animated: false)
            window.rootViewController = rootViewController
            window.overrideUserInterfaceStyle = .light
            window.makeKeyAndVisible()
            
            let options: UIView.AnimationOptions = .transitionCrossDissolve

            // The duration of the transition animation, measured in seconds.
            let duration: TimeInterval = 0.3

            // Creates a transition animation.
            // Though `animations` is optional, the documentation tells us that it must not be nil. ¯\_(ツ)_/¯
            UIView.transition(with: window, duration: duration, options: options, animations: {})
            
        }
    }
}


//MARK: Global properties


var formatterForAPI: DateFormatter = {
    
    let df = DateFormatter()
    df.dateFormat = "yyyy-MM-dd"
    return df
    
}()

var defaultFormatter: DateFormatter = {
    
    let df = DateFormatter()
    df.dateFormat = "MMM dd, yyyy"
    return df
    
}()

