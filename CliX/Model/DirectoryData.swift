//
//  DirectoryData.swift
//  CliX
//
//  Created by Maksim Kuznecov on 05.06.2022.
//

import Foundation
import SwiftUI

struct DirectoryData: Identifiable {
    
    let id = UUID()
    
    var name: String
    
    var sizeAtDisk: String
    
    var sizeAtDiskInByte: Int64 = 0
    
    func sizeInDouble() -> Double? {
        let size = sizeAtDisk.split(separator: " ")
        return Double(size[0].replacingOccurrences(of: ",", with: "."))
    }
    
}

final class DirectoryScan: Identifiable {
    
    public init(config: ScanDirectoryConfig, result: State<[DirectoryData]>) {
        self.config = config
        self.result = result
    }
    
    let id = UUID()
    var config: ScanDirectoryConfig
    var result: State<[DirectoryData]>
}
