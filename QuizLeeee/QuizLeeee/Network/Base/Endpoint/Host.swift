//
//  Host.swift
//  QuizLeeee
//
//  Created by Barış Şaraldı on 27.12.2023.
//

import Foundation

// MARK: - Host
 enum Host {
    case defaultHost
    
    var url: String {
        switch self {
        case .defaultHost:
            return "demo3633203.mockable.io"
        }
    }
}
