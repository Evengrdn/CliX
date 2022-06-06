//
//  LayoutExample.swift
//  CliX
//
//  Created by Maksim Kuznecov on 31.05.2022.
//

import SwiftUI
import DiagramKit

struct LayoutExample: View {
    
    @State var derivedData: [DirectoryData] = []
    
    @State var documentationCacheData: [DirectoryData] = []
    
    @State var macOSDeviceSupportData: [DirectoryData] = []
    
    @State var iOSDeviceSupportData: [DirectoryData] = []
    
    @State var archivesData: [DirectoryData] = []
    
    @State var iOSDeviceLogsData: [DirectoryData] = []
    
    @State var watchOSDeviceSupportData: [DirectoryData] = []
    
    @State var isPresented = false
    
    @State var diskDataModels: [DiagramData] = []
    
    let directuryManager = DirectoryManager()
    
    var body: some View {
        HStack(alignment: .top, spacing: 10){
            
            
            VStack{
                FileNameListView(isPresented: isPresented, data: $derivedData, categoryTitle: "derivedData", categorySearchpath: directuryManager.getFullPath(directoryType: .derivedData))
                
                FileNameListView(isPresented: isPresented, data: $iOSDeviceSupportData, categoryTitle: "iOSDeviceSupport", categorySearchpath: directuryManager.getFullPath(directoryType: .iOSDeviceSupport))
                
                FileNameListView(isPresented: isPresented, data: $archivesData, categoryTitle: "archives", categorySearchpath: directuryManager.getFullPath(directoryType: .archives))
                
                FileNameListView(isPresented: isPresented, data: $documentationCacheData, categoryTitle: "documentationCache", categorySearchpath: directuryManager.getFullPath(directoryType: .documentationCache))
                
                FileNameListView(isPresented: isPresented, data: $iOSDeviceLogsData, categoryTitle: "iOSDeviceLogs", categorySearchpath: directuryManager.getFullPath(directoryType: .iOSDeviceLogs))
                
                FileNameListView(isPresented: isPresented, data: $watchOSDeviceSupportData, categoryTitle: "watchOSDeviceSupport", categorySearchpath: directuryManager.getFullPath(directoryType: .watchOSDeviceSupport))
            }
            
        }.frame(alignment: .top)
        
    }
}

struct LayoutExample_Previews: PreviewProvider {
    static var previews: some View {
        LayoutExample()
    }
}
