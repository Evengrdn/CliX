//
//  Hike.swift
//  CliX
//
//  Created by Maksim Kuznecov on 09.04.2022.
//

import Foundation

struct Hike: Codable, Hashable, Identifiable {
    var id: Int
    var name: String
    var distance: Double
    var observations: [Observation]
    
    static var formatter = LengthFormatter()
    
    var distanceText: String {
        Hike.formatter.string(fromValue: distance, unit: .kilometer)
    }
    
    struct Observation: Codable, Hashable {
        var distancefromStart: Double
        
        var elevation: Range<Double>
        var pace: Range<Double>
        var heardRAte: Range<Double>
    }
    
}
