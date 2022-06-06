//
//  DiskManager.swift
//  CliX
//
//  Created by Maksim Kuznecov on 02.05.2022.
//

import Foundation

struct DiskManager {
    
    static var shared = DiskManager()
    
    func fromByteInSpace(_ byte: Int64) -> String {
        ByteCountFormatter.string(fromByteCount: byte, countStyle: .decimal)
    }
    
    func freeDiskSpace() -> String {
        ByteCountFormatter.string(fromByteCount: freeDiskSpaceInBytes, countStyle: .decimal)
    }
    
    func totalDiskSpace()-> String{
        ByteCountFormatter.string(fromByteCount: totalDiskSpaceInBytes, countStyle: .decimal)
    }
    
    func usedDiskSpace() -> String {
        ByteCountFormatter.string(fromByteCount: usedDiskSpaceInBytes, countStyle: .decimal)
    }
    
    func convertFromBytes(_ bytes: Int64) -> String {
        ByteCountFormatter.string(fromByteCount: bytes, countStyle: .decimal)
    }
    
    func calculateDiskSpace() -> [DirectoryData] {
        [
            DirectoryData(name: "Free", sizeAtDisk: freeDiskSpace()),
            DirectoryData(name: "Used", sizeAtDisk: usedDiskSpace())
        ]
    }
    
}

extension DiskManager {
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
    
    var usedDiskSpaceInBytes:Int64 {
        get {
            let usedSpace = totalDiskSpaceInBytes - freeDiskSpaceInBytes
            return usedSpace
        }
    }
}
