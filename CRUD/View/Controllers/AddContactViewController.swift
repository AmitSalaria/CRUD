//
//  AddContactViewController.swift
//

import UIKit
import RxSwift
import RxCocoa

protocol AddContactViewControllerProtocol: class {
  func didSaveDetails(with confirmationMessage: String)
  func showAlert(with message: String)
}

class AddContactViewController: UIViewController {
  
  // MARK:- IBOutlets
  @IBOutlet weak var firstNameTextField: UITextField!
  @IBOutlet weak var lastNameTextField: UITextField!
  @IBOutlet weak var phoneNumberTextField: UITextField!
  @IBOutlet weak var addressTextField: UITextField!
  
  // MARK:- Variables
  var viewModel: AddContactViewModelProtocol!
  let disposeBag = DisposeBag()
  
  // MARK:- Class Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    bindViewModel()
  }
  
  // MARK:- IBActions
  @IBAction func saveButtonAction(_ sender: Any) {
    view.endEditing(true)
    viewModel.save()
  }
  
  // MARK:- Private Functions
  private func bindViewModel() {
    bind(firstNameTextField, with: viewModel.firstName)
    bind(lastNameTextField, with: viewModel.lastName)
    bind(phoneNumberTextField, with: viewModel.phoneNumber)
    bind(addressTextField, with: viewModel.address)
  }
  
  private func bind(_ textField: UITextField, with relay: BehaviorRelay<String>) {
    textField.text = relay.value
    textField.rx.text
      .orEmpty
      .bind(to: relay)
      .disposed(by: disposeBag)
  }
}

// MARK:- AddContactViewControllerProtocol

extension AddContactViewController: AddContactViewControllerProtocol {
  
  func didSaveDetails(with confirmationMessage: String) {
    showAlert(message: confirmationMessage) { _ in
      self.navigationController?.popViewController(animated: true)
    }
  }
  
  func showAlert(with message: String) {
    showAlert(message: message)
  }
  
}
