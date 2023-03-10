//
//  CategoryVC.swift
//  Task1
//
//  Created by Maaz on 10/03/23.
//

import Foundation
import UIKit

class CategoryVC: BaseViewController {
    
    lazy var navBar: NavigationBar = {
        
        let b = NavigationBar(showBackButton: true, title: "title")
        return b
        
    }()
    
    var categoryData: Category?
    
    let network = Network()
    
    lazy var cv: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        cv.isPagingEnabled = true
        cv.register(MainCell.self, forCellWithReuseIdentifier: MainCell.identifier)
        cv.automaticallyAdjustsScrollIndicatorInsets = false
        
        cv.dataSource = self
        cv.delegate = self
        
        return cv
        
    }()

    override func configure() {
        super.configure()
        
        view.addSubview(navBar)
        view.addSubview(cv)
        
        
    }
    
    init(categoryID: String, title: String) {
        super.init(nibName: nil, bundle: nil)
        
        Task {
            
            showLoadingView()
           await getCategoryData(categoryID: categoryID)
            hideLoadingView()
            
        }
        
        navBar = NavigationBar(showBackButton: true, title: title)
        navBar.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getCategoryData(categoryID: String) async {
        
        let url = "https://4saleq8.com/Api/SubCategories?categoryId=\(categoryID)"
        
        let urlObject = URL(string: url)
        
        do {
            
            categoryData = try await network.request(type: Category.self, with: urlObject)
            
            cv.reloadData()
            
        } catch {
            
            print(error)
            
        }
        
//        URLSession.shared.request(url: urlObject, expecting: Parent.self) { [weak self] result in
//            switch result {
//
//            case .success(let data):
//                self?.parentData = data
//
//                DispatchQueue.main.async {
//
//                    self?.cv.reloadData()
//                }
//
//            case .failure(let error):
//                print(error)
//            }
//
//        }
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        navBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, size: CGSize(width: view.width, height: view.width/8))
        
        cv.anchor(top: navBar.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8))
    }
    
    @objc func backButtonPressed() {
        
        navigationController?.popViewController(animated: true)
    }

}

extension CategoryVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let categoryData = categoryData else {
            return 0
        }
        
        return categoryData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCell.identifier, for: indexPath) as! MainCell
        
        if let categoryData {
            
            cell.label.text = UserDefaults.isArabic ? categoryData[indexPath.row].nameAr : categoryData[indexPath.row].nameEn
            
            cell.imageView.sd_imageTransition = .fade
            
            cell.imageView.sd_setImage(with: URL(string: categoryData[indexPath.row].picture ?? ""), placeholderImage: Image.placeholderImage)
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let categoryData = categoryData else { return }
        
        let productID: String = String(categoryData[indexPath.row].productCategoryID ?? 0)
        
        
        
        if categoryData[indexPath.row].isLastChild ?? false {
            
            showAlert(backgroundColor: .gray, textColor: .white, message: "This is the last level of the category".localized())
            
        } else {
            
            let vc = CategoryVC(categoryID: productID, title: UserDefaults.isArabic ? categoryData[indexPath.row].nameAr ?? "" : categoryData[indexPath.row].nameEn ?? "")
            navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.width/2 - 12, height: view.width/2 - 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
