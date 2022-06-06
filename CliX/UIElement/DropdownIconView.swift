//
//  DropdownIconView.swift
//  CliX
//
//  Created by Maksim Kuznecov on 09.04.2022.
//

import SwiftUI

struct DropdownIconView: View {
    
    let title: String?
    
    @State var showDetail = false
    
    let icon: String
    
    var body: some View {
        
        HStack{
            Button{
                showDetail.toggle()
            } label: {
                Label(title ?? "", systemImage: icon)
                    .labelStyle(.iconOnly)
                    .imageScale(.large)
                    .rotationEffect(.degrees(showDetail ? 90 : 0))
                    .padding()
                    .animation(.easeInOut, value: showDetail)
                    .foregroundColor(.blue)
            }.buttonStyle(.plain)
        }
        
    }
    
    
}

struct DropdownIconView_Previews: PreviewProvider {
    static var previews: some View {
        DropdownIconView(title: "sdfgds", icon: "chevron.right.circle")
    }
}
