//
//  AddThoughtVC.swift
//  project-firebase
//
//  Created by Ivo Vošahlík on 19/11/2018.
//  Copyright © 2018 Ivo Vošahlík. All rights reserved.
//

import UIKit
import Firebase

class AddThoughtVC: UIViewController, UITextViewDelegate {
    
    // Outlets
    @IBOutlet private var sc_category: UISegmentedControl!
    @IBOutlet private var tf_username: UITextField!
    @IBOutlet private var tv_text: UITextView!
    @IBOutlet private var btn_post: UIButton!
    
    // Variables
    private var selectedCategory = CategoryEnum.funny.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tv_text.layer.cornerRadius = 4
        btn_post.layer.cornerRadius = 4
        tv_text.text = "Add text..."
        tv_text.textColor = UIColor.lightGray
        tv_text.delegate = self
    }
    
    // Delegate
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = UIColor.darkGray
    }
    
    // Action
    @IBAction func postBtn_action(_ sender: Any) {
        guard let username = tf_username.text else { return }
        Firestore.firestore().collection(TESTDB_REF).addDocument(data: [
            CATEGORY : selectedCategory,
            NUM_COMMENTS : 0,
            NUM_LIKES : 0,
            TEXT : tv_text.text,
            TIMESTAMP : FieldValue.serverTimestamp(),
            USERNAME : username
        ]) { (err) in
            if let err = err {
                debugPrint("Error adding document: \(err)")
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func categoryChange_action(_ sender: Any) {
        let index = sc_category.selectedSegmentIndex
        switch index {
        case 0:
            selectedCategory = CategoryEnum.funny.rawValue
        case 1:
            selectedCategory = CategoryEnum.serious.rawValue
        case 2:
            selectedCategory = CategoryEnum.crazy.rawValue
        default:
            selectedCategory = CategoryEnum.funny.rawValue
        }
    }
    
    

}
