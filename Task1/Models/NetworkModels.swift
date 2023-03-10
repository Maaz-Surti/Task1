//
//  NetworkModels.swift
//  Task1
//
//  Created by Maaz on 10/03/23.
//

import Foundation

typealias Parent = [ParentElement]

typealias Category = [CategoryElement]

struct ParentElement: Codable {
    let productCategoryID: Int?
    let nameAr, nameEn, name: String?
    let showInHomePage: Bool?
    let seoName: String?
    let picture: String?
    let descriptionAr, descriptionEn, description: String?
    let order: Int?
    let active: Bool?
    let parentID: String?
    let parentNameAr, parentNameEn, parentName: String?
    let rowNumber: Int?
    let subcategories, ads: String?
    let subProductCategoriesCount: Int?
    let disabled: Bool?
    let popupCommercialAd: String?
    let isLastChild: Bool?

    enum CodingKeys: String, CodingKey {
        case productCategoryID = "ProductCategoryId"
        case nameAr = "NameAr"
        case nameEn = "NameEn"
        case name = "Name"
        case showInHomePage = "ShowInHomePage"
        case seoName = "SeoName"
        case picture = "Picture"
        case descriptionAr = "DescriptionAr"
        case descriptionEn = "DescriptionEn"
        case description = "Description"
        case order = "Order"
        case active = "Active"
        case parentID = "ParentId"
        case parentNameAr = "ParentNameAr"
        case parentNameEn = "ParentNameEn"
        case parentName = "ParentName"
        case rowNumber = "RowNumber"
        case subcategories = "Subcategories"
        case ads = "Ads"
        case subProductCategoriesCount = "SubProductCategoriesCount"
        case disabled = "Disabled"
        case popupCommercialAd = "PopupCommercialAd"
        case isLastChild = "IsLastChild"
    }
    
}

// MARK: - CategoryElement
struct CategoryElement: Codable {
    let productCategoryID: Int?
    let nameAr, nameEn, name: String?
    let showInHomePage: Bool?
    let seoName: String?
    let picture: String?
    let descriptionAr, descriptionEn, description: String?
    let order: Int?
    let active: Bool?
    let parentID: Int?
    let parentNameAr: String?
    let parentNameEn: String?
    let parentName: String?
    let rowNumber: Int?
    let subcategories, ads: String?
    let subProductCategoriesCount: Int?
    let disabled: Bool?
    let popupCommercialAd: String?
    let isLastChild: Bool?

    enum CodingKeys: String, CodingKey {
        case productCategoryID = "ProductCategoryId"
        case nameAr = "NameAr"
        case nameEn = "NameEn"
        case name = "Name"
        case showInHomePage = "ShowInHomePage"
        case seoName = "SeoName"
        case picture = "Picture"
        case descriptionAr = "DescriptionAr"
        case descriptionEn = "DescriptionEn"
        case description = "Description"
        case order = "Order"
        case active = "Active"
        case parentID = "ParentId"
        case parentNameAr = "ParentNameAr"
        case parentNameEn = "ParentNameEn"
        case parentName = "ParentName"
        case rowNumber = "RowNumber"
        case subcategories = "Subcategories"
        case ads = "Ads"
        case subProductCategoriesCount = "SubProductCategoriesCount"
        case disabled = "Disabled"
        case popupCommercialAd = "PopupCommercialAd"
        case isLastChild = "IsLastChild"
    }
}

