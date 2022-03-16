//
//  Course.swift
//  AssignmentSwiftUi
//
//  Created by karma on 3/16/22.
//

import Foundation
struct Course: Decodable, Hashable, Identifiable {
    let id: Int
    let name: String
    let link: String
    let imageUrl: String
    let numberOfLessons: Int
}
