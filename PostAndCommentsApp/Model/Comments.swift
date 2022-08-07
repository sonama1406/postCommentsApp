//
//  Comments.swift
//  PostAndCommentsApp
//
//  Created by Sonam Mittal on 06/08/22.
//

import Foundation
struct Comments: Codable {
    let postID, id: Int?
    let name, email, body: String?

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}
