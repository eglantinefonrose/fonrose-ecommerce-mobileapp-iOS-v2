//
//  LogInViewModel.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine Fonrose on 24/12/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI
import Firebase
import AuthenticationServices

class LoginViewModel: ObservableObject {
    
    @EnvironmentObject var bigModel: BigModel
    @Published var mobileNo: String = ""
    @Published var otpCode: String = ""
    @Published var CLIENT_CODE: String = ""
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    let auth = Auth.auth()
    
    func getOTPCode() {
        UIApplication.shared.closeKeyboard()
        Task {
            do {
                Auth.auth().settings?.isAppVerificationDisabledForTesting = true
                let code = try await PhoneAuthProvider.provider().verifyPhoneNumber("+\(mobileNo)", uiDelegate: nil)
                
                await MainActor.run(body: {
                    CLIENT_CODE = code
                })
                
            } catch {
                await handleError(error: error)
            }
        }
    }
    
    func verifyOTPCode() {
        UIApplication.shared.closeKeyboard()
        Task {
            // do : si il n'y a pas d'erreur lors de l'appel de la fonction Auth.auth().signIn(with: credential)
            do {
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: CLIENT_CODE, verificationCode: otpCode)
                // try await dit au programme d'attendre la réponse de la fonction Auth.auth().signIn avant d'éxecuter la suite (print("Success !"))
                try await Auth.auth().signIn(with: credential)
                print("Success !")
            } catch {
                // catch : si il y a une erreur, les lignes suivantes sont executées
                await handleError(error: error)
                print(error.localizedDescription)
            }
        }
    }
    
    func handleError(error: Error)async {
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            print(errorMessage)
            showError.toggle()
        })
    }
}

func randomNonceString(length: Int = 32) -> String {
  precondition(length > 0)
  var randomBytes = [UInt8](repeating: 0, count: length)
  let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
  if errorCode != errSecSuccess {
    fatalError(
      "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
    )
  }

  let charset: [Character] =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

  let nonce = randomBytes.map { byte in
    // Pick a random character from the set, wrapping around if needed.
    charset[Int(byte) % charset.count]
  }

  return String(nonce)
}

extension UIApplication{
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
