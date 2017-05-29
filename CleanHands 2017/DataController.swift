//
//  DataController.swift
//  CleanHands 2017
//
//  Created by Izack on 26/4/17.
//  Copyright © 2017 Republic Polytechnic. All rights reserved.
//

import Foundation
class DataController {
    // the singleton object
    static let sharedInstance = DataController()
    // private init prevents external creation
    
    let glove = ConditionsData(description: "Glove")
    let n95 = ConditionsData(description: "N95")
    let gown = ConditionsData(description: "Gown")
    let mask = ConditionsData(description: "Mask")
    
    private init() {
        
        
        conditions = ["Airborne" : [n95], "Contact" : [glove, gown], "Droplet" : [mask]]
        
        roleAndrank = ["Nurse" : ["Student", "Experienced"], "Doctor" : ["Junior", "Senior"]]
        
    }
    // need dictionary that stores String : String Array for
    
    // location array
    var locations : [String] = ["A", "B", "C"]
    
    //get single location
    func getLocation(index:Int) -> String {
        return locations[index]
    }
    
    // gets the number of locations
    var locationsCount : Int {
        return locations.count
    }
    
    //roleAndrank dictionary
    var roleAndrank : [String : [String]]
    
    
    //get the name of the role
    func getRole(index : Int) -> String{
        return Array(roleAndrank.keys)[index]
    }
    
    
    // takes in the role, return the ranks of the role in to an array
    // this method can be used to get the rank count (getRank(role).count)
    // get rank array
    func getRanks(role: String) -> [String] {
        return roleAndrank[role]!
    }
    
    //get single rank
    func getRank(rank: [String], index:Int) -> String {
        return rank[index]
    }
    
    // gets the number of roles to update the table
    var roleCount : Int {
        return roleAndrank.count
    }
    
    // updated every time cell from RoleTVC is selected. updated with the role name.
    var role : String = "Role"
    var rank : String = "Rank"
    
    
    //second level survey dictionary
    // condition : conditionSurvey
    var conditions : [String : [ConditionsData]]
    
    
    //get the name of the condition
    func getCondition(index : Int) -> String{
        return Array(conditions.keys)[index]
    }
    
    func getConditionSurveys (condition : String) -> [String]{
        
        var stringArr : [String] = []
        if let array = conditions[condition]{
            for data in array {
                stringArr.append(data.description)
            }
        }
        return stringArr
    }
    
    // delete this, replace with condition[row]
    func getConditionSurvey(conditionSurvey : [String], index : Int) -> String {
        return conditionSurvey[index]
    }
    
    func conditionSurveyCount (type : String) -> Int{
        if let array = conditions[type]{
            return array.count
        }
        return 0
    }
    
    var conditionCount : Int {
        return conditions.count
    }
    
    
    // saving the title and notes
    var notesTitle : String = ""
    var notesText : String = ""
    
    
    // stores the 5 observation points in order
    var observationArr : [ObservationPointData] = []
    
    //record
    let record1 = RecordData()
    var recordArr = [RecordData]()
    
    
    // create csv
    
    // MARK: CSV file creating
    func createCSV() -> Void {
        
        
        
        let fileName = "records.csv"
        let path = NSURL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent(fileName)
        var csvText = "Date,Location,Job Role,Rank,5 moments,Note,N95,Glove,Gown,Mask\n"
        
        print(recordArr[0].role)
        for record in recordArr {
            let newLine = "\(Date()),\(record.location),\(record.role),\(record.rank),\(record.observationMoment),\(record.note),\(record.n95Mask),\(record.glove),\(record.gown),\(record.surgicalMask)\n"
            csvText.append(newLine)
        }
        
        do {
            try csvText.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("Failed to create file")
            print("\(error)")
        }
        print(path ?? "not found")
    }
    
    
    func createRecord() -> Void {
        
        var selCondition : Int = 4
        var observationMoment : String = ""
        
        record1.location = "A"
        record1.role = role
        record1.rank = rank
        
        for i in 0...4 {
            
            let notes = observationArr[i].notes
            let actions = observationArr[i].actions
            let conditions = observationArr[i].conditions
            
            
            
            for condition in conditions{
                if (condition.selected == false){
                    selCondition -= 1
                }
            }
            
            //set observation moment name
            if (i == 0){
                observationMoment = "Before Contact"
            }else if (i == 1) {
                observationMoment = "After Contact"
            }else if (i == 2){
                observationMoment = "Before Exposure"
            }else if (i == 3){
                observationMoment = "After Exposure"
            }else {
                observationMoment = "After Environment"
            }
            
            
            
            // set n95, glove, gown, mask
            
            guard conditions.count < 0 else {
//                print ("hi")
//                if (conditions[0].selected == true){
//                    record1.n95Mask = "True"
//                }else {
//                    record1.n95Mask = "N/A"
//                }
//                
//                if (conditions[1].selected == true){
//                    record1.glove = "True"
//                }else {
//                    record1.glove = "N/A"
//                }
//                
//                if (conditions[2].selected == true){
//                    record1.gown = "True"
//                }else {
//                    record1.gown = "N/A"
//                }
//                
//                if (conditions[3].selected == true){
//                    record1.surgicalMask = "True"
//                }else {
//                    record1.surgicalMask = "N/A"
//                }
                
                guard notes == "", actions == "", selCondition == 0 else{
                    
                    record1.note = notes
                    record1.complianceAction = actions
                    record1.observationMoment = observationMoment
                    
                    
                    recordArr.append(record1)
                    return
                }
                return
            }
        
            
            // nothing will be ran if the observation point is empty
        }
        // for loop
        
        
        
        
        
    }
    
    
    
    
}

