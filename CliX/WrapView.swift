//
//  WrapView.swift
//  CliX
//
//  Created by Maksim Kuznecov on 15.04.2022.
//

import SwiftUI
import SwiftUICharts

struct WrapView: View {
    
    @State var data: DoughnutChartData
    
    @State var infoRowData: [DirectoryData] = []
    
    var body: some View {
        HStack {
            VStack {
                GraphDataView(testData: $data)
//                MainPageView(dataArray: $data)
            }
        }
    }
}

struct WrapView_Previews: PreviewProvider {
    static var previews: some View {
        WrapView(data: GraphDataView.exampleData())
    }
}

//static var previews: some View {
//    CategoryView(bindVar: FileNameListView(isPresented: true, categoryTitle: "asdasd").$isPresented, title: "asdad")
//}
