//
//  GraphDataView.swift
//  CliX
//
//  Created by Maksim Kuznecov on 12.04.2022.
//

import SwiftUI
import SwiftUICharts

struct GraphDataView: View {
    
    let data : DoughnutChartData = exampleData()
    
    @Binding var testData: DoughnutChartData
    
    static func exampleData() -> DoughnutChartData {
        DoughnutChartData(
            dataSets: PieDataSet(
                dataPoints: [
                    PieChartDataPoint(value: 98.99, description: "Free", colour: .green, label: .label(text: "98.99", colour: .green, font: .title, rFactor: 0.6)),
//                    PieChartDataPoint(value: 245.11, description: "Всего", colour: .gray, label: .label(text: "Всего", colour: .gray, font: .title)),
                    PieChartDataPoint(value: 146.16, description: "Used", colour: .red, label: .label(text: "146.16", colour: .red, font: .title, rFactor: 0.6)),
//                    PieChartDataPoint(value: 60, description: "Chapter four", colour: .green, label: .none)
                ],
                legendTitle: "Pid"),
            metadata: ChartMetadata(title: "Pie", subtitle: "mmm pie"),
            chartStyle: DoughnutChartStyle(),
            noDataText: Text("No data"))
    }
    
    var body: some View {
        
        VStack{
            HStack{
                DoughnutChart(chartData: testData)
                    .headerBox(chartData: testData)
                    .legends(chartData: testData, columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())])
                    .id(testData.id)
                    .padding()
                    .background(.thickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(radius: 3)
            }
            
        }.frame(minWidth: 500, maxWidth: .infinity, minHeight: 600, alignment: .top)
        
        
        
    }
    
}

struct GraphDataView_Previews: PreviewProvider {
    static var previews: some View {
        GraphDataView(testData: WrapView(data: GraphDataView.exampleData()).$data)
    }
}
