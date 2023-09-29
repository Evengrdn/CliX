//
//  CategoryDetailSheet.swift
//  CliX
//
//  Created by Maksim Kuznecov on 29.09.2023.
//

import SwiftUI

struct CategoryDetailSheet: View {
    /// Данные сканирования
    var scanData: DirectoryForScan
    
    var body: some View {
        ZStack {
            VStack {
                HStack{
                    Text(scanData.type.rawValue)
                        .padding(.init(top: 8, leading: 16, bottom: 8, trailing: 0))
                        .font(.largeTitle)
                    Spacer()
                    Text("Total: " + scanData.info.convertTo(.gb))
                        .padding(.init(top: 8, leading: 0, bottom: 0, trailing: 16))
                }
                Table(scanData.scanedSpace) {
                    TableColumn("Search URL", value: \.scanUrl)
                    TableColumn("Size in MegaByte") { scanData in
                        Text(scanData.info.convertTo(.mb))
                    }
                }
            }.frame(width: 800, height: 300)
        }
    }
}
