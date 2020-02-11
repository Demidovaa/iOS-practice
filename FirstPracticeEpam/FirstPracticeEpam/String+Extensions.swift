//
//  String+Extensions.swift
//  FirstPracticeEpam
//
//  Created by Анастасия Демидова on 08.02.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
