//
//  DataController.swift
//  CleanHands 2017
//
//  Created by Izack on 26/4/17.
//  Copyright © 2017 Republic Polytechnic. All rights reserved.
//

import Foundation
import os.log

class DataController {
    // the singleton object
    static let sharedInstance = DataController()
    // private init prevents external creation
    
    let glove = ConditionsData(description: "Glove")
    let n95 = ConditionsData(description: "N95")
    let gown = ConditionsData(description: "Gown")
    let mask = ConditionsData(description: "Mask")
    // location array
    var locations : [String] = []
    var roleAndrank : [String : [Any]] = [:]
    
    private init() {
        
        
        conditions = ["Airborne" : [n95], "Contact" : [glove, gown], "Droplet" : [mask]]
        
        //roleAndrank = ["Nurse" : ["sd", "Student", "Experienced"], "Doctor" : ["Junior", "Senior"]]
        
        locations = readArrayPlist(filename: "locations") as! [String]
        
        roleAndrank = readDictionaryPlist(filename: "roleAndrank")!
    }
    
    // get role full text
    func getRoleFullText(role: String) -> String{
        if let roleFullText = roleAndrank[role]{
            return roleFullText[0] as! String
        }
        return ""
    }
    
    //get single location
    func getLocation(index:Int) -> String {
        return locations[index]
    }
    
    // gets the number of locations
    var locationsCount : Int {
        return locations.count
    }
    
    
    func getRoles() -> [String]{
        return Array(roleAndrank.keys)
    }
    
    //get the name of the role
    func getRole(index : Int) -> String{
        return Array(roleAndrank.keys)[index]
    }
    
    func getLocations() -> [String]{
        return Array(locations)
    }
    
    
    
    
    // takes in the role, return the ranks of the role in to an array
    // this method can be used to get the rank count (getRank(role).count)
    // get rank array
    func getRanks(role: String) -> [String] {
        
        if let ranks = roleAndrank[role]{
            return ranks[1] as! [String]
        }
        return []
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
    var roleFullText : String = "Role Full Text"
    var rank : String = "Rank"
    var location : String = "Location"
    var remarks : String = "Remarks"
    var momentName : String = "Moments"
    // saving the title and notes
    var notesTitle : String = ""
    var notesText : String = ""
    
    //second level survey dictionary
    // condition : conditionSurvey
    var conditions : [String : [ConditionsData]]
    
    
    //get the name of the condition
    func getCondition(index : Int) -> String{
        return Array(conditions.keys)[index]
    }
    
    func getConditionItems (condition : String) -> [String]{
        
        var stringArr : [String] = []
        if let array = conditions[condition]{
            for data in array {
                stringArr.append(data.description)
            }
        }
        return stringArr
    }
    
    // delete this, replace with condition[row]
    func getConditionItem(conditionSurvey : [String], index : Int) -> String {
        return conditionSurvey[index]
    }
    
    func conditionItemCount (type : String) -> Int{
        if let array = conditions[type]{
            return array.count
        }
        return 0
    }
    
    var conditionCount : Int {
        return conditions.count
    }
    
    
    // stores the 5 observation points in order
    var observationPoint = ObservationPointData()
    
    //record
    
    var recordArr : [RecordData] = []
    
    func readDictionaryPlist(filename:String) -> [String : [Any]]? {
        // get the path of the plist file
        // read the plist into memory
        // convert the plist to a [String:Any] dictionary
        guard let path = Bundle.main.path(forResource: filename, ofType: "plist"),
            let data = FileManager.default.contents(atPath: path),
            let retval = try! PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String : [Any]] else {
                return nil
        }
        
        return retval
    }
    
    func readArrayPlist(filename:String) -> [Any]? {
        // get the path of the plist file
        // read the plist into memory
        // convert the plist to an [Any] array
        guard let path = Bundle.main.path(forResource: filename, ofType: "plist"),
            let data = FileManager.default.contents(atPath: path),
            let retval = try! PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [Any] else {
                return nil
        }
        
        return retval
    }
    
    
    // create csv
    
