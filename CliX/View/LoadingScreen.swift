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
    }
}

struct LoadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoadingScreen()
    }
}
