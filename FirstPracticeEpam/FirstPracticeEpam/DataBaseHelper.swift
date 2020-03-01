//
//  UserDefaults.swift
//  FirstPracticeEpam
//
//  Created by Анастасия Демидова on 08.02.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

//MARK: NSUserDefaults

import Foundation

class DataBaseHelper {
    static func save(object: Int, for key: String) {
        UserDefaults.standard.set(object, forKey: key)
    }
    
    static func getObject(for key: String) -> Any? {
        return UserDefaults.standard.value(forKey: key)
    }
}
