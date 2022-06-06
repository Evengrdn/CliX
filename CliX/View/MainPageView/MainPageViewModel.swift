//
//  MainPageViewModel.swift
//  CliX
//
//  Created by Maksim Kuznecov on 05.06.2022.
//

import Foundation
import SwiftUI
import DiagramKit

class MainPageViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var diagramPresintationData: [DiagramData] = []
    
//    func dirInformation() -> Void {
//        
//        dataArray.removeAll()
//        
//        dataProviders.forEach{ provider in
//            
//            let path = directoryManager.getFullPath(directoryType: provider.type)
//            let subDir = directoryManager.getSubDirectoriesForPath(path)
//            
//            let category = subDir.map{ dir -> DiskData in
//                
//                let size = directoryManager.getSize(path: dir, completion: nil)
//                let diplayableDir = dir.split(separator: "/").last
//                
//                
//                
//                return DiskData(name: String(diplayableDir ?? ""), sizeAtDisk: diskManager.convertFromBytes(size), sizeAtDiskInByte: size)
//            }
//            
//            provider.data.wrappedValue = category
//            
//            
//            
//            let summ: Int64 = provider.data.wrappedValue.reduce(0, { result, model in
//                return result + model.sizeAtDiskInByte
//            })
//            
//            
//            if summ > 500000 {
//                dataArray.append(DiagramData(value: Double(summ), title: provider.name, color: provider.presentationColor, format: { DiskManager.fromByteInSpace(Int64($0)) }))
//            }
//        }
//        
////        await toggleLoadingScreen()
//        
//        return;
//        
//    }
    
    
}
