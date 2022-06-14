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
                        StatisticBarView(diagramDataModels: $viewModel.diagramPresintationData).background(.ultraThinMaterial).clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    HStack{
                        VStack{
                            HStack{
                                Text("Cleaned: \(DiskManager.shared.fromByteInSpace(Int64(viewModel.totalCleaned)))")
                            }.padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                            HStack{
                                
                                Text("Last clean: ")
                                viewModel.lastClean == nil ?  Text("Never"): Text(viewModel.lastClean!, style: .date)
                                
                            }.padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                            HStack{
                                Link(destination: URL(string: "https://github.com/Evengrdn")!) {
                                    Text("Creator")
                                }
                            }.padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                        }.background(.ultraThinMaterial).clipShape(RoundedRectangle(cornerRadius: 8))
                        VStack{
                            Button {
                                withAnimation {
                                    viewModel.startScan()
                                }
                            } label: {
                                Text("Scan").padding().background(.ultraThinMaterial).clipShape(RoundedRectangle(cornerRadius: 8)).foregroundColor(.blue)
                                    
                            }.buttonStyle(.borderless)
                                .contentShape(Rectangle())
                                .disabled(viewModel.isLoading)
                            
                            Button {
                                withAnimation {
                                    viewModel.startClean()
                                }
                            } label: {
                                Text("Clean").padding().background(.ultraThinMaterial).clipShape(RoundedRectangle(cornerRadius: 8)).foregroundColor(buttonColor)
                                    
                            }.buttonStyle(.borderless)
                                .contentShape(Rectangle())
                                .disabled(viewModel.isLoading || !viewModel.isCanClean)
                            
                            
                        }.buttonStyle(.bordered)
                        Spacer()
                    }
                    
                }.padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0))
                
                
                
                ScrollView{
                    VStack{
                        ForEach(viewModel.directoryScan) { scan in
                            FileNameListView(data: $viewModel.directoryScan.first(where: { innerScan in
                                innerScan.id == scan.id
                            })!.result, categoryTitle: scan.config.presentName ?? "Not implemented", categorySearchpath:   DirectoryManager.shared.getFullPath(directoryType: scan.config.type)).blur(radius: viewModel.isLoading ? 5 : 0)
                        }
                    }
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
    }
}
