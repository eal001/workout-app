//
//  Single_Set.swift
//  Workout App
//
//  Created by Elliot Lee on 12/15/20.
//

import UIKit

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
    
    //MARK: SET COMPLETE METHOD
    
    func complete(){
        is_complete = true
    }
    
}
