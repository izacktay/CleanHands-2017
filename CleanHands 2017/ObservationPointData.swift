//
//  ObservationPointData.swift
//  CleanHands 2017
//
//  Created by Izack on 8/5/17.
//  Copyright © 2017 Republic Polytechnic. All rights reserved.
//

import Foundation

public class ObservationPointData {
    
    var notes : String = ""
    var actions : String = ""
    var conditions : [Bool] = []
    
    init (notes : String, actions : String, conditions : [Bool]){
        self.notes = notes
        self.actions = actions
        self.conditions = conditions
    }
}
