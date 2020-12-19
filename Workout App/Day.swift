//
//  Day.swift
//  Workout App
//
//  Created by Elliot Lee on 12/15/20.
//

import UIKit

class Day: NSObject, Codable {
    
    //MARK: INSTANCE VARS
    
    var name : String
    var is_rest : Bool
    var dow : Int //(1-sunday, 7-saturday, same as calendar)
    var date : Date
    var exercises : [Exercise] = [Exercise]()
    
    //MARK: INITIALIZATION
    
    init(_ name : String, _ date : Date, _ is_rest : Bool, _ exercises: [Exercise]){
        self.name = name
        self.is_rest = is_rest
        self.exercises = exercises
        
        self.date = date
        
        self.dow = Calendar.current.component(.weekday, from: date)
    }
    
    init(_ day : Day, _ date : Date){
        self.name =  day.name
        self.is_rest = day.is_rest
        self.exercises = day.exercises
        
        self.date = date
        self.dow = Calendar.current.component(.weekday, from: date)

    }
    
    //MARK: GET INFORMATION
    
    /*
     this funtion should return the string date of the this day's date
     the form "Thursday January 26, 2001"
     @return the string date
     */
    func get_day_str() -> String {
        return ""
    }
    
    /*
     this function will return the dow (Day of week) value as a string .
     dow will only be the values from 1-7, 1== sunday, 7==saturday
     @return the string of the day that it is
     */
    func get_weekday_str() -> String {
        return ""
    }
    
}
