//
//  ViewController.swift
//  PostAndCommentsApp
//
//  Created by Sonam Mittal on 06/08/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tblViewPosts: UITableView!
    private var postsViewModel : PostsViewModel!
    private var dataSource : PostTableViewDataSource<PostTableViewCell,Posts>!
    var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.delegate = self
        activityIndicator.bringSubviewToFront(self.view)
        activityIndicator.startAnimating()
        tblViewPosts.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "postCell")
        callToViewModelForUIUpdate()
    }
    func callToViewModelForUIUpdate(){
        
        self.postsViewModel =  PostsViewModel()
        self.postsViewModel.bindEmployeeViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
        var items = self.postsViewModel.postData
        if isSearching {
            items = self.postsViewModel.searchedPosts
        }
        self.dataSource = PostTableViewDataSource(cellIdentifier: "postCell", items: items ?? [], configureCell: { (cell, posts) in
            cell.lblTitle.text =  posts.title
            cell.lblBody.text = posts.body
        })
        
        DispatchQueue.main.async {
            self.tblViewPosts.dataSource = self.dataSource
            self.tblViewPosts.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = true
        postsViewModel.getSearchedData(searchString: searchText)
        }

         
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        updateDataSource()
    }

}








