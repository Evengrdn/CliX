//
//  DataDirectoryType.swift
//  CliX
//
//  Created by Maksim Kuznecov on 05.06.2022.
//

import Foundation

enum DataDirectoryType {
    
    case homeDirectory
    
    case xcodeDefaultPath
    
    case iOSDeviceSupport
    
    case macOSDeviceSupport
    
    case iOSDeviceLogs
    
    case derivedData
    
    case watchOSDeviceSupport
    
    case documentationCache
    
    case archives
    
    var path: String {
        switch self {
            case .homeDirectory:
                return "/Library/Containers/"
            case .iOSDeviceSupport:
                return "/iOS DeviceSupport/"
            case .macOSDeviceSupport:
                return "/macOS DeviceSupport/"
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
            case .xcodeDefaultPath:
                return "/Library/Developer/Xcode"
        }
    }
}
