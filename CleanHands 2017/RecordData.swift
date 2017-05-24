//
//  Records.swift
//  CleanHands 2017
//
//  Created by Izack on 29/4/17.
//  Copyright © 2017 Republic Polytechnic. All rights reserved.
//

import Foundation

class RecordData {
    
    //basically everything in the csv
    // 5 observation point data
    
    var observationPoint : [ObservationPointData] = []
    
//    private var date : Date
    var location : String = ""
    var role : String = ""
    var rank : String = ""
    var complianceAction : String = ""
    
    // 5 observation points
    var observationMoment : String = ""
    var deviceName : String = ""
    var note : String = ""
    var contact : String = ""
    var droplet : String = ""
    var airborne : String = ""
    var n95Mask : String = ""
    var glove : String = ""
    var gown : String = ""
    var surgicalMask : String = ""
    

    
}
