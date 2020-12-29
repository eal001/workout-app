//
//  Day.swift
//  Workout App
//
//  Created by Elliot Lee on 12/15/20.
//

import UIKit

/*
 Day will be a way to hold certain exercises for that day as well as a name and exact time
 */

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
    
    /*
     this is a special initialization method that creates a new day with exercises
     that have a linked list like reference to their previous exercise
     */
    init(_ day : Day, _ date : Date){
        self.name =  day.name
        self.is_rest = day.is_rest
        self.exercises = [Exercise]()
        
        for exercise in day.exercises{
            exercises.append(Exercise(exercise: exercise))
        }
        
        self.date = date
        self.dow = Calendar.current.component(.weekday, from: date)

    }
    
    init(_ day : Day){
        self.name =  day.name
        self.is_rest = day.is_rest
        self.exercises = [Exercise]()
        
        for exercise in day.exercises{
            exercises.append(exercise)
        }
        
        self.date = day.date
        self.dow = Calendar.current.component(.weekday, from: day.date)

    }
    
    //MARK: GET INFORMATION
    
    /*
     this funtion should return the string date of the this day's date
     the form "Thursday January 26, 2001"
     @return the string date
     */
    func get_day_str() -> String {
        return "\(name) : \(get_weekday_str())"
    }
    
    /*
     this function will return the dow (Day of week) value as a string .
     dow will only be the values from 1-7, 1== sunday, 7==saturday
     @return the string of the day that it is
     */
    func get_weekday_str() -> String {
        let week_str : String
        switch(dow){
        case 1:
            week_str = Constants.WEEKDAY_7
        case 2:
            week_str = Constants.WEEKDAY_1
        case 3:
            week_str = Constants.WEEKDAY_2
        case 4:
            week_str = Constants.WEEKDAY_3
        case 5:
            week_str = Constants.WEEKDAY_4
        case 6:
            week_str = Constants.WEEKDAY_5
        case 7:
            week_str = Constants.WEEKDAY_6
        default:
            week_str = Constants.NULL_STR
        }
        return week_str
    }
    
    func compute_next(day_offset: Int ) -> Day {
        
        var new_exercises = [Exercise]()
        for exercise in exercises{
            new_exercises.append(exercise.compute_next())
        }
        
        var components = DateComponents()
        components.year = Calendar.current.component(.year, from: date)
        components.month = Calendar.current.component(.month, from: date)
        components.day = Calendar.current.component(.day, from: date) + day_offset
        components.hour = Calendar.current.component(.hour, from: date)
        components.minute = Calendar.current.component(.minute, from: date)
        components.second = Calendar.current.component(.minute, from: date)
            
        let new_date = Calendar.current.date(from: components) ?? Date()
        
        return Day(self.name, new_date, self.is_rest, new_exercises)
        
    }
    
}
