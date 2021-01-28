//
//  AllContactListViewModel.swift
//

import Foundation
import RealmSwift
import RxSwift
import RxCocoa
import UIKit

protocol AllContactListViewModelProtocol {
  var contacts: [ContactDetails] { get }
  func deleteContact(at index: Int)
  func setUpTableView(_ tableView: UITableView)
}

class AllContactListViewModel: NSObject, AllContactListViewModelProtocol {
  
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

  // MARK:-  Init
  init(_ delegate: AllContactListViewController) {
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

  func setUpTableView(_ tableView: UITableView) {
    tableView.dataSource = self
    tableView.delegate = self
  }

}

// MARK:- UITableViewDataSource

extension AllContactListViewModel: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    contacts.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: kCell) ?? UITableViewCell()
    let contact = contacts[indexPath.row]
    cell.textLabel?.text = kName + contact.firstName + " " + contact.lastName
    cell.detailTextLabel?.text = kPhoneNumber + contact.phoneNumber
    return cell
  }

}

// MARK:- UITableViewDelegate

extension AllContactListViewModel: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    delegate?.showAddContactScreen(with: contacts[indexPath.row])
  }

  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    true
  }

  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    .delete
  }

  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    deleteContact(at: indexPath.row)
  }

}

