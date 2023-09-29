//
//  DataDirectoryType.swift
//  CliX
//
//  Created by Maksim Kuznecov on 05.06.2022.
//

import Foundation

/// Стандартные директория сканирования
enum DataDirectoryType: String, CaseIterable {
    
    case iOSDeviceSupport = "iOSDevice support"
    
    case iOSDeviceLogs = "iOSDevice logs"
    
    case derivedData = "Derived data"
    
    case watchOSDeviceSupport = "watchOSDevice support"
    
    case documentationCache = "Documentation cache"
    
    case archives = "Archives"
    
    /// Путь до стандартной директории
    var path: String {
        switch self {
            case .iOSDeviceSupport:
                return "/iOS DeviceSupport/"
            case .iOSDeviceLogs:
                return "/iOS Device Logs/"
            case .derivedData:
                return "/DerivedData/"
            case .watchOSDeviceSupport:
                return "/watchOS DeviceSupport/"
            case .documentationCache:
                return "/DocumentationCache/"
            case .archives:
                return "/Archives/"
        }
    }
}
