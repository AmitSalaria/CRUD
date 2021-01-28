//
//  ViewControllerAssembly.swift
//

import Swinject
import UIKit

class ViewControllerAssembly: Assembly {
  
  func assemble(container: Container) {
    
    container.register(AllContactListViewController.self) { resolver in
      let vc = UIStoryboard.storyboard(.main)
        .instantiateViewController(identifier: kAllContactListViewController) as! AllContactListViewController
      vc.resolver = resolver
      vc.viewModel = resolver.resolve(
        AllContactListViewModelProtocol.self,
        argument: vc
      )!
      return vc
    }
    
    container.register(AddContactViewController.self) { (
      resolver: Resolver,
      contactDetails: ContactDetails?
    ) in
      let vc = UIStoryboard.storyboard(.main)
        .instantiateViewController(identifier: kAddContactViewController) as! AddContactViewController
      vc.viewModel = resolver.resolve(
        AddContactViewModelProtocol.self,
        arguments: vc,
        contactDetails
      )!
      return vc
    }
    
  }
  
}
