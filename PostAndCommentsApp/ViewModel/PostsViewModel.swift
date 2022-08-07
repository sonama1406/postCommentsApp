//
//  PostsViewModel.swift
//  PostAndCommentsApp
//
//  Created by Sonam Mittal on 06/08/22.
//

import Foundation

class PostsViewModel: NSObject {
    private var apiHelper = APIService(serviceLayer: ServiceLayerImpl())
    private(set) var postData: [Posts]? {
        didSet {
            bindPostsViewModelToController()
        }
    }

    private(set) var searchedPosts: [Posts]? {
        didSet {
            bindPostsViewModelToController()
        }
    }

    private(set) var error: Error? {
        didSet {
            showError()
        }
    }

    var bindPostsViewModelToController: (() -> Void) = {}

    var showError: (() -> Void) = {}

    override init() {
        super.init()
        getPostsData()
    }

    private func getPostsData() {
        // get posts from server
        apiHelper.fetchPosts { postData, err in
            if err == nil {
                self.postData = postData
            } else {
                self.error = err
            }
        }
    }

    func getSearchedData(searchString: String) {
        if searchedPosts?.count ?? 0 > 0 {
            searchedPosts?.removeAll()
        }
        if searchString.isEmpty {
            searchedPosts = postData
        } else {
            searchedPosts = postData?.filter { posts in
                posts.title.lowercased().contains(searchString.lowercased())
            }
        }
    }
}
