//
//  MainCell.swift
//  Task1
//
//  Created by RCD on 08/03/2023.
//

import Foundation
import UIKit
import SDWebImage

class MainCell: BaseCollectionViewCell {
    
    static let identifier = "MainCell"
    
    let imageView: UIImageView = {
        
        let i = UIImageView()
        i.contentMode = .scaleAspectFit
        //i.backgroundColor = .red
        i.clipsToBounds = true
        return i
    }()
    
    let label: UILabel = {
        
        let label = UILabel()
        label.textColor = .black
        label.text = "Long text"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.init(999), for: .vertical)
        label.font = .customFont(size: 22)
        
        return label
        
    }()
    
    override func configure() {
        super.configure()
        
        addSubview(imageView)
        addSubview(label)
        
    }
    
    func configure(with model: ParentElement) {
        
        let url = URL(string: model.picture ?? "")
        
        imageView.sd_imageTransition = .fade
        
        imageView.sd_setImage(with: url, placeholderImage: Image.placeholderImage)
        
        label.text = UserDefaults.isArabic ? model.nameAr : model.nameEn
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        imageView.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: nil)
        label.anchor(top: imageView.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, padding: .init(top: 4, left: 8, bottom: 8, right: 0))
    }
}
