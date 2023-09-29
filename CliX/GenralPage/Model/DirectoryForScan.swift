//
//  DirectoryForScan.swift
//  CliX
//
//  Created by Maksim Kuznecov on 29.09.2023.
//

import Foundation

struct DirectoryForScan: Identifiable {
    let id: UUID = UUID()
    let type: DataDirectoryType
    let scanedSpace: [ScanedSpace]
    let info: SpaceSize
}
