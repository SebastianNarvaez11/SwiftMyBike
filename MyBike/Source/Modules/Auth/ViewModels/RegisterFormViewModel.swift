//
//  RegisterFormViewModel.swift
//  MyBike
//
//  Created by Sebastian on 3/09/24.
//

import Foundation
import Combine

class RegisterFormViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    @Published var isEmailValid: Bool = false
    @Published var isPasswordValid: Bool = false
    @Published var isConfirmPasswordValid: Bool = false
    @Published var isPressedSubmit: Bool = false
    
    @Published var isValidForm: Bool = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        $email
            .receive(on: RunLoop.main)
            .map { email in
                return self.isValidEmail(email: email)
            }
            .assign(to: \.isEmailValid, on: self)
            .store(in: &cancellableSet)
        
        $password
            .receive(on: RunLoop.main)
            .map { password in
                return !password.isEmpty && password.count >= 6
            }
            .assign(to: \.isPasswordValid, on: self)
            .store(in: &cancellableSet)
        
        
        Publishers.CombineLatest($password, $confirmPassword)
            .receive(on: RunLoop.main)
            .map { (password1, password2) in
                return !password1.isEmpty && !password2.isEmpty && (password1 == password2)
            }
            .assign(to: \.isConfirmPasswordValid, on: self)
            .store(in: &cancellableSet)
        
        Publishers.CombineLatest3($isEmailValid, $isPasswordValid, $isConfirmPasswordValid)
            .receive(on: RunLoop.main)
            .map { isEmailValid, isPasswordValid, isConfirmPasswordValid in
                return  isEmailValid && isPasswordValid && isConfirmPasswordValid
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
