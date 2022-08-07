//
//  APIService.swift
//  PostAndCommentsApp
//
//  Created by Sonam Mittal on 06/08/22.
//
import Foundation
struct APIService {
    var serviceLayer: ServiceLayer?

    func fetchPosts(completionHandler: @escaping ([Posts]?, Error?) -> Void) {
        let pathPosts = Constants.baseURL + Constants.endPointPosts
        serviceLayer?.fetch(path: pathPosts, completionHandler: { data, _, error in
            if let data = data {
                do {
                    let posts = try JSONDecoder().decode([Posts].self, from: data)
                    completionHandler(posts, nil)
                } catch {
                    completionHandler(nil, NSError(domain: "", code: 1, userInfo: nil))
                }

            } else {
                completionHandler(nil, error)
            }
        })
    }

    func fetchComments(postId: Int, completionHandler: @escaping ([Comments]?, Error?) -> Void) {
        let pathPosts = Constants.baseURL + Constants.endPointComments + "?postId=\(postId)"
        serviceLayer?.fetch(path: pathPosts, completionHandler: { data, _, error in
            if let data = data {
                do {
                    let comments = try JSONDecoder().decode([Comments].self, from: data)
                    completionHandler(comments, nil)
                } catch {
                    completionHandler(nil, NSError(domain: "", code: 1, userInfo: nil))
                }

            } else {
                completionHandler(nil, error)
            }
        })
    }
}
