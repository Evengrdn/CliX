//
//  NewRootPage.swift
//  CliX
//
//  Created by Maksim Kuznecov on 21.09.2023.
//

import SwiftUI
import SkeletonUI
import Charts

struct GeneralPageViewController: View {
    
    /// Вьюмодел
    @StateObject private var viewModel = GeneralPageViewModel()
    
    /// Выбранная категория
    @State var selectedType: DirectoryForScan? = nil
    
    var body: some View {
        VStack{
            prepareButtonsLine()
            prepareDiagramView()
            prepareDiagramDescriptionTable()
        }.padding(.all, 12)
    }
    
    /// Метод подготовки линии управления приложением
    /// - Returns: Линия управления приложением
    func prepareButtonsLine() -> some View {
        HStack{
            Button {
                Task {
                    await viewModel.startScan()
                }
            } label: {
                Text("Scan").padding(.init(top: 4, leading: 0, bottom: 4, trailing: 4))
            }.buttonStyle(.borderless)
            
            Button {
                Task {
                    await viewModel.startClean()
                }
            } label: {
                Text("Clean").padding(.all, 4)
                
            }.buttonStyle(.borderless)
                .disabled(!viewModel.isCanClean)
            
            HStack{
                Link(destination: URL(string: "https://github.com/Evengrdn")!) {
                    Text("Creator")
                        .padding(.all, 4)
                        .foregroundColor(.blue)
                }
            }
            Spacer()
            StatisticView()
        }
    }
    
    /// Метож подготовки диаграммы
    /// - Returns: Диаграмма
    func prepareDiagramView() -> some View {
        Chart {
            ForEach(viewModel.scaneFolders, id: \.id) { value in
                BarMark(
                    x: .value("type", value.type.rawValue),
                    y: .value("size", value.info.size)
                )
                .annotation {
                    if value.info.size == 0 {
                        Text("\(value.info.convertTo(.gb))")
                    } else {
                        Text("\(value.info.fullName) = \(value.info.convertTo(.gb))")
                    }
                   
                }
            }
        }.skeleton(with: viewModel.isLoading, shape: .rounded(.radius(8, style: .continuous)), lines: 2)
    }
    
    /// Метод подготовки описания диаграммы
    /// - Returns: Описание диаграммы
    func prepareDiagramDescriptionTable() -> some View {
        let columns = [GridItem(.flexible()), GridItem(.flexible())]
        
        return VStack{
            LazyVGrid(columns: columns) {
                ForEach(viewModel.scaneFolders, id: \.id) { value in
                    CategoryView(scanData: value, isLoad: viewModel.isLoading).frame(height: 50)
                        .onTapGesture {
                            selectedType = value
                        }
                        .sheet(item: $selectedType) { scanData in
                            VStack {
                                Button("Dismiss") {
                                    selectedType = nil
                                }
                                CategoryDetailSheet(scanData: scanData)
                            }
                            
                        }
                }
            }
        }
    }
}

struct GeneralPageViewController_Previews: PreviewProvider {
    static var previews: some View {
        GeneralPageViewController()
    }
}

