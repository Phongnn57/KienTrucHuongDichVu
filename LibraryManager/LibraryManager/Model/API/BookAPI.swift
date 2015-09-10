//
//  BookAPI.swift
//  LibraryManager
//
//  Created by Nguyen Nam Phong on 9/10/15.
//  Copyright (c) 2015 SkyDance. All rights reserved.
//

import UIKit

class BookAPI: NSObject {
   
    // MARK: GET LIST OF BOOK
    class func getBookList(page: Int, numOfBook: Int, completion: ()->Void, failure:(error: String)->Void) {
        var params: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
        params[AppConstant.API.KEYs.Page] = page
        params[AppConstant.API.KEYs.Number_Of_Book] = numOfBook
        
        
    }
    
    // MARK: UPDATE BOOK
    class func updateBook(bookID: Int, name: String, author: String!, category: String!, publisher: String!, completion:()->Void, failure:(error: String)->Void) {
        var params: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
        params[AppConstant.API.KEYs.Book_ID] = bookID
        params[AppConstant.API.KEYs.Book_Name] = name
        params[AppConstant.API.KEYs.Book_Author] = author
        params[AppConstant.API.KEYs.Book_Category] = category
        params[AppConstant.API.KEYs.Book_Publisher] = publisher
        
        
        
    }
    
    // MARK: DELETE BOOK
    class func deleteBook(bookID: Int, completion:()->Void, failure:(error: String)->Void) {
        var params: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
        params[AppConstant.API.KEYs.Book_ID] = bookID
        
    }
    
    // MARK: ADD BOOK
    class func addBook(name: String, author: String!, publisher: String!, category: String!, completion: ()->Void, failure:(error: String)->Void) {
        var params: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
        params[AppConstant.API.KEYs.Book_Name] = name
        params[AppConstant.API.KEYs.Book_Author] = author
        params[AppConstant.API.KEYs.Book_Publisher] = publisher
        params[AppConstant.API.KEYs.Book_Category] = category
        
        
    }
}
