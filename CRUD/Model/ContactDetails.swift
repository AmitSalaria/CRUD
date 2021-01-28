//
//  ContactDetail.swift
//

import Foundation
import RealmSwift

class ContactDetails: Object {
  @objc dynamic var firstName = ""
  @objc dynamic var lastName = ""
  @objc dynamic var phoneNumber = ""
  @objc dynamic var address: String? = nil
  @objc dynamic var index: Double = 0
}

