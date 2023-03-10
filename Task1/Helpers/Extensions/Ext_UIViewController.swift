//
//  Ext_UIViewController.swift
//  Reflex
//
//  Created by Maaz on 24/09/22.
//

import Foundation
import UIKit

fileprivate var aView: UIView?

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showAlert(with title: String, onDismiss: (() -> Void)? = nil ) {
        
        let alert = UIAlertController(title: "Alert".localized(), message: title, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok".localized(), style: .default, handler: { _ in
            onDismiss?()
        }))
        self.present(alert, animated: true)
    }
    
    func showConfirmationAlert(with title: String, onConfirmPressed: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: "Alert".localized(), message: title, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes".localized(), style: .destructive, handler: { _ in
            onConfirmPressed?()
        }))
        alert.addAction(UIAlertAction(title: "No".localized(), style: .default))
        self.present(alert, animated: true)
        
    }
    
    func resetWindow(with vc: UIViewController) {
        
      guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
        fatalError("could not get scene delegate ")
      }
      sceneDelegate.window?.rootViewController = vc
    }
    
    func showSpinner() {
        
        let aView = UIView(frame: self.view.bounds)
        aView.backgroundColor = UIColor.black
    
        self.view.addSubview(aView)
        
        let ai = UIActivityIndicatorView(style: .large)
        ai.center = aView.center
        ai.startAnimating()
        aView.addSubview(ai)
        self.view.addSubview(aView)
    }
    
    func removeSpinner() {
        
             
    }
    
    func loopThroughSubViewAndAlignTextfieldText(subviews: [UIView]) {
        
    if subviews.count > 0 {
        
        for subView in subviews {
            if subView is UITextField && subView.tag <= 0{
                let textField = subView as! UITextField
                textField.textAlignment = UserDefaults.isArabic ? .right: .left
            } else if subView is UITextView && subView.tag <= 0{
                let textView = subView as! UITextView
                textView.textAlignment = UserDefaults.isArabic ? .right: .left

            }

            loopThroughSubViewAndAlignTextfieldText(subviews: subView.subviews)
        }
      }
    }
    
    func showToast(message : String) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: view.width/1.5, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = .customFont(size: 12)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
     }
    
    func showAlert(backgroundColor:UIColor, textColor:UIColor, message:String) {
        
        let label = UILabel(frame: CGRect.zero)
        label.textAlignment = NSTextAlignment.center
        label.text = message
        label.font = .customFont(size: 16)
        label.adjustsFontSizeToFitWidth = true
        
        label.backgroundColor =  backgroundColor //UIColor.whiteColor()
        label.textColor = textColor //TEXT COLOR
        
        label.sizeToFit()
        label.numberOfLines = 4
        label.layer.shadowColor = UIColor.gray.cgColor
        label.layer.shadowOffset = CGSize(width: 4, height: 3)
        label.layer.shadowOpacity = 0.3
        label.frame = CGRect(x: view.width , y: view.height - 80, width: view.width, height: 44)
        label.layer.cornerRadius = 22
        
        label.alpha = 1
        
       view.addSubview(label)
        
        var basketTopFrame: CGRect = label.frame;
        basketTopFrame.origin.x = 0;
        
        label.frame = basketTopFrame
        
        UIView.animate(withDuration:1, delay: 1, options: UIView.AnimationOptions.curveEaseIn, animations: { () -> Void in
            label.alpha = 0
        },  completion: {
            (value: Bool) in
            label.removeFromSuperview()
        })
    }
    
    func showInputDialog(title:String? = nil,
                             subtitle:String? = nil,
                         actionTitle:String? = "Send".localized(),
                         cancelTitle:String? = "Cancel".localized(),
                             inputPlaceholder:String? = nil,
                             inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                             cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                             actionHandler: ((_ text: String?) -> Void)? = nil) {
            
        let alert = UIAlertController(title: title?.localized(), message: subtitle?.localized(), preferredStyle: .alert)
        
            alert.addTextField { (textField:UITextField) in
                textField.placeholder = inputPlaceholder?.localized()
                textField.keyboardType = inputKeyboardType
                textField.textAlignment = UserDefaults.isArabic ? .right : .left
                textField.semanticContentAttribute = UserDefaults.isArabic ? .forceRightToLeft : .forceLeftToRight
            }
        
        alert.addAction(UIAlertAction(title: actionTitle?.localized(), style: .default, handler: { (action:UIAlertAction) in
                guard let textField =  alert.textFields?.first else {
                    actionHandler?(nil)
                    return
                }
            actionHandler?(textField.text?.localized())
            }))
        
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
            
            self.present(alert, animated: true, completion: nil)
        }
    
    private static var loadingViewAssociationKey: UInt8 = 0

        private var loadingView: UIView? {
            get {
                return objc_getAssociatedObject(self, &UIViewController.loadingViewAssociationKey) as? UIView
            }
            set(newValue) {
                objc_setAssociatedObject(self, &UIViewController.loadingViewAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }

        func showLoadingView() {
            let loadingView = UIView(frame: view.bounds)
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            loadingView.addSubview(activityIndicator)
            activityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
            activityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor).isActive = true
            activityIndicator.startAnimating()
            view.addSubview(loadingView)
            self.loadingView = loadingView
        }

        func hideLoadingView() {
            loadingView?.removeFromSuperview()
            self.loadingView = nil
        }

}

//MARK: NSObject

extension NSObject {
    
    func setRootViewController(to vc: UIViewController?) {
        
      guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
        fatalError("could not get scene delegate ")
      }
        
      sceneDelegate.window?.rootViewController = vc
        
    }
}


extension UIWindow {
    
    
    
}
