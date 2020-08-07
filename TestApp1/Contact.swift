//
//  ContactList.swift
//  TestApp1
//
//  Created by Наталья Мирная on 07.08.2020.
//  Copyright © 2020 Наталья Мирная. All rights reserved.
//

import Foundation

struct Contact {
    var name: String
    var phone: String
}

class ContactBuilder {
  static let name = ["Lisa", "Alice", "John", "Peter"]
  static let phone = ["123456", "678912", "234567", "789123"]

    static func getContacts() -> [Contact] {
        var contacts: [Contact] = []
        
        for index in 0..<name.count {
            let contact = Contact(name: name[index], phone: phone[index])
            contacts.append(contact)
        }
        return contacts
    }
}


