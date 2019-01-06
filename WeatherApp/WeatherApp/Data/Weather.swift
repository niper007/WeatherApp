//
//  Weather.swift
//  WeatherApp
//
//  Created by Niklas Persson on 2018-12-25.
//  Copyright © 2018 Niklas Persson. All rights reserved.
//

import Foundation

struct Weather:Decodable{
    
    let title:String
    let location_type:String
   // let parent:[Content]
    let consolidated_weather:[Content_weather]
   // "time":"2018-12-25T10:40:11.182163Z",
   // "sun_rise":"2018-12-25T08:05:23.150608Z",
    //"sun_set":"2018-12-25T15:55:46.275523Z",
    let timezone_name:String
    //let location_type:String
    //let latt_long:(Double, ")51.506321,-0.12714",
    let timezone:String
    
    let sources:[Sources_Content]
    struct Content : Codable {
       
        let title: String
        let woeid:Int
    }
    
     struct Sources_Content : Codable {
        let title:String
        let slug: String
        let url:String
        let crawl_rate:Int
        
    }
    struct Content_weather : Codable {
        let id:Int
        let weather_state_name:String
        let weather_state_abbr:String
        let wind_direction_compass:String
       // "created":"2018-12-25T10:24:03.683344Z",
        //"applicable_date":"2018-12-25",
        let min_temp: Float
        let max_temp: Float
        let the_temp: Float
        let wind_speed: Float
        let wind_direction:Float
        let air_pressure:Float
        let humidity: Int
        let visibility:Double
        let predictability: Int
    }
}
