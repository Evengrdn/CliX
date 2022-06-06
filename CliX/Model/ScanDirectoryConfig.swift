//
//  ScanDirectoryConfig.swift
//  CliX
//
//  Created by Maksim Kuznecov on 05.06.2022.
//

import Foundation
import SwiftUI

struct ScanDirectoryConfig: Identifiable {
    let id = UUID()
    var type: DataDirectoryType
    var color: Color
    var presentName: String?
}
    
    
