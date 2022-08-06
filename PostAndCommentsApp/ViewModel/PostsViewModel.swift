//
//  PostsViewModel.swift
//  PostAndCommentsApp
//
//  Created by Sonam Mittal on 06/08/22.
//

import Foundation

class PostsViewModel : NSObject {
    
    private var apiHelper = APIService(serviceLayer: ServiceLayerImpl())
    private(set) var postData : [Posts]? {
        didSet {
            self.bindEmployeeViewModelToController()
        }
    }
    
    private(set) var searchedPosts : [Posts]? {
        didSet {
            self.bindEmployeeViewModelToController()
        }
    }
    
    var bindEmployeeViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        getPostsData()
    }
    
    func getPostsData() {
        
        apiHelper.fetchPosts { postData, err in
            self.postData = postData
        }
    }
    
    func getSearchedData(searchString: String) {
        if searchedPosts?.count ?? 0 > 0 {
            searchedPosts?.removeAll()
        }
        if searchString.isEmpty {
            self.searchedPosts = postData
        } else {
            self.searchedPosts = postData?.filter({ posts in
                posts.title.lowercased().contains(searchString.lowercased())
            })
        }
        
    }
}

