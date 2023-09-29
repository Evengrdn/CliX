//
//  LoadingScren.swift
//  CliX
//
//  Created by Maksim Kuznecov on 13.06.2022.
//

import SwiftUI

struct LoadingScreen: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(.circular)
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   minHeight: 0,
                   maxHeight: .infinity)
            .background(.gray)
            .opacity(0.5)
            .edgesIgnoringSafeArea(.all)
    }
}

struct LoadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoadingScreen()
    }
}
