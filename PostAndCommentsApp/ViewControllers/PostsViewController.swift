//
//  PostsViewController.swift
//  PostAndCommentsApp
//
//  Created by Sonam Mittal on 06/08/22.
//

import UIKit

class PostsViewController: UIViewController {
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var tblViewPosts: UITableView!
    private var postsViewModel: PostsViewModel?
    private var dataSource: PostAndCommentsTableViewDataSource<PostTableViewCell, Posts>?
    var isSearching: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.delegate = self
        tblViewPosts.delegate = self
        // register NIB of tableview
        tblViewPosts.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "postCell")
        callToViewModelForUIUpdate()
    }

    private func callToViewModelForUIUpdate() {
        postsViewModel = PostsViewModel()
        postsViewModel?.bindPostsViewModelToController = {
            self.updateDataSource()
        }
        postsViewModel?.showError = {
            DispatchQueue.main.async {
                self.showError()
                self.activityIndicator.stopAnimating()
            }
        }
    }

    private func showError() {
        let alert = UIAlertController(title: "", message: postsViewModel?.error?.localizedDescription, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        present(alert, animated: true)
    }

    private func updateDataSource() {
        var posts = postsViewModel?.postData
        if isSearching {
            posts = postsViewModel?.searchedPosts
        }
        dataSource = PostAndCommentsTableViewDataSource(cellIdentifier: "postCell", items: posts ?? [], configureCell: { cell, posts in
            cell.lblTitle.text = posts.title
            cell.lblBody.text = posts.body
        })

        DispatchQueue.main.async {
            self.tblViewPosts.dataSource = self.dataSource
            self.tblViewPosts.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
}

extension PostsViewController: UISearchBarDelegate {
    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        isSearching = true
        postsViewModel?.getSearchedData(searchString: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        updateDataSource()
        searchBar.endEditing(true)
    }
}

extension PostsViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        // navigate to comments view controller
        let commentsVC = storyboard?.instantiateViewController(withIdentifier: "CommentsViewController") as? CommentsViewController
        if isSearching {
            commentsVC?.postId = postsViewModel?.searchedPosts?[indexPath.row].id ?? 0
        } else {
            commentsVC?.postId = postsViewModel?.postData?[indexPath.row].id ?? 0
        }
        if let vc = commentsVC {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
