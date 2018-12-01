//
//  MainVC.swift
//  project-firebase
//
//  Created by Ivo Vošahlík on 19/11/2018.
//  Copyright © 2018 Ivo Vošahlík. All rights reserved.
//

import UIKit

enum CategoryEnum : String {
    case serious
    case funny
    case crazy
    case popular
}

class MainVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Outlets
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    @IBOutlet private weak var tableView: UITableView!
    
    // Variables
    private var thoughts = [Thought]()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
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
