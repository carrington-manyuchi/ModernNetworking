//
//  UserData.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/12.
//

import Foundation

struct UserData {
    var selectedEmployee: Employee?
    var dateOfBirth: Date = Date()
    var placeOfBirth: String = ""
    var gender: Gender = .male
    var preferredColor: String = "#000000"
    var residentialAddress: String = ""
}

enum Gender: String, CaseIterable {
    case male = "Male"
    case female = "Female"
    case other = "Other"
}
