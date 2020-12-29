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
    public static let WEIGHT_INCREMENT = { () -> Double in
        if KILOS{
            return 2.5
        } else {
            return 5.0 * (1/K_TO_LB)
        }
    }
    public static let REP_INCREMENT = 4
    public static let ACCESSORY_MAX = 24
    public static let ACCESSORY_RESET = 12
    public static let EX_TYPE_COUNT = 6
    public static let COLOR_SCHEME_AMT = 8
    public static let K_TO_LB = 2.20462
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
    public static let SCHEME_KEY = "COLOR SCHEME KEY"
    public static let UNITS_KEY = "WEIGHT UNIT KEY"
    public static let SAVE_COLOR_ERR_MSG = "Error saving the desired colorscheme"
    public static let LOAD_COLOR_ERR_MSG = "Error loading the desired colorscheme"
    public static let SAVE_UNIT_ERR_MSG = "Error saving the desired units settings"
    public static let LOAD_UNIT_ERR_MSG = "Error loading the desired units settings"
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
    public static let WEIGHT_UNIT = { () -> String in
        if(KILOS){
            return "Kgs"
        } else {
            return "Lbs"
        }
    }
    
    public static var REP_UNIT = "Reps"
    public static let VOL_UNIT = { () -> String in
        if(KILOS){
            return "Kgs \(REP_UNIT)"
        } else {
            return "Lbs \(REP_UNIT)"
        }
    }
    public static let SET_TITLE = "Set"
    public static let WEIGHT_MSG = "Maximum Weight Set for"
    public static let REPS_MSG = "Maximum Rep Set for"
    public static let VOLUME_MSG = "Maximum Volume Set for"
    public static let FINISHED_TXT = "OK"
    
    public static let LIGHT_DEFAULT : UIImage = UIImage(named: "Light_default") ?? UIImage()
    public static let DARK_DEFAULT : UIImage = UIImage(named: "Dark_default") ?? UIImage()
    public static let LIGHT_RED : UIImage = UIImage(named: "Light_red") ?? UIImage()
    public static let DARK_RED : UIImage = UIImage(named: "Dark_red") ?? UIImage()
    public static let BEE : UIImage = UIImage(named: "Bee") ?? UIImage()
    public static let SHAN : UIImage = UIImage(named: "shan") ?? UIImage()
    public static let GONZO : UIImage = UIImage(named: "Gonzo") ?? UIImage()
    public static let AQUA : UIImage = UIImage(named: "Aqua") ?? UIImage()
    
    public static let LD_NAME = "Light Blue"
    public static let DD_NAME = "Dark Blue"
    public static let LR_NAME = "Light Red"
    public static let DR_NAME = "Dark Red"
    public static let B_NAME = "Bee"
    public static let S_NAME = "Shantelle"
    public static let G_NAME = "Gonzo"
    public static let A_NAME = "Aqua"
    
    //light mode colors
    public static let LIGHT_BACKGROUND = UIColor.white
    public static let LIGHT_SECTION = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
    public static let LIGHT_CELL_0 = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
    public static let LIGHT_CELL_1 = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
    public static let LIGHT_TEXT = UIColor.black
    public static let LIGHT_TINT = UIColor.systemBlue
    
    //dark mode colors
    public static let DARK_BACKGROUND = UIColor.black
    public static let DARK_SECTION = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1)
    public static let DARK_CELL_0 = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1)
    public static let DARK_CELL_1 = UIColor(red: 0.075, green: 0.075, blue: 0.075, alpha: 1)
    public static let DARK_TEXT = UIColor.white
    public static let DARK_TINT = UIColor.systemBlue
    
    //light mode colors
    public static let RLIGHT_BACKGROUND = UIColor.white
    public static let RLIGHT_SECTION = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
    public static let RLIGHT_CELL_0 = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
    public static let RLIGHT_CELL_1 = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
    public static let RLIGHT_TEXT = UIColor.black
    public static let RLIGHT_TINT = UIColor.systemRed
    
    //dark mode w/ red
    public static let RDARK_BACKGROUND = UIColor.black
    public static let RDARK_SECTION = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1)
    public static let RDARK_CELL_0 = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1)
    public static let RDARK_CELL_1 = UIColor(red: 0.075, green: 0.075, blue: 0.075, alpha: 1)
    public static let RDARK_TEXT = UIColor.white
    public static let RDARK_TINT = UIColor.systemRed
    
    //bee mode
    public static let BEE_BACKGROUND = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
    public static let BEE_SECTION = UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1)
    public static let BEE_CELL_0 = UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1)
    public static let BEE_CELL_1 = UIColor(red: 0.175, green: 0.175, blue: 0.175, alpha: 1)
    public static let BEE_TEXT = UIColor.yellow
    public static let BEE_TINT = UIColor.yellow
    
    //dark and green mode
    public static let SHAN_BACKGROUND = UIColor.black
    public static let SHAN_SECTION = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1)
    public static let SHAN_CELL_0 = UIColor(red: 0.05, green: 0.075, blue: 0.05, alpha: 1)
    public static let SHAN_CELL_1 = UIColor(red: 0.075, green: 0.1, blue: 0.075, alpha: 1)
    public static let SHAN_TEXT = UIColor.white
    public static let SHAN_TINT = UIColor.systemGreen
    
    //GONZO mode
    public static let GONZO_BACKGROUND = UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1)
    public static let GONZO_SECTION = UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1)
    public static let GONZO_CELL_0 = UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1)
    public static let GONZO_CELL_1 = UIColor.black
    public static let GONZO_TEXT = UIColor.systemRed
    public static let GONZO_TINT = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
    
    //aqua mode
    public static let AQUA_BACKGROUND = UIColor(red: 0.90, green: 0.90, blue: 0.99, alpha: 1)
    public static let AQUA_SECTION = UIColor(red: 0.85, green: 0.85, blue: 0.90, alpha: 1)
    public static let AQUA_CELL_0 = UIColor(red: 0.85, green: 0.85, blue: 0.90, alpha: 1)
    public static let AQUA_CELL_1 = UIColor(red: 0.80, green: 0.85, blue: 0.85, alpha: 1)
    public static let AQUA_TEXT = UIColor(red: 0.05, green: 0.15, blue: 0.15, alpha: 1)
    public static let AQUA_TINT = UIColor.systemGreen
    
    //MARK: - Global Variables
    
    //unit mode type: may change on a settings change
    public static var KILOS = true
    
    //color mode type:  may change on a settings change
    public static var MODE = ColorMode.Light
    
    public static let BACKGROUND = { () -> UIColor in
        var bg = Constants.LIGHT_BACKGROUND
        switch(MODE){
        case .Dark:
            bg = Constants.DARK_BACKGROUND
        case .Light:
            bg = Constants.LIGHT_BACKGROUND
        case .RLight:
            bg = Constants.RLIGHT_BACKGROUND
        case .RDark:
            bg = Constants.RDARK_BACKGROUND
        case .Bee:
            bg = Constants.BEE_BACKGROUND
        case .Shan:
            bg = Constants.SHAN_BACKGROUND
        case .Gonzo:
            bg = Constants.GONZO_BACKGROUND
        case .Aqua:
            bg = Constants.AQUA_BACKGROUND
        }
        return bg
    }
    
    public static let TEXT = { () -> UIColor in
        var t = Constants.LIGHT_TEXT
        switch(MODE){
        case .Dark:
            t = Constants.DARK_TEXT
        case .Light:
            t = Constants.LIGHT_TEXT
        case .RLight:
            t = Constants.RLIGHT_TEXT
        case .RDark:
            t = Constants.RDARK_TEXT
        case .Bee:
            t = Constants.BEE_TEXT
        case .Shan:
            t = Constants.SHAN_TEXT
        case .Gonzo:
            t = Constants.GONZO_TEXT
        case .Aqua:
        t = Constants.AQUA_TEXT
        }
        return t
    }
    
    public static let SECTION = { () -> UIColor in
        var s = Constants.LIGHT_SECTION
        switch(MODE){
        case .Dark:
            s = Constants.DARK_SECTION
        case .Light:
            s = Constants.LIGHT_SECTION
        case .RLight:
            s = Constants.RLIGHT_SECTION
        case .RDark:
            s = Constants.RDARK_SECTION
        case .Bee:
            s = Constants.BEE_SECTION
        case .Shan:
            s = Constants.SHAN_SECTION
        case .Gonzo:
            s = Constants.GONZO_SECTION
        case .Aqua:
            s = Constants.AQUA_SECTION
        }
        return s
    }
    
    public static let CELL_0 = { () -> UIColor in
        var c0 = Constants.LIGHT_CELL_0
        switch(MODE){
        case .Dark:
            c0 = Constants.DARK_CELL_0
        case .Light:
            c0 = Constants.LIGHT_CELL_0
        case .RLight:
            c0 = Constants.RLIGHT_CELL_0
        case .RDark:
            c0 = Constants.RDARK_CELL_0
        case .Bee:
            c0 = Constants.BEE_CELL_0
        case .Shan:
            c0 = Constants.SHAN_CELL_0
        case .Gonzo:
            c0 = Constants.GONZO_CELL_0
        case .Aqua:
            c0 = Constants.AQUA_CELL_0
        }
        return c0
    }
    
    public static let CELL_1 = { () -> UIColor in
        var c1 = Constants.LIGHT_CELL_1
        switch(MODE){
        case .Dark:
            c1 = Constants.DARK_CELL_1
        case .Light:
            c1 = Constants.LIGHT_CELL_1
        case .RLight:
            c1 = Constants.RLIGHT_CELL_1
        case .RDark:
            c1 = Constants.RDARK_CELL_1
        case .Bee:
            c1 = Constants.BEE_CELL_1
        case .Shan:
            c1 = Constants.SHAN_CELL_1
        case .Gonzo:
            c1 = Constants.GONZO_CELL_1
        case .Aqua:
            c1 = Constants.AQUA_CELL_1
        }
        return c1
    }
    
    public static let TINT = { ()-> UIColor in
        var t = Constants.LIGHT_TINT
        switch MODE {
        case .Dark:
            t = Constants.DARK_TINT
        case .Light:
            t = Constants.LIGHT_TINT
        case .RLight:
            t = Constants.RLIGHT_TINT
        case .RDark:
            t = Constants.RDARK_TINT
        case .Bee:
            t = Constants.BEE_TINT
        case .Shan:
            t = Constants.SHAN_TINT
        case .Gonzo:
            t = Constants.GONZO_TINT
        case .Aqua:
            t = Constants.AQUA_TINT
        }
        return t
        
    }
    
}

enum ColorMode: Int, Codable {
    case Light = 0
    case Dark = 1
    case RLight = 2
    case RDark = 3
    case Bee = 4
    case Shan = 5
    case Gonzo = 6
    case Aqua = 7
}
