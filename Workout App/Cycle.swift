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
        self.days = [Day]()
        self.start_date = Date()
        self.end_date = Date()
        
        for day in days{
            self.days.append(day)
        }
        
        if days.count != 0 {
            start_date = days[0].date
            end_date = days[days.count-1].date
        }
    }
    
    func to_string() -> String {
        let sm = Calendar.current.component(.month, from: start_date)
        let sd = Calendar.current.component(.day, from: start_date)
        let sy = Calendar.current.component(.year, from: start_date)
        
        let em = Calendar.current.component(.month, from: end_date)
        let ed = Calendar.current.component(.day, from: end_date)
        let ey = Calendar.current.component(.year, from: end_date)
        
        return "\(sm)/\(sd)/\(sy) - \(em)/\(ed)/\(ey)"
    }
    
    //MARK: CREATE THE NEXT CYCLE
    
    /*
     similar to the exercise one, we will use this cycle to compute the next cycle
     the dates need to increment correctly to be in the future. Additonally the exercises within
     each day must increment as well
     @return the new Cycle
     */
    func compute_next(_ auto_progress : Bool ) -> Cycle {
        
        var new_days = [Day]()
        
        for day in days {
            new_days.append(day.compute_next(day_offset: days.count, auto_progress ) )
        }
        return Cycle(new_days) 
    }
    
    
    /*
     this function will be used to adjust the cycle when it is a hidden cycle stored when everything else is deleted
     it should only be called when a new cycle is created from nothing, it edits itself to represent today and the
     following days and then returns itself to also become the new first cycle
     */
    func adjust_to_current() -> Cycle {
        var date = Date()
        var components = DateComponents()
        var i = 0
        
        for day in days {
            if (i != 0) {
                components = DateComponents()
                components.year = Calendar.current.component(.year, from: date)
                components.month = Calendar.current.component(.month, from: date)
                components.day = Calendar.current.component(.day, from: date) + 1
                components.hour = Calendar.current.component(.hour, from: date)
                components.minute = Calendar.current.component(.minute, from: date)
                components.second = Calendar.current.component(.minute, from: date)
                date = Calendar.current.date(from: components) ?? Date()
            }
            
            days[i] = Day(day, date)
            
            i += 1
        }
        
        
        start_date = days[0].date
        end_date = days[days.count - 1].date
        
        return self
    }
    
}
