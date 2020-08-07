//
//  ListViewController.swift
//  TestApp1
//
//  Created by Наталья Мирная on 07.08.2020.
//  Copyright © 2020 Наталья Мирная. All rights reserved.
//

import UIKit

protocol ListViewControllerDelegate: class {
    func update(contact: Contact, indexPath: IndexPath)
}

class ListViewController: UITableViewController {
    
    private var contactList: [Contact] = []
    private var indexPathReload: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactList = ContactBuilder.getContacts()
    }
    
    override func viewDidLayoutSubviews() {
        // fix: - UITableView was told to layout its visible cells and other contents without being in the view hierarchy
        guard let indexPath = indexPathReload else { return }
        tableView.reloadRows(at: [indexPath], with: .automatic)
        indexPathReload = nil
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contactList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        cell.textLabel?.text = contactList[indexPath.row].name
        cell.detailTextLabel?.text = contactList[indexPath.row].phone
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contactList[indexPath.row]
        performSegue(withIdentifier: "goToDetailVC", sender: (contact, indexPath))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailVC" {
            let detailVC = segue.destination as! DetailViewController
            let tuple = sender as! (Contact, IndexPath)
            detailVC.contact = tuple.0
            detailVC.indexPath = tuple.1
            detailVC.delegate = self
        }
    }
}

extension ListViewController: ListViewControllerDelegate {
    func update(contact: Contact, indexPath: IndexPath) {
        contactList[indexPath.row] = contact
        indexPathReload = indexPath
    }
}
