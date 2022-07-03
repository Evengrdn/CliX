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
                    HStack{
                        VStack{
                            HStack{
                                Text("Cleaned: ")
                                Text("\(DiskManager.shared.fromByteInSpace(Int64(viewModel.totalCleaned)))")
                                Spacer()
                            }.padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                            HStack{
                                Text("Last clean: ")
                                viewModel.lastClean == nil ?  Text("Never"): Text(viewModel.lastClean!, style: .date)
                                Spacer()
                            }.padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                        }
                        VStack{
                            Button {
                                withAnimation {
                                    viewModel.startScan()
                                }
                            } label: {
                                Text("Scan").padding()

                            }.buttonStyle(.borderless)
                                .contentShape(Rectangle())
                                .disabled(viewModel.isLoading)
                                .background(.regularMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .foregroundColor(.blue)
                        }
                        VStack{
                            Button {
                                withAnimation {
                                    viewModel.startClean()
                                }
                            } label: {
                                Text("Clean").padding()

                            }.buttonStyle(.borderless)
                                .contentShape(Rectangle())
                                .disabled(viewModel.isLoading || !viewModel.isCanClean)
                                .background(.regularMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .foregroundColor(buttonColor)


                        }.buttonStyle(.bordered)
                        VStack{
                            Link(destination: URL(string: "https://github.com/Evengrdn")!) {
                                Text("Creator").padding().foregroundColor(.blue)
                            }
                        }.background(.regularMaterial).clipShape(RoundedRectangle(cornerRadius: 8))
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
            .frame(width: 800.0, height: 800.0)
    }
}
