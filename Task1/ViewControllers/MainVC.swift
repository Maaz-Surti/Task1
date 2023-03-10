//
//  ViewController.swift
//  Task1
//
//  Created by RCD on 08/03/2023.
//

import UIKit

class MainVC: BaseViewController {

    lazy var navBar: NavigationBar = {
        
        let b = NavigationBar(showBackButton: false)
        b.changeLanguageButton.addTarget(self, action: #selector(changeLanguage), for: .touchUpInside)
        return b
        
    }()
    
    var parentData: Parent?
    
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
        
        setupUnsafeArea()
        
        view.addSubview(navBar)
        view.addSubview(cv)
        
        Task {
         
           showLoadingView()
           await getData()
           hideLoadingView()
            
        }
        
    }
    
    func getData() async {
        
        let urlObject = URL(string: "https://4saleq8.com/Api/ParentCatgories")
        
        do {
            
            parentData = try await network.request(type: Parent.self, with: urlObject)
            
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
    

    @objc func changeLanguage() {
        
        UserDefaults.isArabic  = !UserDefaults.isArabic
        
        UserDefaults.isArabic ? Bundle.setLanguage(lang: .ar) : Bundle.setLanguage(lang: .en)
        
        Global.setRootVC(with: MainVC())
    }
    
    func setupUnsafeArea() {
        
        let statusBar1 =  UIView()
        statusBar1.frame = UIApplication.shared.keyWindow?.windowScene?.statusBarManager!.statusBarFrame as? CGRect ?? CGRect(x: 0, y: 0, width: 0, height: 0)
        statusBar1.backgroundColor = Color.primary
        UIApplication.shared.keyWindow?.addSubview(statusBar1)
    }
}

extension MainVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let parentData = parentData else {
            return 0
        }
        
        return parentData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCell.identifier, for: indexPath) as! MainCell
        
        if let parentData {
            
            cell.configure(with: parentData[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let parentData = parentData else { return }
        
        let productID: String = String(parentData[indexPath.row].productCategoryID ?? 0)
        
        let vc = CategoryVC(categoryID: productID, title: UserDefaults.isArabic ? parentData[indexPath.row].nameAr ?? "" : parentData[indexPath.row].nameEn ?? "")
        
        navigationController?.pushViewController(vc, animated: true)
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

