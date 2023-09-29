//
//  CategoryListView.swift
//  CliX
//
//  Created by Maksim Kuznecov on 09.04.2022.
//

import SwiftUI
import UniformTypeIdentifiers
import SkeletonUI

struct CategoryView: View {
    /// Данные сканирования
    let scanData: DirectoryForScan
    /// Флаг загрузки, для показа скелетона
    let isLoad: Bool
    
    var body: some View {
        HStack{
            Text(scanData.type.rawValue).font(.title)
            Spacer()
            HStack{
                Text(scanData.info.convertTo(.gb)).font(.title2)
                    .padding(.all, 4)
                
            }
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
        }
        .contentShape(Rectangle())
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .contextMenu {
            Button("Copy " + scanData.type.rawValue + " path") {
                NSPasteboard.general.clearContents()
                let fullPath = DirectoryManager.shared.getFullPath(directoryType: scanData.type)
                NSPasteboard.general.setString(fullPath, forType: .string)
            }
            Button("Open " + scanData.type.rawValue + " in Finder") {
                let fullPath = DirectoryManager.shared.getFullPath(directoryType: scanData.type)
                NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: fullPath)
            }
        }
        .skeleton(with: isLoad,shape: .rounded(.radius(8, style: .continuous)), spacing: 0)
        
    }
}

struct CategoryView_Previews: PreviewProvider {
    
    static var previews: some View {
        CategoryView(scanData: .init(type: .derivedData, scanedSpace: [], info: .init(size: 0, sizeUnit: .mb)), isLoad: false)
    }
}
