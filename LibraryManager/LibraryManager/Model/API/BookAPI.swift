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
    class func getBookList(limit: Int, offset: Int, completion: (books: [BookObject]!)->Void, failure:(error: String)->Void) {
        var params: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
        params[AppConstant.API.KEYs.Action] = AppConstant.API.KEYs.Get_Books
        params[AppConstant.API.KEYs.Limit] = limit
        params[AppConstant.API.KEYs.Offset] = offset
        
        ModelManager.shareManager.postRequest(AppConstant.API.URLs.ApiUrl, params: params, success: { (responseData) -> Void in
            if let data: Array<AnyObject> = responseData as? Array<AnyObject> {
                var tmpArr: [BookObject] = []
                for eachObj in data {
                    let tmpBook = BookObject()
                    tmpBook.book_id = Utilities.numberFromJSONAnyObject(eachObj["id"])!.integerValue
                    tmpBook.book_name = eachObj["name"] as? String ?? ""
                    tmpBook.book_author = eachObj["author"] as? String ?? ""
                    tmpBook.book_publisher = eachObj["publisher"] as? String ?? ""
                    tmpBook.book_photoURL = eachObj["image"] as? String ?? ""
                    tmpArr.append(tmpBook)
                }
                completion(books: tmpArr)
            }
        }) { (errorMessage) -> Void in
            failure(error: errorMessage)
        }
        
    }
    
    // MARK: UPDATE BOOK
    class func updateBook(bookID: Int, name: String, author: String!, category: String!, publisher: String!, completion:()->Void, failure:(error: String)->Void) {
        var params: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
        params[AppConstant.API.KEYs.Action] = AppConstant.API.KEYs.Update_Book
        params[AppConstant.API.KEYs.Book_ID] = bookID
        params[AppConstant.API.KEYs.Book_Name] = name
        params[AppConstant.API.KEYs.Book_Author] = author
        params[AppConstant.API.KEYs.Book_Category] = category
        params[AppConstant.API.KEYs.Book_Publisher] = publisher
        
        ModelManager.shareManager.postRequest(AppConstant.API.URLs.ApiUrl, params: params, success: { (responseData) -> Void in
            completion()
            }) { (errorMessage) -> Void in
                failure(error: errorMessage)
        }
    }
    
    // MARK: DELETE BOOK
    class func deleteBook(bookID: Int, completion:()->Void, failure:(error: String)->Void) {
        var params: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
        params[AppConstant.API.KEYs.Action] = AppConstant.API.KEYs.Delete_Book
        params[AppConstant.API.KEYs.Book_ID] = bookID
        ModelManager.shareManager.postRequest(AppConstant.API.URLs.ApiUrl, params: params, success: { (responseData) -> Void in
            completion()
            }) { (errorMessage) -> Void in
                failure(error: errorMessage)
        }
    }
    
    // MARK: ADD BOOK
    class func addBook(name: String, author: String!, publisher: String!, descriptions: String!, image: UIImage!, completion: ()->Void, failure:(error: String)->Void) {
        
        ModelManager.shareManager.mainManager.POST(AppConstant.API.URLs.ApiUrl, parameters: nil, constructingBodyWithBlock: { (formData: AFMultipartFormData) -> Void in
            
            if image != nil {
                let tmpName = "\(NSDate().timeIntervalSince1970)" + ".jpg"
                formData.appendPartWithFileData(Utilities.convertImageToData(image), name: "fileToUpload", fileName: tmpName, mimeType: "image/jpeg")
            }
            formData.appendPartWithFormData(AppConstant.API.KEYs.Add_Book.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, name: AppConstant.API.KEYs.Action)
            formData.appendPartWithFormData(name.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, name: AppConstant.API.KEYs.Book_Name)
            formData.appendPartWithFormData(author.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, name: AppConstant.API.KEYs.Book_Author)
            formData.appendPartWithFormData(publisher.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, name: AppConstant.API.KEYs.Book_Publisher)
            formData.appendPartWithFormData(descriptions.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, name: AppConstant.API.KEYs.Book_Description)
            
            }, success: { (operation: AFHTTPRequestOperation, responseObject: AnyObject) -> Void in
                
                if !(responseObject is Dictionary<String, AnyObject>) {
                    failure(error: "Lỗi không xác định, vui lòng gọi tổng đài để được hỗ trợ.")
                    return
                }
                
                let responseData: Dictionary = responseObject as! Dictionary<String, AnyObject>
                print(responseData)
                var message = ""
                if(responseData["message"] != nil){
                    message = responseData["message"] as! String
                }
                
                if(responseData["status"] != nil && ((responseData["status"] as? Int) == 1 || (responseData["status"] as? String) == "1")){
//                    let contentData: AnyObject? = responseData["data"]
                    completion()
                    return
                }
                
                message = message.isEmpty ? "Lỗi không xác định, vui lòng gọi tổng đài để được hỗ trợ." : message
                failure(error: message)
                
            }) { (operation: AFHTTPRequestOperation, error: NSError) -> Void in
                print(error.description, terminator: "")
                if(error.code == 3840){
                    failure(error: "Lỗi 3840. Vui lòng gọi tổng đài để được hỗ trợ.")
                }else{
                    failure(error: "Không thể kết nối đến máy chủ, vui lòng kiểm tra lại đường truyền mạng!")
                }
        }

    }
}
