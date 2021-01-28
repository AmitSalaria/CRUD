//
//  AppDelegate.swift
//

import UIKit
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  let provider = AppDependencyProvider()

  var container: Container {
    provider.container
  }

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    // Instantiate a window.
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.makeKeyAndVisible()
    self.window = window

    // Instantiate the root view controller with dependencies injected by the container.
    window.rootViewController = UINavigationController(rootViewController: container.resolve(AllContactListViewController.self)!)

    return true
  }

}

