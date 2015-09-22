//
//  BooksViewController.swift
//  LibraryManager
//
//  Created by Nguyen Nam Phong on 9/10/15.
//  Copyright (c) 2015 SkyDance. All rights reserved.
//

import UIKit

class BooksViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, AddBookViewControllerDelegate {

    @IBOutlet weak var tableview: UITableView!
    var addbtn: UIBarButtonItem!
    
    let CellIdentifier = "BookCell"
    var books: [BookObject]!
    var refreshControl: UIRefreshControl!
    var isLoad: Bool = false
    var limit: Int = 20
    var offset: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configNavigationBarWithTitle("Danh sách")
        self.books = []
        self.tableview.registerNib(UINib(nibName: CellIdentifier, bundle: nil), forCellReuseIdentifier: CellIdentifier)
        self.addbtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addBook")
        self.navigationItem.rightBarButtonItem = self.addbtn
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
        self.tableview.addSubview(self.refreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addBook() {
        let addBook = AddBookViewController()
        addBook.delegate = self
        self.navigationController?.pushViewController(addBook, animated: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if !self.isLoad {
            MRProgressOverlayView.showOverlayAddedTo(self.view, title: "", mode: MRProgressOverlayViewMode.IndeterminateSmall, animated: true)
            self.loadData()
        }
    }
    
    func refreshData() {
        self.offset = 0
        self.loadData()
    }
    
    func loadData() {
        BookAPI.getBookList(self.limit, offset: self.offset, completion: { (books) -> Void in
            MRProgressOverlayView.dismissAllOverlaysForView(self.view, animated: true)
            self.refreshControl.endRefreshing()
            self.books = books
            self.tableview.reloadData()
            self.isLoad = true
            self.offset += self.limit
            }) { (error) -> Void in
                MRProgressOverlayView.dismissAllOverlaysForView(self.view, animated: true)
                self.refreshControl.endRefreshing()
                self.view.makeToast(error, duration: 2, position: CSToastPositionTop)
        }
    }
    
    // MARK: TABLEVIEW METHODS
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.books.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as! BookCell
        
        cell.configCellWithBook(self.books[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    // MARK: DELEGATE
    func didFinishAddBook() {
        self.refreshControl.beginRefreshing()
        self.offset = 0
        self.loadData()
    }
}
