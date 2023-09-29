//
//  DiskManager.swift
//  CliX
//
//  Created by Maksim Kuznecov on 02.05.2022.
//

import Foundation

struct DiskManager {
    
    /// Синглтон
    static var shared = DiskManager()
    
    ///  Перевод из байтов в читабельный вариант
    /// - Parameter byte: Сумма байтов
    /// - Returns: Читабельный формат
    func fromByteInSpace(_ byte: Int64) -> String {
        ByteCountFormatter.string(fromByteCount: byte, countStyle: .file)
    }
    
    /// Читабельный формат размера свободного места
    /// - Returns: Размер
    func freeDiskSpace() -> String {
        ByteCountFormatter.string(fromByteCount: freeDiskSpaceInBytes, countStyle: .decimal)
    }
    
    /// Читабельный формат размера диска
    /// - Returns: Размер
    func totalDiskSpace()-> String{
        ByteCountFormatter.string(fromByteCount: totalDiskSpaceInBytes, countStyle: .decimal)
    }
    
    /// Читабельный формат занятого места
    /// - Returns: Размер
    func usedDiskSpace() -> String {
        ByteCountFormatter.string(fromByteCount: usedDiskSpaceInBytes, countStyle: .decimal)
    }
    
}

extension DiskManager {
    /// Пустое место на диске
    var freeDiskSpaceInBytes:Int64 {
        get {
            do {
                let fileURL = URL(fileURLWithPath: NSHomeDirectory() as String)
                let values = try fileURL.resourceValues(forKeys: [.volumeAvailableCapacityForImportantUsageKey])
                
                if let capacity = values.volumeAvailableCapacityForImportantUsage {
                    return capacity
                } else {
                    return 0
                }
            } catch {
                return 0
            }
        }
    }
    /// Общий размер диска
    var totalDiskSpaceInBytes:Int64 {
        get {
            do {
                let systemAttributes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String)
                let space = (systemAttributes[FileAttributeKey.systemSize] as? NSNumber)?.int64Value
                return space!
            } catch {
                return 0
            }
        }
    }
    /// Занятое место
    var usedDiskSpaceInBytes:Int64 {
        get {
            let usedSpace = totalDiskSpaceInBytes - freeDiskSpaceInBytes
            return usedSpace
        }
    }
}
