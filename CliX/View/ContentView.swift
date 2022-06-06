//
//  ContentView.swift
//  CliX
//
//  Created by Maksim Kuznecov on 08.04.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        RootPageView().frame(minWidth: 900, idealWidth: 900, maxWidth: .infinity, minHeight: 700, idealHeight: 700, maxHeight: .infinity, alignment: .top)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
