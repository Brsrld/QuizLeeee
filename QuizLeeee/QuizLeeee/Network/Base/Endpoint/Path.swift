//
//  Path.swift
//  QuizLeeee
//
//  Created by Barış Şaraldı on 27.12.2023.
//

import Foundation

// MARK: - Path
enum Path: String {
    
    case defaultPath
    
    var path: String {
        switch self {
        case .defaultPath:
            return "/hbquiz"
        }
    }
}
