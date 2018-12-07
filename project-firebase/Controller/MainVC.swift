//
//  MainVC.swift
//  project-firebase
//
//  Created by Ivo Vošahlík on 19/11/2018.
//  Copyright © 2018 Ivo Vošahlík. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class MainVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Outlets
    @IBOutlet weak var segmentControll: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    // Variables
    private var thoughts = [Thought]()
    private var thoughtsCollectionRef: CollectionReference!
    private var thoughtsListener: ListenerRegistration!
    private var selectedCategory = CategoryEnum.funny.rawValue
    private var handle: AuthStateDidChangeListenerHandle!
 
    // This method is called after the view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DEBUG 4")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        print("DEBUG 3")
        thoughtsCollectionRef = Firestore.firestore().collection(TESTDB_REF)
    }
    
    // This method is called before the view controller's
    override func viewWillAppear(_ animated: Bool) {
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginVc = storyboard.instantiateViewController(withIdentifier: "loginVC")
                self.present(loginVc, animated: true, completion: nil)
            } else {
                self.setListener()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if thoughtsListener != nil {
            thoughtsListener.remove()
        }
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
    
    // This method call logout user via alerts
    @IBAction func logoutTapped(_ sender: Any) {
        
        // let alertController = UIAlertController(title: "title", message: "Log Out?", preferredStyle: UIAlertController.Style.alert)
        let alertController = UIAlertController(title: "", message: "Are you sure you want to logout?", preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "Log Out", style: .destructive) { (action) in
            self.logout()
        }
        alertController.addAction(logoutAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            // TODO
        }
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // This method logout
    func logout() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signoutError as NSError {
            debugPrint("Error signing out: \(signoutError)")
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toComments", sender: thoughts[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toComments" {
            if let destinationVC = segue.destination as? CommentsVC {
                if let thought = sender as? Thought {
                    destinationVC.thought = thought
                }
            }
        }
    }
    
    
    
}
