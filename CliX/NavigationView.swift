//
//  NavigationView.swift
//  CliX
//
//  Created by Maksim Kuznecov on 10.05.2022.
//

import SwiftUI

struct NavigationView: View {
    
    var body: some View {
        
        HStack {
            
            VStack {
                Button("calculateDiskSpace"){
                    withAnimation(.easeInOut(duration: 0.5)){

                    }
                }
                Button("Dir information"){
                    withAnimation(.easeInOut(duration: 0.5)){
                        
                    }
                }
            }
        }
        
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView()
    }
}
