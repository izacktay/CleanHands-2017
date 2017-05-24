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
    
    
    // observation tvc
    
    
    
    //which will
    var observationArr : [ObservationPointData] = []
    
    //record
    let record1 = RecordData()
    let recordArr = [RecordData]()
    
    
    // create csv
    
    // MARK: CSV file creating
    func creatCSV() -> Void {
        
        record1.location = "A"
        record1.role = role
        record1.rank = rank
        
        let fileName = "Tasks.csv"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        var csvText = "Date,Task Name,Time Started,Time Ended\n"
        
        for record in recordArr {
            let newLine = "\(record.location),\(record.role),\(record.rank)\n"
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

    
    
    
}

