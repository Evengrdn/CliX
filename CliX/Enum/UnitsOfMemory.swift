//
//  UnitsOfMemory.swift
//  CliX
//
//  Created by Maksim Kuznecov on 29.09.2023.
//

import Foundation

/// Возмодные размеры
enum UnitsOfMemory: String {
    case by = "byte"
    case kb = "KB"
    case mb = "MB"
    case gb = "GB"
    
    /// Позиция для правильной конвертации
    var position: Int {
        switch self {
        case .by:
            return 0
        case .kb:
            return 1
        case .mb:
            return 2
        case .gb:
            return 3
        }
    }
}
