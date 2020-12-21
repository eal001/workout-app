//
//  Single_Set.swift
//  Workout App
//
//  Created by Elliot Lee on 12/15/20.
//

import UIKit
/*
 Single set will be a class to hold the data of weight and rep amount of a set
 there will be an iscomplete method, that changes the set
 may change to a struct later
 */

class Single_Set: NSObject, Codable {
    
    //MARK: INSTANCE VARS
    
    var weight : Double
    var reps : Int
    var is_complete :  Bool
    
    //MARK: INITIALIZATION
    
    init(_ weight: Double, _ reps: Int) {
        self.weight = weight
        self.reps =  reps
        self.is_complete =  false
    }
    
    init(_ set : Single_Set){
        self.weight = set.weight
        self.reps = set.reps
        self.is_complete = set.is_complete
    }
    
    //MARK: COMPLETION METHODS
    
    //called when a set is marked as complete
    func complete(){
        is_complete = true
    }
    
    //called when a set is changed from complete to incomplete (all sets start as incomplete)
    func not_complete(){
        is_complete = false
    }
    
}
