//
//  FileNameListView.swift
//  CliX
//
//  Created by Maksim Kuznecov on 10.04.2022.
//

import SwiftUI

struct FileNameListView2: View {
    var body: some View {
        Text("Test")
    }
}

struct FileNameListView: View {
    
    @State var isPresented = false
    
    var hasPresentData: Bool {
        return data.count > 0
    }
    
    @State private var listSize: CGFloat = 250
    
    @State private var filerType = 1
    
    @Binding var data: [DirectoryData]
    
    let categoryTitle: String
    let categorySearchpath: String
    
    var body: some View {
        
        VStack(spacing: 0) {
            
//            CategoryView(showData: $isPresented, showDetailIcon: $data, title: categoryTitle,searchpath: categorySearchpath )
            
//            VStack {
//                HStack(alignment: .top){
//                    Picker("", selection: $filerType){
//                        Text("Name").tag(1)
//                        Text("Size").tag(2)
//                    }.pickerStyle(.segmented).onChange(of: filerType) { sortType in
//                        switch sortType {
//                            case 1:
//                                data.sort{
//                                    $0.name < $1.name
//                                }
//                                break
//                            case 2:
//                                data.sort{
//                                    $0.sizeInDouble() ?? 0.0 > $1.sizeInDouble() ?? 0.0
//                                }
//                                break
//                            default:
//                                data.sort{
//                                    $0.name < $1.name
//                                }
//                        }
//                    }.labelsHidden().padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
//                }
//                List(data){ item in
//                    VStack {
//                        HStack {
//                            VStack{
//                                Text(item.name)
//                            }
//                            Spacer()
//                            VStack{
//                                Text(item.sizeAtDisk)
//                            }
//                        }
//                    }
//                    Divider()
//                }.clipShape(RoundedRectangle(cornerRadius: 8))
//            }.clipShape(RoundedRectangle(cornerRadius: 8)).frame(height: isPresented && data.count > 0  ? listSize : 0).clipped()
        }
        
    }
    
    @State static var asd = [DirectoryData(name: "Test1sdfdasfasfasdfasdfasdfadsfdasfasfasfasfasdfasdfasd", sizeAtDisk: "Test1")]
}


struct FileNameListView_Previews: PreviewProvider {
    static var previews: some View {
        FileNameListView(data: FileNameListView.$asd, categoryTitle: "Derived Data", categorySearchpath: "asdasdasdasd/asdasdas")
    }
}


