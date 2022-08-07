//
//  CommentsViewController.swift
//  PostAndCommentsApp
//
//  Created by Sonam Mittal on 07/08/22.
//

import UIKit

class CommentsViewController: UIViewController {
    public var postId: Int = 0
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var tblViewComments: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    private var commentsViewModel: CommentsViewModel?
    private var dataSource: PostAndCommentsTableViewDataSource<PostTableViewCell, Comments>?
    var isSearching: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.delegate = self
        // register NIB
        tblViewComments.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "postCell")
        callToViewModelForUIUpdate()
    }

    private func callToViewModelForUIUpdate() {
        commentsViewModel = CommentsViewModel(postId: postId)

        commentsViewModel?.bindCommentsViewModelToController = {
            self.updateDataSource()
        }
        commentsViewModel?.showError = {
            DispatchQueue.main.async {
                self.showError()
                self.activityIndicator.stopAnimating()
            }
        }
    }

    private func showError() {
        let alert = UIAlertController(title: "", message: commentsViewModel?.error?.localizedDescription, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        present(alert, animated: true)
    }

    @IBAction func btnBackAction(_: Any) {
        navigationController?.popViewController(animated: true)
    }

    private func updateDataSource() {
        var items = commentsViewModel?.comments
        if isSearching {
            items = commentsViewModel?.searchedComments
        }
        dataSource = PostAndCommentsTableViewDataSource(cellIdentifier: "postCell", items: items ?? [], configureCell: { cell, comment in
            cell.lblTitle.text = comment.name
            cell.lblBody.text = comment.body
        })

        DispatchQueue.main.async {
            self.tblViewComments.dataSource = self.dataSource
            self.tblViewComments.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
}

extension CommentsViewController: UISearchBarDelegate {
    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        isSearching = true
        commentsViewModel?.getSearchedData(searchString: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        updateDataSource()
        searchBar.endEditing(true)
    }
}
