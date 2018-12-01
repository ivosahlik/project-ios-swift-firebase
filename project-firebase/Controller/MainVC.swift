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
    @IBOutlet private weak var segmentControll: UISegmentedControl!
    @IBOutlet private weak var tableView: UITableView!
    
    // Variables
    private var thoughts = [Thought]()
    private var thoughtsCollectionRef: CollectionReference!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DEBUG 4")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        print("DEBUG 3")
        thoughtsCollectionRef = Firestore.firestore().collection(TESTDB_REF)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        thoughtsCollectionRef.getDocuments { (snapshot, error) in
            if let err = error {
                 print("DEBUG 2")
                print("Error fetching docs: \(err)")
            } else {
                print("DEBUG 1")
                for document in ((snapshot?.documents)!) {
                    print(document.data())
                }
            }
        }
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
