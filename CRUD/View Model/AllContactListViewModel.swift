//
//  AllContactListViewModel.swift
//

import Foundation
import RealmSwift
import RxSwift
import RxCocoa

protocol AllContactListViewModelProtocol {
  var contacts: [ContactDetails] { get }
  
  func deleteContact(at index: Int)
}

class AllContactListViewModel: AllContactListViewModelProtocol {
  
  // MARK:-  Variables
  private weak var delegate: AllContactListViewControllerProtocol?
  private var _contacts: Results<ContactDetails>? {
    guard let realm = try? Realm() else {
      return nil
    }
    
    return realm.objects(ContactDetails.self)
  }
  
  var contacts: [ContactDetails] {
    get {
      _contacts?.toArray(ofType: ContactDetails.self) ?? []
    }
  }
  
  var dataSource: BehaviorRelay<[ContactDetails]> = BehaviorRelay(value: [])
  
  // MARK:-  Init
  init(_ delegate: AllContactListViewControllerProtocol) {
    self.delegate = delegate
  }
  
  // MARK:-  Functions
  func deleteContact(at index: Int) {
    guard let realm = try? Realm() else {
      delegate?.showAlert(with: kErrorUnableToLoadRealm)
      return
    }
    
    try! realm.write {
      realm.delete(contacts[index])
    }
    
    delegate?.reloadTableView()
    delegate?.showAlert(with: kDeletedMessage)
    
  }
  
  // MARK:-  Private Functions
  
}
