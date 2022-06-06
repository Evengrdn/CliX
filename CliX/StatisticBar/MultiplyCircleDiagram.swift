//
//  MultiplyCircleDiagram.swift
//  CliX
//
//  Created by Maksim Kuznecov on 11.05.2022.
//

import SwiftUI

struct MultiplyCircleDiagram: View {
    
    @State var progress = 0.01
    
    var body: some View {
        
        ZStack {
            
            Color.yellow.opacity(0.1).edgesIgnoringSafeArea(.all)
            
            ZStack{
                ProgressBar(progress: $progress,showProgressCounter: false)
                        .frame(width: 150, height: 150)
                        .padding()
                ProgressBar(progress: $progress,color: .yellow,showProgressCounter: false)
                        .frame(width: 200, height: 200)
                        .padding()
                ProgressBar(progress: $progress, color: .green, showProgressCounter: false)
                        .frame(width: 250, height: 250)
                        .padding()
                
                Button("Start") {
                    startProcess()
                }
                
            }
            
        }
    }
    func startProcess() {
        _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            withAnimation(.linear(duration: 1.5)) {
                if self.progress >= 1.0 {
                    timer.invalidate()
                }
                self.progress += 0.1
            }
            
        }
    }
}

struct MultiplyCircleDiagram_Previews: PreviewProvider {
    static var previews: some View {
        MultiplyCircleDiagram()
    }
}
