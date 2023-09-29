//
//  SpaceSize.swift
//  CliX
//
//  Created by Maksim Kuznecov on 29.09.2023.
//

import Foundation

struct SpaceSize {
    /// Размер
    let size: Int64
    /// Единица измерения места
    let sizeUnit: UnitsOfMemory
    /// Полное название (размер + единица измерения)
    var fullName: String {
        return "\(self.size) \(self.sizeUnit)"
    }
    
    /// Метод конвертации в разные  формат размера
    /// - Parameter distUnit: Новый тип
    /// - Returns: Конвертированная строка
    func convertTo(_ distUnit: UnitsOfMemory) -> String {
        if distUnit == sizeUnit {
            return fullName
        }
        let dividerMultiplayer = (sizeUnit.position - distUnit.position)
        let divider = pow(1000, abs(dividerMultiplayer))
        
        if dividerMultiplayer < 0 {
            return String(format: "%.2f",  Double(size) / divider.primitivePlottable ) + " \(distUnit.rawValue)"
        } else {
            return String(format: "%.2f",  Double(size) * divider.primitivePlottable ) + " \(distUnit.rawValue)"
        }
    }
}
