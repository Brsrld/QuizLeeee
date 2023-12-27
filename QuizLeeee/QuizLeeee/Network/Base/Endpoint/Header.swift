//
//  Header.swift
//  QuizLeeee
//
//  Created by Barış Şaraldı on 27.12.2023.
//

import Foundation

// MARK: - Header
enum Header {
    case defaultHeader
    
    var header: [String : String]? {
        switch self {
        case .defaultHeader:
            return nil
        }
    }
}
