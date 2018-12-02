//
//  MainVC.swift
//  project-firebase
//
//  Created by Ivo Vošahlík on 19/11/2018.
//  Copyright © 2018 Ivo Vošahlík. All rights reserved.
//

import UIKit
import Firebase

class MainVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Outlets
    @IBOutlet weak var segmentControll: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    // Variables
    private var thoughts = [Thought]()
    private var thoughtsCollectionRef: CollectionReference!
    private var thoughtsListener: ListenerRegistration!
    private var selectedCategory = CategoryEnum.funny.rawValue
 
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
    
    // Action
    @IBAction func categoryChanged(_ sender: Any) {
        print("DEBUG: categoryChanged")
        let index = segmentControll.selectedSegmentIndex
        print("DEBUG: \(index)")
        switch index {
        case 0:
            selectedCategory = CategoryEnum.funny.rawValue
        case 1:
            selectedCategory = CategoryEnum.serious.rawValue
        case 2:
            selectedCategory = CategoryEnum.crazy.rawValue
        case 3:
            selectedCategory = CategoryEnum.popular.rawValue
        default:
            selectedCategory = CategoryEnum.funny.rawValue
        }
        
        thoughtsListener.remove()
        setListener()
    }
    
    func setListener() {
        
        print("Selected category: \(selectedCategory)")
        
        if selectedCategory == CategoryEnum.popular.rawValue {
            thoughtsListener = thoughtsCollectionRef
                .order(by: NUM_LIKES, descending: true)
                .addSnapshotListener{(snapshot, error) in
                    
                    if let err = error {
                        print("Error fetching docs: \(err)")
                    } else {
                        self.thoughts.removeAll()
                        self.thoughts = Thought.parseData(snapshot: snapshot)
                        self.tableView.reloadData()
                    }
            }
        } else {
            thoughtsListener = thoughtsCollectionRef
                .whereField(CATEGORY, isEqualTo: selectedCategory)
                .order(by: TIMESTAMP, descending: true)
                .addSnapshotListener{(snapshot, error) in
                    
                    if let err = error {
                        print("Error fetching docs: \(err)")
                    } else {
                        self.thoughts.removeAll()
                        self.thoughts = Thought.parseData(snapshot: snapshot)
                        self.tableView.reloadData()
                    }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setListener()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        thoughtsListener.remove()
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
