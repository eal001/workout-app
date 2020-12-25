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
    
    //these values refer to the max sets as determined by PREVIOUS exercises of the same one
    //they will not update when this exercises sets are completed
    var prev_exercise : Exercise?
    
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
        
        //becasuse they are created from scratch in this init method, there is technically no previous maxes
        super.init()
        print("created new exercise \(name) as \(self)")
    }
    
    init(exercise :  Exercise, max_reps : inout Single_Set, max_weight : inout Single_Set, max_volume : inout Single_Set){
        self.sets = [Single_Set]()
        self.name = exercise.name
        self.type = exercise.type
        
        for set in exercise.sets{
            sets.append(set)
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
        
        //init previous maxes from what is goven as well
        self.prev_exercise = exercise
        print("created new exercise \(name) with previous property as \(prev_exercise)")
    }
    
    //MARK: CALCULATIONS
    
    /*
     look at all the completed sets, the one with the most reps is max_reps, the one with max_weight
     is max weight, and the (reps*weight) max volume is the max volume, just set the values do not return anything
     @param the previous exercise
     @return
     */
    func compute_maxes() -> (Single_Set, Single_Set, Single_Set){
        //TODO: figure out based on completed sets what the maximum stats for this exercise is
        max_reps = Single_Set(0,0)
        max_volume = Single_Set(0,0)
        max_weight = Single_Set(0,0)
        
        //base case: compare all completed sets and determine the the max set for this exercise
        guard prev_exercise != nil else {
            //we do not have a previous one to compare to
            for set in sets {
                if set.is_complete {
                    if(set.weight > max_weight.weight){
                        max_weight = set
                    }
                    if(set.reps > max_reps.reps){
                        max_reps = set
                    }
                    if( (Double(set.reps) * set.weight) > (Double(max_volume.reps) * max_volume.weight)){
                        max_volume = set
                    }
                }
            }
            //print("executed base max")
            return (max_weight, max_reps, max_volume)
        }
        
        //print("executed max")
        //recursive case: compare the max completed sets for this exercise to the maxes for the previous exercises
        
        //get the max exercises for this one
        for set in sets {
            if set.is_complete {
                if(set.weight > max_weight.weight){
                    max_weight = set
                }
                if(set.reps > max_reps.reps){
                    max_reps = set
                }
                if( (Double(set.reps) * set.weight) > (Double(max_volume.reps) * max_volume.weight)){
                    max_volume = set
                }
            }
        }
        
        let temp = prev_exercise!.compute_maxes()
        
        if(max_weight.weight < temp.0.weight){
            max_weight = temp.0
        }
        if(max_reps.reps < temp.1.reps){
            max_reps = temp.1
        }
        if((Double(max_reps.reps) * max_weight.weight) < (Double(temp.2.reps) * temp.2.weight) ){
            max_volume = temp.2
        }
        return (max_weight, max_reps, max_volume)
    }
    
    /*
     figure out how heavy and how many reps each set will be for this Exercise NEXT TIME
     first will be based on if all the sets were completed or not
     next the reps or weight will be incremented depending on the TYPE of exercise
     if the number of reps exceeds 24 for a rep incrementation, then reduce the rep range and increment weight
     @return the new Exercise
     */
    func compute_next() -> Exercise{
        let new_exercise = Exercise(exercise: self, max_reps: &max_reps,max_weight: &max_weight, max_volume: &max_volume)
        
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
            switch new_exercise.type {
            case .Primary:
                set.weight += Constants.WEIGHT_INCREMENT
            case .Secondary:
                set.weight += Constants.WEIGHT_INCREMENT
            case .Compound:
                set.weight += Constants.WEIGHT_INCREMENT
            case .Accessory:
                if(set.reps > Constants.ACCESSORY_MAX){
                    set.reps += Constants.REP_INCREMENT
                } else {
                    set.reps = Constants.ACCESSORY_RESET
                    set.weight += Constants.WEIGHT_INCREMENT // or 5 if in lbs
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
