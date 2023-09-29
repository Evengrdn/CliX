//
//  DirectoryManager.swift
//  CliX
//
//  Created by Maksim Kuznecov on 17.04.2022.
//

import Cocoa

struct DirectoryManager {
    /// Синглтон
    static var shared = DirectoryManager()
    ///  Путь к домашней директории
    private let homeDirectoryPath = "/Library/Containers/"
    /// Файл менеджер
    private let fileManager = FileManager.default
    /// Вычисление домашней директории
    var homeDirectory: String {
        var homeDirectory = NSHomeDirectory()
        
        if homeDirectory.contains(homeDirectoryPath) {
            if let range = homeDirectory.range(of: homeDirectoryPath) {
                homeDirectory = String(homeDirectory[..<range.lowerBound])
            }
        }
        
        return homeDirectory
    }
    /// Стандратный путь икскод
    var xcodeDefaultPath: String {
        return "\(homeDirectory + "/Library/Developer/Xcode")"
    }
    
    /// Сборка полного пути
    /// - Parameter directoryType: Тип директории
    /// - Returns: Полный путь до директории
    func getFullPath(directoryType: DataDirectoryType) -> String {
        return "\(xcodeDefaultPath + directoryType.path)"
    }
    
    /// Получение типа структуры из пути
    /// - Parameter path: Путь
    /// - Returns: Тип структуры
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
    
    /// Нормализация пути до директории
    /// - Parameter directory: Директория
    /// - Returns: Нормализованный путь
    func normalizePathFor(directory: String) -> String {
        var path = directory
        
        if !path.hasSuffix("/") {
            path += "/"
        }
        
        return path
    }
    
    /// Нормализация пути до файла
    /// - Parameter file: Файл
    /// - Returns: Нормализованный путь
    func normalizePathFor(file: String) -> String {
        var path = file
        
        if path.hasSuffix("/") {
            path.removeLast()
        }
        
        return path
    }
    
    /// Получение вложенных директорий
    /// - Parameter path: Путь
    /// - Returns: Вложенные директории
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
    
    
    /// Расчет размера
    /// - Parameters:
    ///   - path: Путь расчета
    ///   - completion: Замыкание в возвратом значения
    /// - Returns: Сумма
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
        
        autoreleasepool {
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
        }
        guard let completion = completion else { return directorySize }
        completion()
        
        return directorySize
    }
    
    /// Очистка по пути
    /// - Parameter path: Путь
    func clean(path: String) {
        do {
            try fileManager.removeItem(atPath: path)
        } catch {
            print("Clean error")
        }
        
    }
    
    /// Очистка по типу директории
    /// - Parameter type: Тип директории
    func clean(type: DataDirectoryType) {
        let fullPath = getFullPath(directoryType: type)
        clean(path: fullPath)
    }
    
}
