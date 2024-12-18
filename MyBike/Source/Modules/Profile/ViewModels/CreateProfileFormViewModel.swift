//
//  CreateProfileFormViewModel.swift
//  MyBike
//
//  Created by Sebastian on 3/09/24.
//

import Foundation
import Combine

class CreateProfileFormViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var photo: String = ""
    
    @Published var isNameValid: Bool = false
    @Published var isPressedSubmit: Bool = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        $name
            .receive(on: RunLoop.main)
            .map { name in
                return !name.isEmpty && name.count >= 3
            }
            .assign(to: \.isNameValid, on: self)
            .store(in: &cancellableSet)
    }
}
