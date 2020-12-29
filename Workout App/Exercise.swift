//
//  Exercise.swift
//  Workout App
//
//  Created by Elliot Lee on 12/15/20.
//

import UIKit

/*
 An exercise will consist of some sets, it will have maximum rep weight volume stats, a type and a name
 */

class Exercise: NSObject, Codable {
    
    //MARK: INSTANCE VARS
    
    var name : String
    var sets : [Single_Set] = [Single_Set]()
    var volume : Double
    var type : ExerciseType
    
    //these values are the current max as updated
    var max_weight : Single_Set
    var max_reps : Single_Set
    var max_volume : Single_Set
    
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
    
    init(exercise :  Exercise, max_reps : Single_Set, max_weight :  Single_Set, max_volume : Single_Set){
        self.sets = [Single_Set]()
        self.name = exercise.name
        self.type = exercise.type
        
        for set in exercise.sets{
            print("\(exercise.name) \(set.is_complete)")
            sets.append(Single_Set(set))
        }
        
        //volume is sets*weight*reps
        volume = 0.0
        for set in sets {
            set.is_complete = false //set all the sets to incomplete
            volume += Double(set.reps) * set.weight
        }
        
        //init maxes from what is given
        self.max_reps = max_reps
        self.max_weight = max_weight
        self.max_volume = max_volume
        
    }
    
    init(exercise: Exercise){
        self.sets = [Single_Set]()
        self.name = exercise.name
        self.type = exercise.type
        
        for set in exercise.sets{
            sets.append(Single_Set(set))
        }
        
        //volume is sets*weight*reps
        volume = 0.0
        for set in sets {
            set.is_complete = false //set all the sets to incomplete
            volume += Double(set.reps) * set.weight
        }
        
        //init maxes from what is given
        self.max_reps = exercise.max_reps
        self.max_weight = exercise.max_weight
        self.max_volume = exercise.max_volume
    }
    
    //MARK: CALCULATIONS
    
    /*
     figure out how heavy and how many reps each set will be for this Exercise NEXT TIME
     first will be based on if all the sets were completed or not
     next the reps or weight will be incremented depending on the TYPE of exercise
     if the number of reps exceeds 24 for a rep incrementation, then reduce the rep range and increment weight
     @return the new Exercise
     */
    func compute_next() -> Exercise{
        let new_exercise = Exercise(exercise: self)
        
        var increment_flag = true
        for set in sets {
            if !set.is_complete{
                increment_flag = false
            }
        }
        
        guard increment_flag else {
            return new_exercise
        }
        
        for set in new_exercise.sets {
            //print("creating")
            switch new_exercise.type {
            case .Primary:
                set.weight += Constants.WEIGHT_INCREMENT()
            case .Secondary:
                set.weight += Constants.WEIGHT_INCREMENT()
            case .Compound:
                set.weight += Constants.WEIGHT_INCREMENT()
            case .Accessory:
                if(set.reps > Constants.ACCESSORY_MAX){
                    set.reps += Constants.REP_INCREMENT
                } else {
                    set.reps = Constants.ACCESSORY_RESET
                    set.weight += Constants.WEIGHT_INCREMENT() // or 5 if in lbs
                }
            case .Calisthenic:
                set.reps += 1
            case .Other:
                set.reps += 1
            }
        }
        
        return new_exercise
    }
}

//MARK: ENUM EXERCISE TYPE
/*
 Exercise tyoe makes it easier to keep track of the type of exercise. This will make incremental calculations easier,
 as they can be automated based on a type
 */
enum ExerciseType : Int, Codable {
    case Primary = 0
    case Secondary = 1
    case Compound = 2
    case Accessory = 3
    case Calisthenic = 4
    case Other = 5
}
