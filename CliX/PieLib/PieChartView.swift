//
//  PieChartView.swift
//  CliX
//
//  Created by Maksim Kuznecov on 12.05.2022.
//

import SwiftUI

struct PieChartView: View {
    
    public let pieChartData: [PieChartData]
    public var backgroundColor: Color
    
    var innerRadiusFraction = 0.4
    
    var slicesSumm: Double {
        return pieChartData.reduce(0, { result, element in
            return result + element.value
        })
    }
    
    var slices: [PieSliceData] {
        let sum = slicesSumm
        var endDeg: Double = 0
        
        return pieChartData.map { data in
            let degrees: Double = data.value * 360 / sum
            let pieSlice = PieSliceData(startAngle: Angle(degrees: endDeg), endAngle: Angle(degrees: endDeg + degrees), color: data.color, text: String(format: "%.0f%%", data.value * 100 / sum))
            endDeg += degrees
            
            return pieSlice
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                ForEach(slices){ slice in
                    PieSliceView(pieSliceData: slice)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                
                Circle()
                    .fill(self.backgroundColor)
                    .frame(width: geometry.size.width * innerRadiusFraction, height: geometry.size.width * innerRadiusFraction)
                
                VStack {
                    Text("Total")
                        .font(.title)
                        .foregroundColor(Color.gray)
                    Text(String(slicesSumm))
                        .font(.title)
                }
            }
            .background(self.backgroundColor)
            .foregroundColor(Color.white)
        }
    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView(pieChartData: [
            PieChartData(value: 1300, color: .blue),
            PieChartData(value: 500, color: .green),
            PieChartData(value: 300, color: .orange)
        ], backgroundColor: Color(red: 21 / 255, green: 24 / 255, blue: 30 / 255, opacity: 1.0))
    }
}

struct PieChartData {
    var value: Double
    var color: Color
}
