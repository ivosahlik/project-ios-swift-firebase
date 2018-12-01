//
//  MainVC.swift
//  project-firebase
//
//  Created by Ivo Vošahlík on 19/11/2018.
//  Copyright © 2018 Ivo Vošahlík. All rights reserved.
//

import UIKit
import Firebase

enum CategoryEnum : String {
    case serious
    case funny
    case crazy
    case popular
}

class MainVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Outlets
    @IBOutlet weak var segmentControll: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    // Variables
    private var thoughts = [Thought]()
    private var thoughtsCollectionRef: CollectionReference!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DEBUG 4")
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.rowHeight = UITableView.automaticDimension
        //tableView.estimatedRowHeight = 80
        print("DEBUG 3")
        thoughtsCollectionRef = Firestore.firestore().collection(TESTDB_REF)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        thoughtsCollectionRef.addSnapshotListener{(snapshot, error) in
            if let err = error {
                print("Error fetching docs: \(err)")
            } else {
                self.thoughts.removeAll()
                guard let snap = snapshot else {return}
                for document in snap.documents {
                    let data = document.data()
                    let username = data["username"] as? String ?? "Anonymous"
                    let text = data["text"] as? String ?? ""
                    let timestamp = data["timestamp"] as? Date ?? Date()
                    let numLikes = data["numLikes"] as? Int ?? 0
                    let numComments = data["numComments"] as? Int ?? 0
                    let documentId = document.documentID
                    let newThought = Thought(username: username, timestamp: timestamp, text: text, numLikes: numLikes, numComments:numComments, documentId: documentId)
                    self.thoughts.append(newThought)
                }
                self.tableView.reloadData()
            }
        }
    
        
//        thoughtsCollectionRef.getDocuments { (snapshot, error) in
//            if let err = error {
//                 print("DEBUG 2")
//                print("Error fetching docs: \(err)")
//            } else {
//                print("DEBUG 1")
//                guard let snap = snapshot else {return}
//                for document in snap.documents {
//                    //print(document.data())
//                    let data = document.data()
//                    let username = data["username"] as? String ?? "Anonymous"
//                    print(username)
//
//                    let timestamp = data["timestamp"] as? Date ?? Date()
//                    let formatter = DateFormatter()
//                    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//                    let timestampFormat = formatter.string(from: timestamp)
//                    print(timestampFormat)
//
//                    let text = data["text"] as? String ?? ""
//                    print(text)
//
//                    let numLikes = data["numLikes"] as? Int ?? 0
//                    let numComments = data["numComments"] as? Int ?? 0
//
//                    let category = data["category"] as? String ?? "crazy"
//                    let documentId = document.documentID
//                    print("DocumentID: \(documentId)")
//
//                    let newThought = Thought(username: username, timestamp: timestamp, text: text, numLikes: numLikes, numComments:numComments, documentId: documentId)
//                    self.thoughts.append(newThought)
//                }
//                self.tableView.reloadData()
//            }
//        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thoughts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "thoughtCell", for: indexPath) as? ThoughtCell {
            cell.configureCell(thought: thoughts[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    
    
}
