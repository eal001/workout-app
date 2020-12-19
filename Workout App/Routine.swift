//
//  Routine.swift
//  Workout App
//
//  Created by Elliot Lee on 12/15/20.
//

import UIKit

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
            print("Routine: unable to encode routine \"\(name)\"")
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
            print("Routine: Some data existed for \"\(key)\", but could not be decoded")
        } else {
            print("Routine: unable to get data for the key \"\(key)\"")
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
    let defaults = UserDefaults(suiteName: "com.elliotlee.workout-app")
}