    // MARK: CSV file creating
    func createCSV() -> Void {
        
        
        
        let fileName = "records.csv"
        let path = NSURL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent(fileName)
        var csvText = "Date,Location,Job Role,Role Full Text,Rank,Staff Category,5 moments,Action,No Of Compliance,No Of Opportunity,Note,Golve,Gown,Surgical Mask,N95,Remarks\n"
        
        //month/year, time, location, job role, job role full text, rank, staff category, 5 moments, compliance, no of compliance, no of opportunity, note, glove, gown, sur mask, n95, remarks
        
        for record in recordArr {
            let newLine = "\(record.date),\(record.location),\(record.role),\(record.roleFull),\(record.rank),staff category,\(record.observationMoment),\(record.complianceAction),\(record.noOfCompliance),1,\(record.note),\(record.glove),\(record.gown),\(record.surgicalMask),\(record.n95Mask),\(record.remarks)\n"
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

        
        let record1 = RecordData()
        record1.date = Date()
        //role, location, rank
        record1.location = location
        record1.role = role
        record1.roleFull = roleFullText
        record1.rank = rank
        record1.observationMoment = momentName
        
        //saving the conditions, glove gown...
        let notes = observationPoint.notes
        let action = observationPoint.actions
        if (action == "No"){
            record1.noOfCompliance = "0"
        }
        record1.complianceAction = action
        record1.note = notes
        record1.glove = glove.items
        record1.gown = gown.items
        record1.surgicalMask = mask.items
        record1.n95Mask = n95.items
        record1.remarks = remarks
        
        
        //moment name
        
        

        
        
        recordArr.append(record1)
        
        
    }
    
    //Dian's Persistence codes
    
    //LocationTVC Persistence
    
    var newLocations : [String] = []
    var outLocations = ""
    
    func savedLocations() {
        NSKeyedArchiver.archiveRootObject(newLocations, toFile: LocationTVC.aURLlocations.path)
    }
    func savedLocation() {
        NSKeyedArchiver.archiveRootObject(outLocations, toFile: LocationTVC.aURLOutLoc.path)
    }
    
    
    func loadDefaultLocations() {
        newLocations = getLocations()
    }
    
    func loadLocations() -> [String]?  {
        let succ = NSKeyedUnarchiver.unarchiveObject(withFile: LocationTVC.aURLlocations.path) as? [String]
        return succ
    }
    
    func loadLocation() -> String?  {
        let succ = NSKeyedUnarchiver.unarchiveObject(withFile: LocationTVC.aURLOutLoc.path) as? String
        return succ
    }
    
    
    //RoleTVC functions for Persistence
    
    var newRoles : [String] = []
    var outRole = ""
    //    didSet{
    //      newRanks = getRanks(role: outRole)
    //      savedRole()
    //      outRank = newRanks[0]
    //      savedRank()
    //    }
    //  }
    
    func savedRoles() {
        NSKeyedArchiver.archiveRootObject(newRoles, toFile: RoleTVC.aURLRoles.path)
    }
    
    func savedRole() {
        NSKeyedArchiver.archiveRootObject(outRole, toFile: RoleTVC.aURLoutRole.path)
        
    }
    
    func loadDefaultRoles() {
        newRoles = getRoles()
    }
    
    func loadRoles() -> [String]?  {
        let succ = NSKeyedUnarchiver.unarchiveObject(withFile: RoleTVC.aURLRoles.path) as? [String]
        
        return succ
    }
    
    //RankTVC functions for Persistence
    var newRanks : [String] = []
    var outRank = ""
    
    func savedRanks() {
        NSKeyedArchiver.archiveRootObject(newRanks, toFile: RankTVC.aURLRanks.path)
    }
    
    func savedRank() {
        NSKeyedArchiver.archiveRootObject(outRank, toFile: RankTVC.aURLoutRank.path)
    }
    
    
    func loadDefaultRanks() {
        newRanks = getRanks(role: role)
    }
    
    func loadRanks() -> [String]?  {
        let succ = NSKeyedUnarchiver.unarchiveObject(withFile: RankTVC.aURLRanks.path) as? [String]
        
        return succ
    }
    
    
    func loadRole() -> String?  {
        let succ = NSKeyedUnarchiver.unarchiveObject(withFile: RoleTVC.aURLoutRole.path) as? String
        
        return succ
    }
    
    func loadRank() -> String?  {
        let succ = NSKeyedUnarchiver.unarchiveObject(withFile: RankTVC.aURLoutRank.path) as? String
        
        return succ
    }
    
    
    
    
}

