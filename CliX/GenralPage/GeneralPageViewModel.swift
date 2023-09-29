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
    
    @AppStorage("totalCleaned") private var totalCleaned: Double = 0
    @AppStorage("lastClean") private var lastClean: Date?
    
    /// Флаг загрузки
    @Published var isLoading = false
    /// Флаг активности кнопки "Clean"
    @Published var isCanClean = false
    /// Массивы данных сканирования
    @Published var scaneFolders: [DirectoryForScan] = [
        .init(type: .derivedData, scanedSpace: [], info: .init(size: 0, sizeUnit: .mb)),
        .init(type: .documentationCache, scanedSpace: [], info: .init(size: 0, sizeUnit: .mb)),
        .init(type: .archives, scanedSpace: [], info: .init(size: 0, sizeUnit: .mb)),
        .init(type: .iOSDeviceLogs, scanedSpace: [], info: .init(size: 0, sizeUnit: .mb)),
        .init(type: .iOSDeviceSupport, scanedSpace: [], info: .init(size: 0, sizeUnit: .mb)),
        .init(type: .watchOSDeviceSupport, scanedSpace: [], info: .init(size: 0, sizeUnit: .mb)),
    ]
    
    /// Запуск сканирования
    func startScan() async {
        await MainActor.run(body: {
            isLoading.toggle()
        })
        
        async let watchOSDeviceSupportDirectory = scan(directory: .watchOSDeviceSupport)
        async let derivedDataDirectory = scan(directory: .derivedData)
        async let iOSDeviceLogsDirectory = scan(directory: .iOSDeviceLogs)
        async let iOSDeviceSupportDirectory = scan(directory: .iOSDeviceSupport)
        async let archivesDirectory = scan(directory: .archives)
        async let documentationCacheDirectory = scan(directory: .documentationCache)
        
        let directorys = await [
            watchOSDeviceSupportDirectory,
            derivedDataDirectory,
            iOSDeviceLogsDirectory,
            iOSDeviceSupportDirectory,
            archivesDirectory,
            documentationCacheDirectory
        ]
            .compactMap { $0 }
            .sorted { $0.info.size > $1.info.size}
        
        await MainActor.run(body: {
            
            if directorys.isEmpty {
                self.scaneFolders = setMokData()
            } else {
                self.scaneFolders = directorys
            }
            
           
            isLoading.toggle()
            isCanClean.toggle()
        })
    }
    
    /// Запуск очистки
    func startClean() async {
        await MainActor.run(body: {
            isLoading.toggle()
            isCanClean.toggle()
        })
        await self.clean()
        await MainActor.run(body: {
            scaneFolders = setMokData()
            isLoading.toggle()
            isCanClean.toggle()
            lastClean = .now
        })
    }
    
    
    
    /// Сканирование
    /// - Parameter directory: Директория
    /// - Returns: Данные скнирования
    private func scan(directory: DataDirectoryType) async -> DirectoryForScan?   {
        let directoryManager = DirectoryManager()
        let fullPath = directoryManager.getFullPath(directoryType: directory)
        let subDirectories = directoryManager.getSubDirectoriesForPath(fullPath)
        
        let scanDirectoryData = subDirectories.map{ directory in
            autoreleasepool {
                let size = directoryManager.getSize(path: directory, completion: nil)
                return ScanedSpace(scanUrl: directory, info: .init(size: size, sizeUnit: .by))
            }
        }
        
        let summ: Int64 = scanDirectoryData.reduce(0, { result, model in
            return result + model.info.size
        })
        
        if summ > 500000 {
            let normalizeSumm = summ / 1000 / 1000
            print(normalizeSumm)
            return .init(type: directory,
                         scanedSpace: scanDirectoryData,
                         info: .init(size: normalizeSumm, sizeUnit: .mb))
            
        }
        return nil
    }
    
    /// Очитска
    private func clean() async {
        let directoryManager = DirectoryManager()
        for scanDirectory in scaneFolders {
            let fullPath = directoryManager.getFullPath(directoryType: scanDirectory.type)
            directoryManager.clean(path: fullPath)
            await MainActor.run(body: {
                totalCleaned += Double(scanDirectory.info.size * 1000 * 1000)
            })
        }
    }
    
    /// Данные для заглушки
    /// - Returns: Данные сканирования
    private func setMokData() -> [DirectoryForScan] {
        [
            .init(type: .derivedData, scanedSpace: [], info: .init(size: 0, sizeUnit: .mb)),
            .init(type: .documentationCache, scanedSpace: [], info: .init(size: 0, sizeUnit: .mb)),
            .init(type: .archives, scanedSpace: [], info: .init(size: 0, sizeUnit: .mb)),
            .init(type: .iOSDeviceLogs, scanedSpace: [], info: .init(size: 0, sizeUnit: .mb)),
            .init(type: .iOSDeviceSupport, scanedSpace: [], info: .init(size: 0, sizeUnit: .mb)),
            .init(type: .watchOSDeviceSupport, scanedSpace: [], info: .init(size: 0, sizeUnit: .mb)),
        ]
    }
}
