//
//  CommentsVC.swift
//  project-firebase
//
//  Created by Ivo Vošahlík on 04/12/2018.
//  Copyright © 2018 Ivo Vošahlík. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class CommentsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addCommentText: UITextField!
    @IBOutlet weak var keyboardView: UIView!
    
    
    // Variables
    var thought : Thought!
    var comments = [Comment]()
    var thoughtRef : DocumentReference!
    var firestore = Firestore.firestore()
    var username: String!
    var commentListener : ListenerRegistration!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        thoughtRef = firestore.collection(TESTDB_REF).document(thought.documentId)
        if let name = Auth.auth().currentUser?.displayName {
            username = name
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        commentListener = Firestore.firestore().collection(TESTDB_REF).document(thought.documentId)
            .collection(COMMENT_REF).addSnapshotListener({ (snapshot, error) in
                guard let snapshot = snapshot else {
                    debugPrint("Error fetching comment: \(error!)")
                    return
                }
                self.comments.removeAll()
                self.comments = Comment.parseData(snapshot: snapshot)
                self.tableView.reloadData()
            })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        commentListener.remove()
    }
    
    // Action
    // This method add new comment
    @IBAction func addCommentAction(_ sender: Any) {
        // getAlertOK(title: "Welcome to My application", message: "Hello World")
        
        guard let commentTxt = addCommentText.text else {return}
        
        // Transaction
        firestore.runTransaction({ (transaction, error) -> Any? in
            
            let thoughtDocument: DocumentSnapshot
            
            print(self.thought.documentId)
            
            do {
                try thoughtDocument = transaction.getDocument(
                    self.firestore.collection(TESTDB_REF).document(self.thought.documentId)
                    
                )
            } catch let error as NSError {
                debugPrint("Fetch error \(error.localizedDescription)")
                return nil
            }
            
            print(thoughtDocument.data()?[NUM_COMMENTS] as! Int)
            
            guard let oldNumComments = thoughtDocument.data()?[NUM_COMMENTS] as? Int else { return nil}
            transaction.updateData([NUM_COMMENTS : oldNumComments + 1], forDocument: self.thoughtRef)
            
            let newNumComments = self.firestore.collection(TESTDB_REF).document(self.thought.documentId).collection(COMMENT_REF).document()
            
            transaction.setData(
                [
                    COMMENT_TXT : commentTxt,
                    TIMESTAMP : FieldValue.serverTimestamp(),
                    USERNAME : self.username,
                ],
                forDocument: newNumComments)
            
            return nil
        }) { (object, error) in
            if let error = error {
                debugPrint("Transaction failed: \(error)")
            } else {
                self.addCommentText.text = ""
            }
        }
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


