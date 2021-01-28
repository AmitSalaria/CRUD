//
//  ViewModelAssembly.swift
//

import Swinject

class ViewModelAssembly: Assembly {
  
  func assemble(container: Container) {
    
    container.register(AllContactListViewModelProtocol.self) { (
      resolver: Resolver,
      delegate: AllContactListViewController
    ) -> AllContactListViewModelProtocol in
      AllContactListViewModel(delegate)
    }
    
    container.register(AddContactViewModelProtocol.self) { (
      resolver: Resolver,
      delegate: AddContactViewController,
      contactDetails: ContactDetails?
    ) -> AddContactViewModelProtocol in
      AddContactViewModel(delegate, contactDetails)
    }
    
  }
  
}
