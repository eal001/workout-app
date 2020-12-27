//
//  Routine.swift
//  Workout App
//
//  Created by Elliot Lee on 12/15/20.
//

import UIKit
/*
 a routine will be able to save itself to UDM, and a static funuctionality to load
 a routine from a JSON encoding, given the key
 It will store (weekly) cycles and have a name
 Eventually there will be an ability to index all exercises across these cycles, and check each one for the maximum stats
 */

class Routine: NSObject, Codable {
    
    //MARK: INSTANCE VARS
    
    var name : String
    var cycles : [Cycle] = [Cycle]()
    
    //MARK: INITIALIZATION
    
    init(_ name : String, _ cycles : [Cycle]) {
        self.cycles = cycles
        self.name = name
    }
    
    override init(){
        self.name = ""
        self.cycles = [Cycle]()
    }
    
    //MARK: HANDLE SAVE AND LOAD
    
    /*
     A Routine can save itself and return the string key to where it is hashed?
     We will use the string name as its key, becasue all String objects are mutable,
     and creating a new string with the same elements is a different object & thus has a
     different meaning to the encoder, even if there are 10 of the same names
     @return the key to where it is saved
     */
    func save() -> String{
        let encoder = JSONEncoder()
        if let data =  try? encoder.encode(self) {
            UDM.shared.defaults?.setValue(data, forKey: name )
            return name
        } else {
            print("\(Constants.SAVE_ERR_MSG_0) \(name)")
        }
        return ""
    }
    
    /*
     Routine will have a static function. This method is unrelated to the contents of
     any routine class it will be called by Routine.load(key), and returns a routine
     based on the key. I put it in this class becasue it makes sense that loading and
     saving of some routine would be handled by itself
     @param the key to load from
     @return the loaded routine
     */
    static func load(_ key : String) -> Routine{
        if let data = UDM.shared.defaults?.data(forKey: key) {
            let decoder = JSONDecoder()
            if let some_routine = try? decoder.decode(Routine.self, from: data){
                return some_routine
            }
            print("\(Constants.LOAD_ERR_MSG_0) \(key)")
        } else {
            print("\(Constants.LOAD_ERR_MSG_1) \(key)")
        }
        return Routine("", [Cycle]() )  //this statement could cause problems if it is run, most of this code assumes a full routine class
    }
}

//MARK: USER DEFAULTS CLASS

/*
 Using the codable interface and UserDefaults, all classes and structures within a codable
 class should also be codable. if this is the case, encoding the container class encodes
 the assets/ instance fields of the class
 */
class UDM {
    static let shared = UDM()
    let defaults = UserDefaults(suiteName: Constants.SUITE_NAME )
}

/*
 we will create a class that contains all of the constants in this project. This way changing the constants will allow
 easy access for changing how the code works. Later we will find a way to adjust these valuse within the program so to
 implement different functionality
 */
struct Constants {
    
