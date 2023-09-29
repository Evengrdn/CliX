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
    
    func convertTo(_ unit: UnitsOfMemory) -> String {
        if unit == sizeUnit {
            return fullName
        }
        
        switch (sizeUnit, unit) {
        case (let selfUnit, let distinationUnit):
            let divider = Double(1000 * (abs(selfUnit.position - distinationUnit.position)))
            return String(format: "%.2f",  Double(size) / divider )
        }
    }
}
