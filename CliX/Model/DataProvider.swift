//
//  DataProvider.swift
//  CliX
//
//  Created by Maksim Kuznecov on 05.06.2022.
//

import Foundation
import SwiftUI

struct DataProvider {
    var data: State<[DirectoryData]>
    let type: DataDirectoryType
    let name: String
    var presentationColor: Color
}
