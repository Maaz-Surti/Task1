//
//  NavigationBar.swift
//  Reflex
//
//  Created by Maaz on 28/07/22.
//

import UIKit

class NavigationBar: UIView {
    
    var showBackButton: Bool = false
    
    let logo: UIImageView = {
        
        let imageView = UIImageView()
        guard let image = UIImage(named: "logo") else { return UIImageView()}
        imageView.image = image
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var label: UILabel = {
        
        let label = UILabel()
        label.textColor = .white
        label.text = "Long text"
        label.font = .customFont(size: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.isHidden = true
        return label
        
    }()
    
    let backButton: Button = {
        
        let button = Button()
        let image = UIImage(named: "back") ?? UIImage()
        button.setImage(image, for: .normal)
        button.isHidden = true
        //button.backgroundColor = .red
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    let changeLanguageButton: Button = {
        
        let button = Button()
        button.setTitle(UserDefaults.isArabic ? "English" : "عربي", for: .normal)
        button.titleLabel?.font = UserDefaults.isArabic ? .arabicFont(size: 16) : .englishFont(size: 16)
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    
    }
    
    required init(showBackButton: Bool, title: String? = nil) {

         super.init(frame: .zero)
         
         self.showBackButton = showBackButton
         
         backgroundColor = Color.primary
         addSubview(logo)
         addSubview(label)
         addSubview(changeLanguageButton)
         addSubview(backButton)
         
        backButton.isHidden = !showBackButton
        changeLanguageButton.isHidden = showBackButton
        
        if let title, !title.isEmpty {
            
            label.text = title
            label.font = .customFont(size: 22)
            label.isHidden = false
            logo.isHidden = true
        }

         layer.shadowColor = UIColor.black.cgColor
         layer.shadowOffset = CGSize(width: 0, height: 0)
         layer.shadowOpacity = 0.2
         layer.shadowRadius = 7
        
        let image = UIImage(named: "back") ?? UIImage()
        
        backButton.setImage(UserDefaults.isArabic ? image.withHorizontallyFlippedOrientation() : image, for: .normal)
         
         clipsToBounds = false
         //backButton.superview?.bringSubviewToFront(backButton)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backButton.anchor(top: nil, leading: leadingAnchor, trailing: nil, bottom: nil, padding: .init(top: 0, left: 4, bottom: 0, right: 0))
        backButton.centerToY()
        
        logo.centerToX()
        logo.centerToY()
        logo.setWidth(width/2.5)
        logo.setHeight(height)
        
        label.centerToY()
        label.centerToX()
        
        changeLanguageButton.anchor(top: nil, leading: nil, trailing: trailingAnchor, bottom: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 16))
        changeLanguageButton.centerToY()
        changeLanguageButton.setTitle(UserDefaults.isArabic ? "English" : "عربي", for: .normal)
    }
    
    @objc func backButtonPressed() {
        
        inputViewController?.navigationController?.popViewController(animated: true)
    }
    
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
