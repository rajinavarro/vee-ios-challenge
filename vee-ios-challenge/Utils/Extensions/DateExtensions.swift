//
//  DateExtensions.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 10/12/20.
//

import Foundation

extension Date {

    /// Gera um timestamp
    var currentTimeStamp: String {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"

        return (formatter.string(from: Date()) as NSString) as String
    }
}
