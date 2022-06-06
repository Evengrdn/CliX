//
//  RootPageView.swift
//  CliX
//
//  Created by Maksim Kuznecov on 09.04.2022.
//

import SwiftUI
import DiagramKit

struct RootPageView: View {
    
//    @StateObject var loading = LoadingScreen()
//
//    @State var graphData = GraphDataView.exampleData()
//
//    @State var derivedData: [DirectoryData] = []
//
//    @State var documentationCacheData: [DirectoryData] = []
//
//    @State var macOSDeviceSupportData: [DirectoryData] = []
//
//    @State var iOSDeviceSupportData: [DirectoryData] = []
//
//    @State var archivesData: [DirectoryData] = []
//
//    @State var iOSDeviceLogsData: [DirectoryData] = []
//
//    @State var watchOSDeviceSupportData: [DirectoryData] = []
//
//    @State var isPresented = false
//
//    @State var diskDataModels: [DiagramData] = []
//
//    let directuryManager = DirectoryManager()
    
    var body: some View {
        
        GeneralPageView()
    }
}

struct RootPageView_Previews: PreviewProvider {
    static var previews: some View {
        RootPageView()
    }
}

class LoadingScreen: ObservableObject {
    @Published var isLoading = false
}
