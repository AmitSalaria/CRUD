//
//  AddContactViewModel.swift
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

protocol AddContactViewModelProtocol {
  var firstName: BehaviorRelay<String> { get set }
  var lastName: BehaviorRelay<String> { get set }
  var phoneNumber: BehaviorRelay<String> { get set }
  var address: BehaviorRelay<String> { get set }
  
  func save()
}

class AddContactViewModel: AddContactViewModelProtocol {
  
  // MARK:-  Variables
  private weak var delegate: AddContactViewControllerProtocol?
  private var contactDetails: ContactDetails?
  private var _contacts: Results<ContactDetails>? {
    guard let realm = try? Realm() else {
      return nil
    }
    
    return realm.objects(ContactDetails.self)
  }
  private var selectedIndex: Int? {
    contactDetails?.index
  }
  
  var firstName: BehaviorRelay<String>
  var lastName: BehaviorRelay<String>
  var phoneNumber: BehaviorRelay<String>
  var address: BehaviorRelay<String>
  
  // MARK:-  Init
  init(_ delegate: AddContactViewControllerProtocol, _ contactDetails: ContactDetails? = nil) {
    self.delegate = delegate
    self.contactDetails = contactDetails
    // Update data, If available
    firstName = BehaviorRelay(value: contactDetails?.firstName ?? "")
    lastName = BehaviorRelay(value: contactDetails?.lastName ?? "")
    phoneNumber = BehaviorRelay(value: contactDetails?.phoneNumber ?? "")
    address = BehaviorRelay(value: contactDetails?.address ?? "")
  }
  
  // MARK:-  Functions
  func save() {
    let (result, errorMessage) = validateData()
    if !result {
      delegate?.showAlert(with: errorMessage)
      return
    }
    
    saveDataToTheDataBase(isNew: contactDetails == nil)
  }
  
  // MARK:-  Private Functions
  private func validateData() -> (Bool, String) {
    if firstName.value.isEmpty {
      return (false, kErrorFirstNameIsEmpty)
    }
    
    if lastName.value.isEmpty {
      return (false, kErrorLastNameIsEmpty)
    }
    
    if phoneNumber.value.isEmpty {
      return (false, kErrorPhoneNumberIsEmpty)
    }
    
    return (true, "")
  }
  
  private func saveDataToTheDataBase(isNew: Bool) {
    // Get the default Realm
    guard let realm = try? Realm() else {
      delegate?.showAlert(with: kErrorUnableToLoadRealm)
      return
    }
    
    do {
      try realm.write {
        if isNew {
          add(realm)
        }else {
          update(realm)
        }
      }
      delegate?.didSaveDetails(with: kConfirmationMessage)
    } catch let error {
      delegate?.showAlert(with: error.localizedDescription)
      return
    }
    
  }
  
  private func add(_ realm: Realm) {
    let contactDetail = ContactDetails()
    contactDetail.firstName = firstName.value
    contactDetail.lastName = lastName.value
    contactDetail.phoneNumber = phoneNumber.value
    contactDetail.address = address.value
    contactDetail.index = _contacts?.count ?? 0
    realm.add(contactDetail)
  }
  
  private func update(_ realm: Realm) {
    if let index = selectedIndex {
      for contact in realm.objects(ContactDetails.self).filter("index == \(index)") {
        contact.firstName = firstName.value
        contact.lastName = lastName.value
        contact.phoneNumber = phoneNumber.value
        contact.address = address.value
      }
    }
  }
  
}

