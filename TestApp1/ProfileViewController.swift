//
//  ProfileViewController.swift
//  TestApp1
//
//  Created by Наталья Мирная on 07.08.2020.
//  Copyright © 2020 Наталья Мирная. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    var contact: Contact!
    weak var delegate: DetailViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.text = contact.name
        phoneTextField.text = contact.phone
        
        nameTextField.delegate = self
        phoneTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let _ = touches.first {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        saveChanges()
    }
    
    private func saveChanges() {
        contact.name = nameTextField.text ?? ""
        contact.phone = phoneTextField.text ?? ""
        
        delegate.update(contact)
        
        dismiss(animated: true)
    }
}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        view.endEditing(true)
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            saveChanges()
        }
        return true
    }
}
