//
//  SceneDelegate.swift
//  Cook
//
//  Created by admin on 17.12.2020.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    var initialViewController: UIViewController
    
    if let user = Auth.auth().currentUser {
      print("You're sign in as \(user.uid)")
      initialViewController = storyboard.instantiateViewController(withIdentifier: "TabBarController")
    } else {
      initialViewController = storyboard.instantiateViewController(withIdentifier: "WelcomeViewController")
      
    }
    self.window?.rootViewController = initialViewController
    self.window?.makeKeyAndVisible()
    
    guard let _ = (scene as? UIWindowScene) else { return }
  }
  
  func sceneDidDisconnect(_ scene: UIScene) {
  }
  
  func sceneDidBecomeActive(_ scene: UIScene) {
  }
  
  func sceneWillResignActive(_ scene: UIScene) {
  }
  
  func sceneWillEnterForeground(_ scene: UIScene) {
  }
  
  func sceneDidEnterBackground(_ scene: UIScene) {
  }
  
}

