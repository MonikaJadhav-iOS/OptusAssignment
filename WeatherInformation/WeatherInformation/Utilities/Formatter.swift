//
//  Formatter.swift
//  WeatherInformation
//
//  Created by Monika Jadhav on 16/12/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import Foundation

import Foundation

public struct Formatters {
    /// TimeZone for formatting
    public static let timeZone: TimeZone = {
        return TimeZone.current
    }()
    
    // MARK: Sunrise/Sunset
    public static let sunTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        formatter.timeZone = timeZone
        return formatter
    }()
    
    public struct Sunrise {
        public static func string(from value: Int , timeZone : Int) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm a"
            formatter.timeZone = TimeZone(secondsFromGMT : timeZone)!
            let date = Date(timeIntervalSince1970: TimeInterval(value))
            let localDate = formatter.string(from: date)
            return localDate
        }
    }
    
    // MARK: Weekday
    public struct Weekday {
        public static func string(from value: Int, timeZone : Int) -> String {
            let date = Date(timeIntervalSince1970: TimeInterval(value))
            let formatter = DateFormatter()
            formatter.dateFormat = "eee, hh:mm a"
            formatter.timeZone = TimeZone(secondsFromGMT : timeZone)!
            let localDate = formatter.string(from: date)
            return localDate
        }
    }
    
    // MARK: Time
    public struct Time {
        public static func string(from value: Int, timeZone : Int) -> String {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            formatter.timeZone = TimeZone(secondsFromGMT : timeZone)!
            
            let date = Date(timeIntervalSince1970: TimeInterval(value))
            let localDate = formatter.string(from: date)
            
            var hour = [String]()
            hour = localDate.components(separatedBy: ":")
            if Int(hour[0])! > 6 && Int(hour[0])! < 18 {
                return "TODAY"
            }else {
                return "TONIGHT"
            }
        }
    }
    
    // MARK: Temperature
    public struct Temp {
        public static func string(from value: Float) -> String {
            return "\(formatter.string(from: NSNumber(value:value))!)°"
        }
        
        public static func faraniteString(from value: Float) -> String {
            let faraniteTemperature = value * 1.8 + 32
            return "\(formatter.string(from: NSNumber(value:faraniteTemperature))!)°"
        }
        
        public static let formatter: NumberFormatter = {
            let nf = NumberFormatter()
            nf.numberStyle = .decimal
            nf.maximumFractionDigits = 0
            return nf
        }()
    }
    
    // MARK: Distance
    public struct Distance {
        public static func string(from meters: Float) -> String {
            return "\(formatter.string(from: NSNumber(value:meters))!)m"
        }
        
        public static let formatter: NumberFormatter = {
            let f = NumberFormatter()
            f.numberStyle = .decimal
            return f
        }()
    }
    
    // MARK: Percentage
    public struct Percentage {
        public static func string(from value: Float) -> String {
            return "\(formatter.string(from: NSNumber(value:value))!)%"
        }
        
        public static let formatter: NumberFormatter = {
            let f = NumberFormatter()
            f.numberStyle = .decimal
            f.maximumFractionDigits = 0
            return f
        }()
    }
    
    // MARK: Humidity
    public struct Humidity {
        public static func string(from value: Int) -> String {
            return "\(formatter.string(from: NSNumber(value:value))!)%"
        }
        
        public static let formatter: NumberFormatter = {
            let f = NumberFormatter()
            f.numberStyle = .decimal
            f.maximumFractionDigits = 0
            return f
        }()
    }
    
    // MARK: Visibility
    public struct Visibility {
        public static func string(from value: Int) -> String {
            let value =  Double(value) / 1000
            if value == 0.0 {
                return "NA"
            } else {
                return "\(value) Km"
            }
        }
    }
    
    // MARK: Rain Volume
    public struct RainVolume {
        public static func string(from value: Float) -> String {
            return "\(Percentage.formatter.string(from: NSNumber(value:value))!)mm"
        }
    }
    
    // MARK: Pressure
    public struct Pressure {
        public static func string(from value: Float) -> String {
            return "\(formatter.string(from: NSNumber(value:value))!) hPa"
        }
        
        public static let formatter: NumberFormatter = {
            let f = NumberFormatter()
            f.numberStyle = .decimal
            f.maximumFractionDigits = 0
            return f
        }()
    }
}
