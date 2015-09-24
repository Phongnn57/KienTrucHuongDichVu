//
//  AddBookViewController.swift
//  LibraryManager
//
//  Created by Nguyen Nam Phong on 9/10/15.
//  Copyright (c) 2015 SkyDance. All rights reserved.
//

import UIKit

protocol AddBookViewControllerDelegate {
    func didFinishAddBook()
}

class AddBookViewController: BaseViewController, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var author: UITextField!
    @IBOutlet weak var publisher: UITextField!
    @IBOutlet weak var descriptions: UITextView!
    
    var saveBtn: UIBarButtonItem!
    var delegate: AddBookViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.saveBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: "save")
        self.navigationItem.rightBarButtonItem = self.saveBtn
        self.avatar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "choosePhoto:"))
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "hideKeyboard"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideKeyboard() {
        self.name.resignFirstResponder()
        self.author.resignFirstResponder()
        self.publisher.resignFirstResponder()
        self.descriptions.resignFirstResponder()
    }
    
    @IBAction func choosePhoto(sender: AnyObject) {
        let actionSheet = UIActionSheet(title: "Chọn ảnh đại diện", delegate: self, cancelButtonTitle: "Huỷ bỏ", destructiveButtonTitle: nil, otherButtonTitles: "Ảnh từ thư viện", "Chụp ảnh")
        actionSheet.showInView(self.view)
    }

    func save() {
        MRProgressOverlayView.showOverlayAddedTo(self.view, title: "Đang upload", mode: MRProgressOverlayViewMode.IndeterminateSmall, animated: true)
        BookAPI.addBook(self.name.text!, author: self.author.text, publisher: self.publisher.text, descriptions: self.descriptions.text, image: self.avatar.image, completion: { () -> Void in
            MRProgressOverlayView.dismissAllOverlaysForView(self.view, animated: true)
            self.delegate?.didFinishAddBook()
            self.navigationController?.popToRootViewControllerAnimated(true)
        }) { (error) -> Void in
            MRProgressOverlayView.dismissAllOverlaysForView(self.view, animated: true)
            self.view.makeToast(error, duration: 2, position: CSToastPositionTop)
        }
    }
    
    // MARK: ACTION SHEET
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        if buttonIndex == 1 {
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(imagePicker, animated: true, completion: nil)
        } else if buttonIndex == 2 {
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.avatar.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}