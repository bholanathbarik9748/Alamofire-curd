//
//  AlamofileModel.swift
//  almofire-crud
//
//  Created by Bholanath Barik on 03/08/24.
//

import Foundation

struct AlamofileModel: Identifiable, Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
