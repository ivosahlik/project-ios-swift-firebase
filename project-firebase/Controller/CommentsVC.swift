//
//  CommentsVC.swift
//  project-firebase
//
//  Created by Ivo Vošahlík on 04/12/2018.
//  Copyright © 2018 Ivo Vošahlík. All rights reserved.
//

import UIKit

class CommentsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addCommentText: UITextField!
    @IBOutlet weak var keyboardView: UIView!
    
    
    // Variables
    var thought : Thought!
    var comments = [Comment]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        print(thought.text)
    }
    
    // Action
    @IBAction func addCommentAction(_ sender: Any) {
        getAlertOK(title: "Welcome to My application", message: "Hello World")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as? CommentCell {
            cell.configureCell(comment: comments[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    // This method get alert
    func getAlertOK(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        getLog(message: "The \"OK\" alert occured.")
        present(alertController, animated: true, completion: nil)
    }
    
    // This method get log
    func getLog(message: String) {
        NSLog(message)
    }
    

}


