//
//  Exercise.swift
//  Workout App
//
//  Created by Elliot Lee on 12/15/20.
//

import UIKit

class Exercise: NSObject, Codable {
    
    //MARK: INSTANCE VARS
    
    var name : String
    var sets : [Single_Set] = [Single_Set]()
    var max_weight : Single_Set
    var max_reps : Single_Set
    var max_volume : Single_Set
    var volume : Double
    var type : ExerciseType
    
    //MARK: INITIALIZATION
    
    init(_ name:  String, _ type : ExerciseType, _ sets: [Single_Set]){
        self.sets = sets
        self.name =  name
        self.type = type
        
        //volume is sets*weight*reps
        volume = 0.0
        for set in sets {
            volume += Double(set.reps) * set.weight
        }
        
        //maxes are not initialied because theyre not complete yet
        max_reps = Single_Set(0,0)
        max_weight = Single_Set(0,0)
        max_volume = Single_Set(0,0)
    }
    
    //MARK: CALCULATIONS
    
    /*
     look at all the completed sets, the one with the most reps is max_reps, the one with max_weight
     is max weight, and the (reps*weight) max volume is the max volume, just set the values do not return anything
     */
    func compute_maxes(){
        
    }
    
    /*
     figure out how heavy and how many reps each set will be for this Exercise NEXT TIME
     first will be based on if all the sets were completed or not
     next the reps or weight will be incremented depending on the TYPE of exercise
     if the number of reps exceeds 24 for a rep incrementation, then reduce the rep range and increment weight
     @return the new Exercise
     */
    func compute_next() -> Exercise{
        return self //TODO: change this and remove the return self
    }
}

//MARK: ENUM EXERCISE TYPE

enum ExerciseType : Int, Codable {
    case Primary = 0
    case Secondary = 1
    case Compound = 2
    case Accessory = 3
    case Calisthenic = 4
    case Other = 5
}
