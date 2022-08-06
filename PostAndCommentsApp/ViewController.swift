//
//  ViewController.swift
//  PostAndCommentsApp
//
//  Created by Sonam Mittal on 06/08/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tblViewPosts: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tblViewPosts.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "postCell")
    }


}

