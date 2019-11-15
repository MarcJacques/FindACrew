//
//  PersonSearchTableViewController.swift
//  FindACrew
//
//  Created by Marc Jacques on 11/13/19.
//  Copyright © 2019 Marc Jacques. All rights reserved.
//

import UIKit

class PersonSearchTableViewController: UITableViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    //Connect to modelViewController and initialize
    private let personController = PersonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return personController.people.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as? PersonTableViewCell else { return UITableViewCell() }
        // Configure the cell...
        let person = personController.people[indexPath.row]
        cell.person = person
        
        
        return cell
    }
}

extension PersonSearchTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        personController.searchForPeople(searchTerm: searchTerm) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
