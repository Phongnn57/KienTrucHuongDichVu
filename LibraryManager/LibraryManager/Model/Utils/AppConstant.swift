//
//  AppConstant.swift
//  LibraryManager
//
//  Created by Nguyen Nam Phong on 9/10/15.
//  Copyright (c) 2015 SkyDance. All rights reserved.
//

import UIKit

struct AppConstant {
    
    struct API {
        struct URLs {
            static let BaseURl: String = "http://128.199.167.255/phong/"
            static let ApiUrl: String = "api.php"
//            static let ImageUrl: String = ""
        }
        
        struct KEYs {
            static let Book_ID: String = "id"
            static let Book_Name: String = "name"
            static let Book_Author: String = "author"
            static let Book_Category: String = "category"
            static let Book_Publisher: String = "publisher"
            static let Book_Photo_URL: String = "image"
            static let Book_Description: String = "descriptions"
            
            static let Limit: String = "limit"
            static let Offset: String = "offset"
            static let Action: String = "action"
            
            static let Get_Books: String = "view_books"
            static let Update_Book: String = "update_book"
            static let Add_Book: String = "add_book"
            static let Delete_Book: String = "delete_book"
        }
        
        struct ResponseKeys {
            static let Response_Status: String = "status"
            static let Response_Message: String = "message"
            static let Response_Data: String = "data"
        }
    }
}
