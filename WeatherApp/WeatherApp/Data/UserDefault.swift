//
//  UserDefault.swift
//  WeatherApp
//
//  Created by Niklas Persson on 2019-01-06.
//  Copyright © 2019 Niklas Persson. All rights reserved.
//

import Foundation

class UserDefault {
    
    let TITLE = "title"
    let WOEID = "woied"
    
    func setValues(title:String,woeid:Int) {
        let defaults = UserDefaults.standard
        defaults.setValue(title, forKey: TITLE)
        defaults.setValue(woeid, forKey: WOEID)
        defaults.synchronize()
    }

    func getValues()-> (String, Int) {
        let defaults = UserDefaults.standard
        let title:String = defaults.value(forKey: TITLE) as! String
        let woeid:Int = defaults.value(forKey: WOEID) as! Int
        return (title,woeid)
    }
    
    func userAlreadyExist() -> Bool {
        return UserDefaults.standard.object(forKey: TITLE) != nil && UserDefaults.standard.object(forKey: WOEID) != nil
    }

    func removeValues(){
        let defaults = UserDefaults.standard
        defaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        defaults.synchronize()
    }
}

