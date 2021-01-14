//
//  WelcomeViewController.swift
//  Cook
//
//  Created by admin on 11.01.2021.
//

import UIKit
import Firebase
import AuthenticationServices

class WelcomeViewController: UIViewController {
  
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var signinSpaceView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupSignInButton()
  }
  
  @IBAction func loginPressed(_ sender: UIButton) {
    performSignInWithEmail()
  }
  
  @IBAction func registerPressed(_ sender: UIButton) {
    
//    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//    let vc = storyBoard.instantiateViewController(withIdentifier: "RegisterController")
//    navigationController?.pushViewController(vc, animated: true)
//    if let email = emailTextField.text, let password = passwordTextField.text {
//      Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//        if let err = error {
//          self.showAlert(with: "Error", and: err.localizedDescription)
//        } else {
//          let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//          let newViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarController")
//          self.view.window!.rootViewController = newViewController
//        }
//      }
//    }
  }
  
  func performSignInWithEmail() {
    if let email = emailTextField.text, let password = passwordTextField.text {
      Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
        if let _ = error {
          switch error {
          case .some(let error as NSError) where error.code == AuthErrorCode.wrongPassword.rawValue:
            Alert.showAlert(with: "Error", and: "Wrong password", sender: self)
          case .none:
            if let user = authResult?.user {
              print(user.uid)
            }
          case .some(let error):
            Alert.showAlert(with: "Error", and: error.localizedDescription, sender: self)
          }
        } else {
          let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
          let newViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarController")
          self.view.window!.rootViewController = newViewController
        }
      }
    }
  }
  
  func setupSignInButton() {
    let button = ASAuthorizationAppleIDButton()
    button.addTarget(self, action: #selector(handleSignInWithAppleTapped), for: .touchUpInside)
    button.center = signinSpaceView.center
    view.addSubview(button)
  }
  
  @objc func handleSignInWithAppleTapped() {
    performSignInWithApple()
  }
  
  func performSignInWithApple() {
    let request = createAppleIDRequest()
    let autorizationController = ASAuthorizationController(authorizationRequests: [request])
    
    autorizationController.delegate = self
    autorizationController.presentationContextProvider = self
    
    autorizationController.performRequests()
  }
  
  func createAppleIDRequest() -> ASAuthorizationAppleIDRequest {
    let appleIDProvider = ASAuthorizationAppleIDProvider()
    let request = appleIDProvider.createRequest()
    request.requestedScopes = [.fullName, .email]
    
    let nonce = randomNonceString()
    request.nonce = sha256(nonce)
    currentNonce = nonce
    
    return request
  }
}

extension WelcomeViewController: ASAuthorizationControllerDelegate {
  func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    
    if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
      guard let nonce = currentNonce else {
        fatalError("Invalid state: A login callback was recaived, but no login request was send")
      }
      guard let appleIDToken = appleIDCredential.identityToken else {
        print("Enable to fetch identity token")
        return
      }
      guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
        print("Unable to serialaze  token string ")
        return
      }
      
      let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
      
      Auth.auth().signIn(with: credential) { (authDataResult, error) in
        if let user = authDataResult?.user {
          print("Nice. You're now signed in as \(user.uid), email: \(user.email ?? "unknow")")
          let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
          let newViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarController")
          self.view.window!.rootViewController = newViewController
        }
      }
    }
    
  }
}

extension WelcomeViewController: ASAuthorizationControllerPresentationContextProviding {
  func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    return self.view.window!
  }
}

private func randomNonceString(length: Int = 32) -> String {
  precondition(length > 0)
  let charset: Array<Character> =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
  var result = ""
  var remainingLength = length
  
  while remainingLength > 0 {
    let randoms: [UInt8] = (0 ..< 16).map { _ in
      var random: UInt8 = 0
      let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
      if errorCode != errSecSuccess {
        fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
      }
      return random
    }
    
    randoms.forEach { random in
      if remainingLength == 0 {
        return
      }
      
      if random < charset.count {
        result.append(charset[Int(random)])
        remainingLength -= 1
      }
    }
  }
  
  return result
}

import CryptoKit

// Unhashed nonce.
fileprivate var currentNonce: String?

@available(iOS 13, *)
private func sha256(_ input: String) -> String {
  let inputData = Data(input.utf8)
  let hashedData = SHA256.hash(data: inputData)
  let hashString = hashedData.compactMap {
    return String(format: "%02x", $0)
  }.joined()
  
  return hashString
}


