//
//  BookObject.swift
//  LibraryManager
//
//  Created by Nguyen Nam Phong on 9/10/15.
//  Copyright (c) 2015 SkyDance. All rights reserved.
//

import UIKit

class BookObject {
    var book_id: Int = 0
    var book_name: String?
    var book_author: String?
    var book_publisher: String?
    var category: String?
    var book_photoURL: String?
    
    init() {
        self.book_id = 0
        self.book_name = ""
        self.book_author = ""
        self.book_publisher = ""
        self.category = ""
        self.book_photoURL = ""
    }
    
    init(name: String!, author: String!, publisher: String, category: String) {
        self.book_name = name
        self.book_author = author
        self.book_publisher = publisher
        self.category = category
    }
}