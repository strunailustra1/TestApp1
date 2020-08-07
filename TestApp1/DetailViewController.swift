//
//  ViewController.swift
//  TestApp1
//
//  Created by Наталья Мирная on 07.08.2020.
//  Copyright © 2020 Наталья Мирная. All rights reserved.
//

import UIKit

protocol DetailViewControllerDelegate: class {
    func update(_ contact: Contact)
}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    var contact: Contact!
    var indexPath: IndexPath!
    var delegate: ListViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToProfileVC" {
            let profileVC = segue.destination as! ProfileViewController
            profileVC.contact = sender as? Contact
            profileVC.delegate = self
        }
    }
    
    @IBAction func editButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goToProfileVC", sender: contact)
    }
    
    private func updateLabels() {
        nameLabel.text = contact.name
        phoneLabel.text = contact.phone
    }
}

extension DetailViewController: DetailViewControllerDelegate {
    func update(_ contact: Contact) {
        self.contact = contact
        updateLabels()
        delegate.update(contact: contact, indexPath: indexPath)
    }
}
