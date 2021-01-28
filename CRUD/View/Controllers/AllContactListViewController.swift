//
//  AllContactListViewController.swift
//

import UIKit
import Swinject
import RxSwift
import RxCocoa

protocol AllContactListViewControllerProtocol: class {
  func showAlert(with message: String)
  func reloadTableView()
}

class AllContactListViewController: UIViewController {
  
  // MARK:- IBOutlets
  @IBOutlet weak var listTableView: UITableView!
  
  // MARK:- Variables
  var resolver: Resolver!
  var viewModel: AllContactListViewModelProtocol!
  let disposeBag = DisposeBag()
  
  // MARK:- Class Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    reloadTableView()
  }
  
  // MARK:- IBActions
  @IBAction func addButtonAction(_ sender: Any) {
    let vc = resolver.resolve(
      AddContactViewController.self,
      argument: nil as ContactDetails?
    )!
    navigationController?.pushViewController(vc, animated: true)
  }
  
}

// MARK:- UITableViewDataSource

extension AllContactListViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.contacts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: kCell) ?? UITableViewCell()
    let contact = viewModel.contacts[indexPath.row]
    cell.textLabel?.text = contact.firstName + " " + contact.lastName
    cell.detailTextLabel?.text = contact.phoneNumber
    return cell
  }
  
}

// MARK:- UITableViewDelegate

extension AllContactListViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = resolver.resolve(
      AddContactViewController.self,
      argument: self.viewModel.contacts[indexPath.row] as ContactDetails?
    )!
    navigationController?.pushViewController(vc, animated: true)
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    true
  }
  
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    .delete
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    self.viewModel.deleteContact(at: indexPath.row)
  }
  
}

// MARK:- AllContactListViewControllerProtocol

extension AllContactListViewController: AllContactListViewControllerProtocol {
  
  func showAlert(with message: String) {
    showAlert(message: message)
  }
  
  func reloadTableView() {
    listTableView.reloadData()
  }
  
}
