//
//  GeneralPageViewModel.swift
//  CliX
//
//  Created by Maksim Kuznecov on 05.06.2022.
//

import Foundation
import DiagramKit
import SwiftUI

@MainActor
class GeneralPageViewModel: ObservableObject {
    
    @AppStorage("totalCleaned") var totalCleaned: Double = 0
    @AppStorage("lastClean") var lastClean: Date?
    
    @Published var derivedData: [DirectoryData] = []
    @Published var isLoading = false
    @Published var isCanClean = false
    @Published var diagramPresintationData: [DiagramData] = []
    @Published var directoryScan: [DirectoryScan] = [
        .init(
            config: ScanDirectoryConfig(type: .derivedData, color: .red, presentName: "Derived data" ),
            result: []),
        .init(
            config:  ScanDirectoryConfig(type: .archives, color: .yellow, presentName: "Archives" ),
            result: []),
        .init(
            config:  ScanDirectoryConfig(type: .documentationCache, color: .mint, presentName: "Documentation cache" ),
            result: []),
        .init(
            config: ScanDirectoryConfig(type: .homeDirectory, color: .blue, presentName: "Home directory" ),
            result: []),
        .init(
            config: ScanDirectoryConfig(type: .iOSDeviceLogs, color: .green, presentName: "iOSDevice logs" ),
            result: []),
        .init(
            config: ScanDirectoryConfig(type: .iOSDeviceSupport, color: .brown, presentName: "iOSDevice support" ),
            result: []),
        .init(
            config: ScanDirectoryConfig(type: .watchOSDeviceSupport, color: .orange, presentName: "watchOSDevice support" ),
            result: []),
    ]
    
    
    private func cleanDiagramm() {
        diagramPresintationData.removeAll()
    }
    
    private func scan() {
        let directoryManager = DirectoryManager()
        let diskManager = DiskManager()
        
        self.directoryScan.forEach{ scanDirectory in
            let fullPath = directoryManager.getFullPath(directoryType: scanDirectory.config.type)
            let subDirectories = directoryManager.getSubDirectoriesForPath(fullPath)

            let scanDirectoryData = subDirectories.map{ directory -> DirectoryData in
                let size = directoryManager.getSize(path: directory, completion: nil)
                let diplayableDir = directory.split(separator: "/").last
                return DirectoryData(name: String(diplayableDir ?? ""), sizeAtDisk: diskManager.convertFromBytes(size), sizeAtDiskInByte: size)
            }
            
            if !scanDirectoryData.isEmpty {
                isCanClean = true
            }
            
            scanDirectory.result = scanDirectoryData


            let summ: Int64 = scanDirectoryData.reduce(0, { result, model in
                return result + model.sizeAtDiskInByte
            })
            
            if summ > 500000 {
                self.diagramPresintationData.append(DiagramData(value: Double(summ), title: scanDirectory.config.presentName ?? "Name not configured", color: scanDirectory.config.color, format: { diskManager.fromByteInSpace(Int64($0)) }))
            }
        }
    }
    
    private func clean() {
        let directoryManager = DirectoryManager()
        
        self.directoryScan.forEach{ scanDirectory in
            let fullPath = directoryManager.getFullPath(directoryType: scanDirectory.config.type)
            directoryManager.clean(path: fullPath)
            
            let summ: Int64 = scanDirectory.result.reduce(0, { result, model in
                return result + model.sizeAtDiskInByte
            })
            
            scanDirectory.result.removeAll()
            totalCleaned += Double(summ)
        }
        lastClean = .now
        isCanClean = false
    }
    
    
    func startScan() -> Void {
        isLoading.toggle()
        cleanDiagramm()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.scan()
            self.isLoading.toggle()
        }        
    }
    
    func startClean() -> Void {
        isLoading.toggle()
        cleanDiagramm()
        lastClean = .now
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.clean()
            self.isLoading.toggle()
        }
    }
}

extension Date: RawRepresentable {
    private static let formatter = ISO8601DateFormatter()
    
    public var rawValue: String {
        Date.formatter.string(from: self)
    }
    
    public init?(rawValue: String) {
        self = Date.formatter.date(from: rawValue) ?? Date()
    }
}
