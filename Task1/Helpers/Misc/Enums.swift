//
//  Enums.swift
//  DiamondHouse
//
//  Created by RCD on 07/12/2022.
//

import Foundation
import UIKit

enum Months: String, CaseIterable {
    
    case January = "0"
    case February = "1"
    case March = "2"
    case April = "3"
    case May = "4"
    case June = "5"
    case July = "6"
    case August = "7"
    case September = "8"
    case October = "9"
    case November = "10"
    case December = "11"
}

enum Years: String, CaseIterable {
    
    case TwentyTwenty = "2020"
    case TwentyTwentyOne = "2021"
    case TwentyTwentyTwo = "2022"
}


enum BookingStatus: Int {
    
    case Cancelled
    case Upcoming
    case InProgress
    case Completed
    
    var code: Int {
        
        switch self {
        case .Cancelled:
            return 0
        case .Upcoming:
            return 1
        case .InProgress:
            return 2
        case .Completed:
            return 3
        }
    }
    
    var stringValue: String {
        
        switch self {
        case .Cancelled:
            return "Cancelled".localized()
        case .Upcoming:
            return "Upcoming".localized()
        case .InProgress:
            return "In Progress".localized()
        case .Completed:
            return "Completed".localized()
        }
    }
    
    var color: UIColor {
        
        switch self {
        case .Cancelled:
            return UIColor.systemRed
        case .Upcoming:
            return UIColor.orange
        case .InProgress:
            return UIColor.systemYellow
        case .Completed:
            return UIColor.systemGreen
        }
    }
    
}

