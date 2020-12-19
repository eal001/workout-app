//
//  Cycle.swift
//  Workout App
//
//  Created by Elliot Lee on 12/15/20.
//

import UIKit

/*
 Cycle will have a start and end date, some days within it, it can calculate another (next)
 cycle based on the completion of this one
 */

class Cycle: NSObject, Codable {
    
    //MARK: INSTANCE VARS
    
    var start_date : Date
    var end_date : Date
    var days : [Day] = [Day]()
    
    //MARK: INITIALIZATION
    
    init(_ days : [Day]){
        self.days = days
        self.start_date = Date()
        self.end_date = Date()
        
        if days.count != 0 {
            start_date = days[0].date
            end_date = days[days.count-1].date
        }
    }
    
    //MARK: CREATE THE NEXT CYCLE
    
    /*
     similar to the exercise one, we will use this cycle to compute the next cycle
     the dates need to increment correctly to be in the future. Additonally the exercises within
     each day must increment as well
     @return the new Cycle
     */
    func compute_next() -> Cycle {
        return Cycle([Day]()) //make sure to remove this one
    }
    
}
