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
    private init() {
        
        let glove = SecondLevelData(description: "Glove")
        let n95 = SecondLevelData(description: "N95")
        let gown = SecondLevelData(description: "Gown")
        let mask = SecondLevelData(description: "Mask")
        
        conditions = ["Airborne" : [n95], "Contact" : [glove, gown], "Droplet" : [mask]]
        
        roleAndrank = ["Nurse" : ["Student", "Experienced"], "Doctor" : ["Junior", "Senior"]]
        
    }
    // need dictionary that stores String : String Array for
    
    // location array
    var locations : [String] = ["A", "B", "C"]
    
    // checkbox array
    var checkbox : [String] = []
    
    //get single location
    func getLocation(index:Int) -> String {
        return locations[index]
    }
    
    // gets the number of locations
    var locationsCount : Int {
        return locations.count
    }
    
    // gets the number of checkboxes
    var checkboxCount : Int {
        return checkbox.count
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
    func getRank(role: [String], index:Int) -> String {
        return role[index]
    }
    
    // gets the number of roles to update the table
    var roleCount : Int {
        return roleAndrank.count
    }
    
    // updated every time cell from RoleTVC is selected. updated with the role name.
    var role : String = "Role"
    var rank : String = "Rank"
    
    
    //second level survey dictionary
    var conditions : [String : [SecondLevelData]]
    
    
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
    func getConditionSurvey(condition : [String], index : Int) -> String {
        return condition[index]
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
    
    
    
}

