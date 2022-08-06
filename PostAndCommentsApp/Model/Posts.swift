//
//  Posts.swift
//  PostAndCommentsApp
//
//  Created by Sonam Mittal on 06/08/22.
//

import Foundation

struct Posts: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
