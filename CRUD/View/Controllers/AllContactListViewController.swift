//
//  AllContactListViewController.swift
//

import UIKit
import Swinject

protocol AllContactListViewControllerProtocol: class {
  func showAlert(with message: String)
  func reloadTableView()
  func showAddContactScreen(with contactDetails: ContactDetails?)
}

class AllContactListViewController: UIViewController {
  
  // MARK:- IBOutlets
  @IBOutlet weak var listTableView: UITableView!
  
  // MARK:- Variables
  var resolver: Resolver!
  var viewModel: AllContactListViewModelProtocol!
  
  // MARK:- Class Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.setUpTableView(listTableView)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    reloadTableView()
  }
  
  // MARK:- IBActions
  @IBAction func addButtonAction(_ sender: Any) {
    showAddContactScreen(with: nil)
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
  
  func showAddContactScreen(with contactDetails: ContactDetails?) {
    let vc = resolver.resolve(
      AddContactViewController.self,
      argument: contactDetails
    )!
    navigationController?.pushViewController(vc, animated: true)
  }
  
}
