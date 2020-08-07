//
//  ViewController.swift
//  TestApp1
//
//  Created by Наталья Мирная on 07.08.2020.
//  Copyright © 2020 Наталья Мирная. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    var contact: Contact!
    var indexPath: IndexPath!
    var updater: ((Contact, IndexPath) -> ())!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToProfileVC" {
            let profileVC = segue.destination as! ProfileViewController
            profileVC.contact = sender as? Contact
            profileVC.updater = { [unowned self] contact in
                self.contact = contact
                self.updateLabels()
                self.updater(self.contact, self.indexPath)
            }
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