    //MARK: - Constants
    public static let WEIGHT_INCREMENT = 2.5
    public static let REP_INCREMENT = 4
    public static let ACCESSORY_MAX = 24
    public static let ACCESSORY_RESET = 12
    public static let EX_TYPE_COUNT = 6
    public static let WEEKDAY_1 = "Monday"
    public static let WEEKDAY_2 = "Tuesday"
    public static let WEEKDAY_3 = "Wednesday"
    public static let WEEKDAY_4 = "Thursday"
    public static let WEEKDAY_5 = "Friday"
    public static let WEEKDAY_6 = "Saturday"
    public static let WEEKDAY_7 = "Sunday"
    public static let NULL_STR = "NULL"
    public static let SUITE_NAME = "com.elliotlee.workout-app"
    public static let LOAD_ERR_MSG_0 = "Routine: Some data existed but could not be decoded"
    public static let LOAD_ERR_MSG_1 = "Routine: unable to get data for the key"
    public static let SAVE_ERR_MSG_0 = "Routine: unable to encode routine"
    public static let MASTER_KEY = "MASTER KEY"
    public static let SAVE_ERR_MSG_1 = "RoutineViewComtroller: unable to encode the routine keys to the master key"
    public static let LOAD_ERR_MSG_2 = "RoutineViewController: some data existed at the master key but was not decoded"
    public static let LAOD_ERR_MSG_3 = "RoutineViewVontroller: unable to get data for the routine keys"
    public static let CELL_ID_0 = "proto_cell"
    public static let CELL_ID_1 = "set_cell"
    public static let ROUTINES = "Routines"
    public static let CYCLES = "Cycles"
    public static let DAYS = "Days"
    public static let EXERCISES = "Exercises"
    public static let SETS = "Sets"
    public static let ZERO_STR = "0"
    public static let REST_DAY = "Rest Day"
    public static let EX_TYPE_0 = "Primary"
    public static let EX_TYPE_1 = "Secondary"
    public static let EX_TYPE_2 = "Compound"
    public static let EX_TYPE_3 = "Accessory"
    public static let EX_TYPE_4 = "Calisthenic"
    public static let EX_TYPE_5 = "Other"
    public static let VC_ID_0 = "certain_day"
    public static let STORYBOARD_ID = "Main"
    public static let WEIGHT_UNIT = "Kgs"
    public static let REP_UNIT = "Reps"
    public static let VOL_UNIT = "\(WEIGHT_UNIT) x \(REP_UNIT)"
    public static let SET_TITLE = "Set"
    public static let WEIGHT_MSG = "Maximum Weight Set for"
    public static let REPS_MSG = "Maximum Rep Set for"
    public static let VOLUME_MSG = "Maximum Volume Set for"
    public static let FINISHED_TXT = "OK"
    
    //light mode colors
    public static let LIGHT_BACKGROUND = UIColor.white
    public static let LIGHT_SECTION = UIColor.systemGray5
    public static let LIGHT_CELL_0 = UIColor.systemGray6
    public static let LIGHT_CELL_1 = UIColor.systemGray5
    public static let LIGHT_TEXT = UIColor.black
    
    //dark mode colors
    public static let DARK_BACKGROUND = UIColor.black
    public static let DARK_SECTION = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1)
    public static let DARK_CELL_0 = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1)
    public static let DARK_CELL_1 = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
    public static let DARK_TEXT = UIColor.white
    
    //MARK: - Global Variables
    //color mode type:  may change on a settings change
    public static var MODE = ColorMode.Dark
    
    public static var BACKGROUND = { () -> UIColor in
        var bg = Constants.LIGHT_BACKGROUND
        switch(MODE){
        case .Dark:
            bg = Constants.DARK_BACKGROUND
        case .Light:
            bg = Constants.LIGHT_BACKGROUND
        }
        return bg
    }
    
    public static var TEXT = { () -> UIColor in
        var bg = Constants.LIGHT_TEXT
        switch(MODE){
        case .Dark:
            bg = Constants.DARK_TEXT
        case .Light:
            bg = Constants.LIGHT_TEXT
        }
        return bg
    }
    
    public static var SECTION = { () -> UIColor in
        var bg = Constants.LIGHT_SECTION
        switch(MODE){
        case .Dark:
            bg = Constants.DARK_SECTION
        case .Light:
            bg = Constants.LIGHT_SECTION
        }
        return bg
    }
    
    public static var CELL_0 = { () -> UIColor in
        var bg = Constants.LIGHT_CELL_0
        switch(MODE){
        case .Dark:
            bg = Constants.DARK_CELL_0
        case .Light:
            bg = Constants.LIGHT_CELL_0
        }
        return bg
    }
    
    public static var CELL_1 = { () -> UIColor in
        var bg = Constants.LIGHT_CELL_1
        switch(MODE){
        case .Dark:
            bg = Constants.DARK_CELL_1
        case .Light:
            bg = Constants.LIGHT_CELL_1
        }
        return bg
    }
    
}

enum ColorMode: Int, Codable {
    case Light = 0
    case Dark = 1
}
