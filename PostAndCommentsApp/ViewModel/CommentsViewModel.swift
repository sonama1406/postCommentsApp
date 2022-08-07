//
//  CommentsViewModel.swift
//  PostAndCommentsApp
//
//  Created by Sonam Mittal on 07/08/22.
//

import Foundation
class CommentsViewModel: NSObject {
    private var apiHelper = APIService(serviceLayer: ServiceLayerImpl())
    public var postId: Int = 0
    private(set) var comments: [Comments]? {
        didSet {
            bindCommentsViewModelToController()
        }
    }

    private(set) var searchedComments: [Comments]? {
        didSet {
            bindCommentsViewModelToController()
        }
    }

    private(set) var error: Error? {
        didSet {
            showError()
        }
    }

    var bindCommentsViewModelToController: (() -> Void) = {}
    var showError: (() -> Void) = {}

    init(postId: Int) {
        super.init()
        self.postId = postId
        getCommentsData()
    }

    private func getCommentsData() {
        // get comments from server
        apiHelper.fetchComments(postId: postId, completionHandler: { comments, err in
            if err == nil {
                self.comments = comments
            } else {
                self.error = err
            }
        })
    }

    func getSearchedData(searchString: String) {
        if searchedComments?.count ?? 0 > 0 {
            searchedComments?.removeAll()
        }
        if searchString.isEmpty {
            searchedComments = comments
        } else {
            searchedComments = comments?.filter { comments in
                comments.name?.lowercased().contains(searchString.lowercased()) ?? false
            }
        }
    }
}
