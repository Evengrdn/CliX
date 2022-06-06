//
//  GeneralPageViewModel.swift
//  CliX
//
//  Created by Maksim Kuznecov on 05.06.2022.
//

import Foundation
import DiagramKit
import SwiftUI


class GeneralPageViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var diagramPresintationData: [DiagramData] = []
    @Published var directoryScan: [DirectoryScan] = [
        DirectoryScan(
            config: ScanDirectoryConfig(type: .derivedData, color: .red, presentName: "Derived data" ),
            result: State(initialValue: [])),
        DirectoryScan(
            config:  ScanDirectoryConfig(type: .archives, color: .yellow, presentName: "Archives" ),
            result: State(initialValue: [])),
        DirectoryScan(
            config:  ScanDirectoryConfig(type: .documentationCache, color: .mint, presentName: "Documentation cache" ),
            result: State(initialValue: [])),
        DirectoryScan(
            config: ScanDirectoryConfig(type: .homeDirectory, color: .blue, presentName: "Home directory" ),
            result: State(initialValue: [])),
        DirectoryScan(
            config: ScanDirectoryConfig(type: .iOSDeviceLogs, color: .green, presentName: "iOSDevice logs" ),
            result: State(initialValue: [])),
        DirectoryScan(
            config: ScanDirectoryConfig(type: .iOSDeviceSupport, color: .brown, presentName: "iOSDevice support" ),
            result: State(initialValue: [])),
        DirectoryScan(
            config: ScanDirectoryConfig(type: .watchOSDeviceSupport, color: .orange, presentName: "watchOSDevice support" ),
            result: State(initialValue: [])),
    ]
    
    
    private func cleanDiagramm() {
        diagramPresintationData.removeAll()
    }
    
    
    func scan() -> Void {
        cleanDiagramm()
        isLoading.toggle()
        let directoryManager = DirectoryManager()
        let diskManager = DiskManager()
        
        directoryScan.forEach{ scanDirectory in
            let fullPath = directoryManager.getFullPath(directoryType: scanDirectory.config.type)
            let subDirectories = directoryManager.getSubDirectoriesForPath(fullPath)
            
            let scanDirectoryData = subDirectories.map{ directory -> DirectoryData in
                let size = directoryManager.getSize(path: directory, completion: nil)
                let diplayableDir = directory.split(separator: "/").last
                return DirectoryData(name: String(diplayableDir ?? ""), sizeAtDisk: diskManager.convertFromBytes(size), sizeAtDiskInByte: size)
            }
            
            scanDirectory.result = .init(wrappedValue: scanDirectoryData)
            
            let summ: Int64 = scanDirectoryData.reduce(0, { result, model in
                return result + model.sizeAtDiskInByte
            })
            if summ > 500000 {
                diagramPresintationData.append(DiagramData(value: Double(summ), title: scanDirectory.config.presentName ?? "Name not configured", color: scanDirectory.config.color, format: { diskManager.fromByteInSpace(Int64($0)) }))
            }
            
        }
        objectWillChange.send()
    }
}
