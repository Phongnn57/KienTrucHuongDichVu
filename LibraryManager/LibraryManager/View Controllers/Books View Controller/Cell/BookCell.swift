//
//  BookCell.swift
//  LibraryManager
//
//  Created by Nguyen Nam Phong on 9/11/15.
//  Copyright (c) 2015 SkyDance. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {


    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var author: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCellWithBook(book: BookObject) {
        var urlStr = AppConstant.API.URLs.BaseURl + book.book_photoURL!
        self.avatar.sd_setImageWithURL(NSURL(string: urlStr.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!), placeholderImage: UIImage(named: "default_avatar"))
        self.name.text = book.book_name
        self.author.text = book.book_author
        println(urlStr.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
    }
    
}
