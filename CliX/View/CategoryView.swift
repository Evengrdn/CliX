//
//  CategoryListView.swift
//  CliX
//
//  Created by Maksim Kuznecov on 09.04.2022.
//

import SwiftUI
import UniformTypeIdentifiers

struct CategoryView: View {
    
    @State private var rotateIcon = false
    @Binding var showData: Bool
    @Binding var showDetailIcon: [DirectoryData]
    
    let selectColor: LinearGradient = {
        let linearGradient = LinearGradient(colors: [.init(red: 240.0 / 255, green: 143.0 / 255, blue: 144.0 / 255), .init(red: 157.0 / 255, green: 41.0 / 255, blue: 51.0 / 255)], startPoint: .leading, endPoint: .trailing)
        
        return linearGradient
        
    }()
    
    let defoultColor = Color.teal
    
    private var bytesSumm: Int64 {
        showDetailIcon.reduce(0, { result, element in
            result + element.sizeAtDiskInByte
        })
    }
    
    let title: String
    
    let searchpath: String
    
    var body: some View {
        
        VStack{
            
            HStack(alignment: .top, spacing: 0){
                
                VStack{
                    HStack{
                        Text(title).font(.title)
                        
                        Button{
                            withAnimation(.easeInOut(duration: 1)){
                                rotateIcon.toggle()
                                showData.toggle()
                            }
                        } label: {
                            Label("", systemImage: "chevron.right.circle")
                                .labelStyle(.iconOnly)
                                .imageScale(.large)
                                .rotationEffect(.degrees(rotateIcon ? 90 : 0))
                            
                                .animation(.easeInOut, value: rotateIcon)
                                .foregroundColor(.blue)
                        }.buttonStyle(.plain).opacity(showDetailIcon.count >= 1 ? 1 : 0)
                        
                        Spacer()
                        Text(DiskManager.shared.fromByteInSpace(bytesSumm)).font(.title2)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            Text(searchpath).textSelection(.enabled)
                        }
                    }
                }
                
                
            }
            
        }.padding().background(.regularMaterial).clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct CategoryView_Previews: PreviewProvider {
    
    static var previews: some View {
        CategoryView(showData: TreashCan.$showData, showDetailIcon: TreashCan.$showDetail, title: "Derived data", searchpath: "searchpath/searchpath/searchpath")
    }
}

struct TreashCan {
    
    @State static var showData = true
    
    @State static var showDetail = [
        DirectoryData(name: "test1", sizeAtDisk: "100 MB"),
        DirectoryData(name: "test2", sizeAtDisk: "200 MB"),
        DirectoryData(name: "test3", sizeAtDisk: "300 MB"),
        DirectoryData(name: "test4", sizeAtDisk: "400 MB"),
    ]
}
