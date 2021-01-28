//
//  AppDependencyProvider.swift
//

import Swinject

class AppDependencyProvider {

  let container = Container()
  let assembler: Assembler

  init() {

    assembler = Assembler(
      [
        ViewModelAssembly(),
        ViewControllerAssembly()
      ],
      container: container
    )

  }

}
