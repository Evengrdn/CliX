//
//  StatisticBarView.swift
//  CliX
//
//  Created by Maksim Kuznecov on 10.05.2022.
//

import SwiftUI
import DiagramKit


struct StatisticBarView: View {
    
    @Binding var diagramDataModels: [DiagramData]
    var body: some View {
        
        ZStack{
            
            if diagramDataModels.count > 0 {
                PieDiagramView(data: diagramDataModels, summValueFormatter: {DiskManager.shared.fromByteInSpace(Int64($0))})
                    .padding(.top, 10)
            } else {
                PieDiagramView(data: [
                    DiagramData(value: 1333, title: "Type A", color: .blue, format: { String(format: "$%.2f", $0) }),
                    DiagramData(value: 2666, title: "Type B", color: .green, format: { String(format: "$%.2f", $0) }),
                    DiagramData(value: 3999, title: "Type C", color: .orange, format: { String(format: "$%.2f", $0) })
                ]).blur(radius: 20).padding(.top, 10)
            }
        }
        
        
    }
}

//struct StatisticBarView_Previews: PreviewProvider {
//    static var previews: some View {
//       StatisticBarView()
//    }
//}

struct ProgressBar: View {
    
    @Binding var progress: Double
    
    var color: Color = .red
    
    var showProgressCounter = true
    
    var body: some View {
        ZStack{
            Circle()
                .stroke(lineWidth: 20)
                .opacity(0.3)
                .foregroundColor(color)
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                .foregroundColor(color)
                .rotationEffect(Angle(degrees: -90))
            
            Text(String(format: "%.0f %%", min(self.progress, 1.0)*100.0))
                .font(.largeTitle)
                .bold()
                .animation(.none)
                .opacity(showProgressCounter ? 1 : 0)
        }
    }
}
