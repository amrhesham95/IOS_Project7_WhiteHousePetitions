//
//  Petition.swift
//  Project 7: Whitehouse Petitions(JSON)
//
//  Created by Amr Hesham on 1/8/20.
//  Copyright © 2020 Amr Hesham. All rights reserved.
//

import Foundation
struct Petition:Codable {
    var title:String
    var body:String
    var signatureCount:Int
}
