//
//  ScanedSpace.swift
//  CliX
//
//  Created by Maksim Kuznecov on 29.09.2023.
//

import Foundation

/// Структура просканированного места
struct ScanedSpace: Identifiable {
    /// Идентификатор
    let id: UUID = UUID()
    /// Место поиска
    let scanUrl: String
    /// Информация сканирования
    let info: SpaceSize
}
