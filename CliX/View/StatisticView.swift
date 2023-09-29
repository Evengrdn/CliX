//
//  StatisticView.swift
//  CliX
//
//  Created by Maksim Kuznecov on 21.09.2023.
//

import SwiftUI

struct StatisticView: View {
    /// Сумма очистки
    @AppStorage("totalCleaned") private var totalCleaned: Double = 0
    /// Дата последней очистки
    @AppStorage("lastClean") private var lastClean: Date?
    
    var body: some View {
        HStack{
            HStack{
                Text("Cleaned: ")
                Text("\(DiskManager.shared.fromByteInSpace(Int64(totalCleaned)))")
            }.padding(.all, 8)
            HStack{
                Text("Last clean: ")
                if let lastCleanDate = lastClean {
                    Text(lastCleanDate, style: .date)
                } else {
                    Text("Never")
                }
            }
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView()
    }
}
