//
//  WebViewBar.swift
//  Moon Laundry
//
//  Created by RCD on 12/02/2023.
//  Copyright © 2023 Parth. All rights reserved.
//

import Foundation
import UIKit

class WebViewBar: BaseView {
    
//    let mainView: UIView = {
//
//        let view = UIView()
//        view.backgroundColor = .systemGray4
//        return view
//
//    }()
    
    let doneButton: UIButton = {
        
        let button = UIButton()
        button.setTitleColor(.link, for: .normal)
        button.setTitle("Done".localized(), for: .normal)
        button.backgroundColor = .clear
        return button
        
    }()
    
    override func configure() {
        super.configure()
        
        addSubview(doneButton)
        
        backgroundColor = .systemGray6
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        doneButton.anchor(top: nil, leading: leadingAnchor, trailing: nil, bottom: nil, padding: .init(top: 0, left: width/30, bottom: 0, right: 0), size: CGSize(width: width/5, height: height/1.3))
        doneButton.centerToY()
        
    }
}
