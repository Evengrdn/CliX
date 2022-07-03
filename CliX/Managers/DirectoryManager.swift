//
//  DirectoryManager.swift
//  CliX
//
//  Created by Maksim Kuznecov on 17.04.2022.
//

import Cocoa

struct DirectoryManager {
    
    static var shared = DirectoryManager()
    
    private let fileManager = FileManager.default
    
    var homeDirectory: String {
        var homeDirectory = NSHomeDirectory()
        let prefix = DataDirectoryType.homeDirectory.path
        
        if homeDirectory.contains(prefix) {
            if let range = homeDirectory.range(of: prefix) {
                homeDirectory = String(homeDirectory[..<range.lowerBound])
            }
        }
        
        return homeDirectory
    }
    
    var xcodeDefaultPath: String {
        return "\(homeDirectory + DataDirectoryType.xcodeDefaultPath.path)"
    }
    
    func getFullPath(directoryType: DataDirectoryType) -> String {
        return "\(xcodeDefaultPath + directoryType.path)"
    }
    
    func getDestinationType(path: String) -> DestinationType? {
        let fileManager = FileManager.default
        var isDirectory: ObjCBool = false
        
        if fileManager.fileExists(atPath: path, isDirectory: &isDirectory) {
            if isDirectory.boolValue {
                return .directory
            } else {
                return .file
            }
        }
        
        return nil
    }
    
    func normalizePathFor(directory: String) -> String {
        var path = directory
        
        if !path.hasSuffix("/") {
            path += "/"
        }
        
        return path
    }
    
    func normalizePathFor(file: String) -> String {
        var path = file
        
        if path.hasSuffix("/") {
            path.removeLast()
        }
        
        return path
    }
    
    func getSubDirectoriesForPath(_ path: String) -> [String] {
        let fileManager = FileManager.default
        
        var subDirectories: [String] = []
        do {
            subDirectories = try fileManager.contentsOfDirectory(atPath:path).map{ directory in
                return path + directory
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
        return subDirectories
    }
    
    
    func getSize(path: String, completion: (() -> Void)?) -> Int64 {
        var directorySize: Int64 = 0
        var normalizedPath: String
        let destinationType = getDestinationType(path: path)
        
        switch destinationType {
            case .directory:
                normalizedPath = normalizePathFor(directory: path)
            case .file:
                normalizedPath = normalizePathFor(file: path)
            case .none:
                return 0
        }
        
        if destinationType == .file {
            do {
                let attributes = try fileManager.attributesOfItem(atPath: normalizedPath)
                directorySize += attributes[FileAttributeKey.size] as! Int64
            } catch {
                print(error.localizedDescription)
            }
        } else {
            
            let fileManagers = FileManager.default
            let directories = fileManagers.subpaths(atPath: normalizedPath)
            
            for directory in directories! {
                do {
                    let newPath = normalizedPath + directory
                    let attributes = try fileManager.attributesOfItem(atPath: newPath)
                    directorySize += attributes[FileAttributeKey.size] as! Int64
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        guard let completion = completion else { return directorySize }
        completion()
        
        return directorySize
    }
    
    func clean(path: String) {
        do {
            try fileManager.removeItem(atPath: path)
        } catch {
            print("Clean error")
        }
        
    }
    
    func clean(type: DataDirectoryType) {
        let fullPath = getFullPath(directoryType: type)
        clean(path: fullPath)
    }
    
}
