//
//  LoginFormViewModel.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 9/11/24.
//

import Foundation
import Combine

class LoginFormViewModel: ObservableObject {
    @Published var email: String = "jhoan@gmail.com"
    @Published var password: String = "tatannvrz"
    @Published var isValidEmail: Bool = false
    @Published var isValidPassword: Bool = false
    @Published var isValidForm: Bool = false
    @Published var isSubmitPressed: Bool = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        $email
            .receive(on: RunLoop.main)
            .map { email in
                return self.isValidEmail(email: email)
            }
            .assign(to: \.isValidEmail, on: self)
            .store(in: &cancellableSet)
        
        $password
            .receive(on: RunLoop.main)
            .map { password in
                return !password.isEmpty
            }
            .assign(to: \.isValidPassword, on: self)
            .store(in: &cancellableSet)
        
        Publishers.CombineLatest($isValidEmail, $isValidPassword)
            .receive(on: RunLoop.main)
            .map { isValidEmail, isValidPassword in
                return isValidEmail && isValidPassword
            }
            .assign(to: \.isValidForm, on: self)
            .store(in: &cancellableSet)
    }
    
    private func isValidEmail(email: String) -> Bool {
        let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }
}
