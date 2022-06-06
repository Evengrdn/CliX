//
//  GeneralPageView.swift
//  CliX
//
//  Created by Maksim Kuznecov on 05.06.2022.
//

import SwiftUI
import DiagramKit

struct GeneralPageView: View {
    
    @StateObject private var viewModel = GeneralPageViewModel()
    
    @State var test: [DirectoryData] = []
    
    var body: some View {
        
        ZStack{
            HStack(spacing: 10){
                ScrollView{
                    VStack{
                        ForEach(viewModel.directoryScan) { scan in
                            FileNameListView(data: scan.result.projectedValue, categoryTitle: scan.config.presentName ?? "Not implemented", categorySearchpath:   DirectoryManager.shared.getFullPath(directoryType: scan.config.type))
                        }
                    }
                }.padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0))
                
                VStack(spacing: 10) {
                    HStack(alignment: .center, spacing: 0){
                        StatisticBarView(diagramDataModels: $viewModel.diagramPresintationData).background(.ultraThinMaterial).clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    HStack{
                        Spacer()
                        Button(action: {
                            viewModel.scan()
                        }, label: {
                            Text("Scan").foregroundColor(.blue)
                        }).buttonStyle(.plain)
                        Spacer()
                    }.background(.ultraThinMaterial).clipShape(RoundedRectangle(cornerRadius: 8))
                }.padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
                
            }
//            .blur(radius: loading.isLoading ? 30 : 0).allowsHitTesting(!loading.isLoading)/
//            Text("происходит поиск").opacity(loading.isLoading ? 1 : 0)
        }
    }
}

struct GeneralPageView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralPageView()
    }
}
