//
//  ContactDetail.swift
//  CRUD
//
//  Created by apple on 28/01/21.
//

import Foundation
import RealmSwift

class ContactDetails: Object {
  @objc dynamic var firstName = ""
  @objc dynamic var lastName = ""
  @objc dynamic var phoneNumber = ""
  @objc dynamic var address: String? = nil
}

