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
    
    var buttonColor: Color {
        viewModel.isCanClean ? .blue : .gray;
    }
    
    var body: some View {
        
        ZStack{
            HStack(spacing: 10){
                VStack(spacing: 10) {
                    
                    HStack(alignment: .center, spacing: 0){
                        StatisticBarView(diagramDataModels: $viewModel.diagramPresintationData).background(.regularMaterial).clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }.padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0))
                ScrollView{
//                    VStack{
//                        ForEach(viewModel.directoryScan) { scan in
//                            FileNameListView(data: $viewModel.directoryScan.first(where: { innerScan in
//                                innerScan.id == scan.id
//                            })!.result, categoryTitle: scan.config.presentName ?? "Not implemented", categorySearchpath:   DirectoryManager.shared.getFullPath(directoryType: scan.config.type)).blur(radius: viewModel.isLoading ? 5 : 0)
//                        }
//                    }
                }.padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
            if viewModel.isLoading {
                LoadingScreen()
            }
        }
    }
}

struct GeneralPageView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralPageView()
            .frame(width: 800.0, height: 800.0)
    }
}
