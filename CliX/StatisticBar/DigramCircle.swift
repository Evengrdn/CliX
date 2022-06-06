//
//  DigramCircle.swift
//  CliX
//
//  Created by Maksim Kuznecov on 11.05.2022.
//

import SwiftUI

struct DigramCircle: View {
    
    @State var progress = 0.01
    
    @State var data: [SingleCircleDiagramData]
    
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
    
    var body: some View {
        ZStack {
            
            Color.yellow.opacity(0.1).edgesIgnoringSafeArea(.all)
            
            ZStack{
                
                StatisticCircle()
                
//                ProgressBar(progress: $progress,showProgressCounter: false)
//                        .frame(width: 150, height: 150)
//                        .padding()
//                ProgressBar(progress: $progress,color: .yellow,showProgressCounter: false)
//                        .frame(width: 200, height: 200)
//                        .padding()
//                ProgressBar(progress: $progress, color: .green, showProgressCounter: false)
//                        .frame(width: 250, height: 250)
//                        .padding()
//
                Button("Start") {
                    startProcess()
                }
                
            }
            
        }
    }
}

struct DigramCircle_Previews: PreviewProvider {
    static var previews: some View {
        DigramCircle(data: [
            SingleCircleDiagramData(value: 10, color: .green),
            SingleCircleDiagramData(value: 20, color: .yellow),
            SingleCircleDiagramData(value: 40, color: .red),
            SingleCircleDiagramData(value: 30, color: .blue)
        ])
    }
}

struct SingleCircleDiagramData: Identifiable {
    
    var id: UUID = UUID()
    
    var value: Double
    
    var color: Color
}

struct StatisticCircle: View {
    
    var color: Color = .red
    
    private var lastStepTo = 0.0
    
    private var lastStepFrom = 1.0
    
    var data = [
        SingleCircleDiagramData(value: 10, color: .green),
        SingleCircleDiagramData(value: 10, color: .yellow),
        SingleCircleDiagramData(value: 10, color: .red),
        SingleCircleDiagramData(value: 30, color: .blue)
    ]
    
    private var percent: Double {
        return data.reduce(0, { result, element in
            result + element.value
        }) * 0.01
    }
    
    var showProgressCounter = true
    
    var body: some View {
        ZStack{
            
            ForEach(data) { model in
//
//                Circle()
//                    .stroke(lineWidth: 20)
//                    .opacity(0.3)
//                    .foregroundColor(color)
            
                
                Circle()
                    .trim(from:  0.0 , to: 1.0)
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .foregroundColor(model.color)
                    .rotationEffect(Angle(degrees: -90))
                
//                Text(String(format: "%.0f %%", min(self.progress, 1.0)*100.0))
//                    .font(.largeTitle)
//                    .bold()
//                    .animation(.none)
//                    .opacity(showProgressCounter ? 1 : 0)
                
            }
            
            
        }
    }
    
//    func fillValue(model: SingleCircleDiagramData) {
//        guard let index = data.firstIndex(where: { dataModel in
//            return dataModel.id == model.id
//        }) else { return }
//
//        lastStepFrom += 1 / (model.value * percent)
//        lastStepTo += 1 / (model.value * percent)
//
//        if index == 0 {
//            lastStepFrom = 0.0
//        }
//
//        if index == data.count-1 {
//            lastStepTo = 1.0
//        }
//    }
//    func toValue(model: SingleCircleDiagramData) -> Double {
//        guard let index = data.firstIndex(where: { dataModel in
//            return dataModel.id == model.id
//        }) else { return 0.0}
//
//        lastStepFrom += 1 / (model.value * percent)
//        lastStepTo += 1 / (model.value * percent)
//
//        if index == 0 {
//            lastStepFrom = 0.0
//        }
//
//        if index == data.count-1 {
//            lastStepTo = 1.0
//        }
//
//        print(lastStepTo, "to")
//
//        return 1.0
//    }
    
//    func getPathOfCicle(model: SingleCircleDiagramData) -> [Double] {
//
//        guard let index = data.firstIndex(where: { dataModel in
//            return dataModel.id == model.id
//        }) else { return Circle() }
//
//        var from = 1 / (model.value * percent)
//        var to = 1 / (model.value * percent)
//
//        if index == 0 {
//            from = 0.0
//        }
//
//        if index == data.count-1 {
//            return 1.0
//        }
//
//        let circle = Circle()
//            .trim(from:  from , to: to)
//            .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
//            .foregroundColor(model.color)
//            .rotationEffect(Angle(degrees: -90))
//
//        return circle
//
//    }
    
//    func calcToCoordinate(model: SingleCircleDiagramData) -> Double {
//
//
//
//        print(index)
//
//        if index == data.count-1 {
//            return 1.0
//        }
//
//        return 1 / (model.value * percent)
//    }
//
//    func calcFromCoordinate(model: SingleCircleDiagramData) -> Double {
//
//        guard let index = data.firstIndex(where: { dataModel in
//            return dataModel.id == model.id
//        }) else { return 0.0 }
//
//
//
//        if index == 0 {
//            return 0.0
//        }
//
//
//       return 1 / (model.value * percent)
//    }
}


