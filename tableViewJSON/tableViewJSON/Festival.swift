//
//  Festival.swift
//  tableViewJSON
//
//  Created by Jonathan Kopp on 2/11/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import Foundation


struct City: Codable{
    let name: String?
    let id: String?
}

struct Participant: Codable{
    let name: String?
    let id: String?
}


struct Festival: Codable{
    let date: String?
    let name: String?
    let city: City
    let lineup: [Participant]?
    
}
