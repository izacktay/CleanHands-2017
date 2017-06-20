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
    //month/year, time, location, job role, job role full text, rank, staff category, 5 moments, compliance, no of compliance, no of opportunity, note, glove, gown, sur mask, n95, remarks
    
    var observationPoint : [ObservationPointData] = []
    
    var date : Date = Date()
    var location : String = ""
    var role : String = ""
    var roleFull : String = ""
    var rank : String = ""
    var complianceAction : String = ""
    var noOfCompliance : String = ""
    var noOfOpportunity : String = "1"
    
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
    var remarks : String = ""
    

    
}
