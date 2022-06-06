//
//  MainPageView.swift
//  CliX
//
//  Created by Maksim Kuznecov on 08.04.2022.
//

import SwiftUI
import SwiftUICharts
import DiagramKit

struct MainPageView: View {
    
    @ObservedObject var loading: LoadingScreen
    
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
    
    @State var dataArray: [DiagramData] = []
    
    @State var dataProviders: [DataProvider]
    
    let diskManager = DiskManager()
    
    let directoryManager = DirectoryManager()
    
    var body: some View {
        
        VStack(spacing: 10) {
            HStack(alignment: .center, spacing: 0){
                
                StatisticBarView(diagramDataModels: $dataArray).background(.ultraThinMaterial).clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            HStack{
                Spacer()
                
                
                Button(action: {
                    toggleLoadingScreen()
                    
                    Task {
                        await dirInformation()
                        toggleLoadingScreen()
                    }
                    
                    
                }, label: {
                    Text("Scan").foregroundColor(.blue)
                }).buttonStyle(.plain).disabled(loading.isLoading)
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.5)){
                        self.loading.isLoading.toggle()
                        print(self.loading.isLoading)
                    }
                }, label: {
                    Text("Prac").foregroundColor(.blue)
                }).buttonStyle(.plain)
                
                
                Spacer()
            }.background(.ultraThinMaterial).clipShape(RoundedRectangle(cornerRadius: 8))
        }
        
    }
    
    func toggleLoadingScreen() {
         
            loading.isLoading.toggle()
        
    }
    
    func dirInformation() async -> Void {
        
//        await toggleLoadingScreen()
        
        dataArray.removeAll()
        
        dataProviders.forEach{ provider in
            
            let path = directoryManager.getFullPath(directoryType: provider.type)
            let subDir = directoryManager.getSubDirectoriesForPath(path)
            
            let category = subDir.map{ dir -> DirectoryData in
                
                let size = directoryManager.getSize(path: dir, completion: nil)
                let diplayableDir = dir.split(separator: "/").last
                
                
                
                return DirectoryData(name: String(diplayableDir ?? ""), sizeAtDisk: diskManager.convertFromBytes(size), sizeAtDiskInByte: size)
            }
            
            provider.data.wrappedValue = category
            
            
            
            let summ: Int64 = provider.data.wrappedValue.reduce(0, { result, model in
                return result + model.sizeAtDiskInByte
            })
            
            
//            if summ > 500000 {
//                dataArray.append(DiagramData(value: Double(summ), title: provider.name, color: provider.presentationColor, format: { DiskManager.fromByteInSpace(Int64($0)) }))
//            }
        }
        
//        await toggleLoadingScreen()
        
        return;
        
    }
}

//struct MainPageView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        MainPageView(dataArray: WrapView(data: GraphDataView.exampleData()).$data, diskData: [])
//    }
//}
