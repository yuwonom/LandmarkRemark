//
//  EnterUsernameViewModel.swift
//  LandmarkRemark
//
//  Created by Michael Yuwono on 26/7/20.
//  Copyright © 2020 Michael Yuwono. All rights reserved.
//

import Foundation
import Resolver

class EnterUsernameViewModel: ObservableObject {
    
    let title = "Enter Username"
    
    @Published var firestoreManager: FirestoreManager = Resolver.resolve()
    @Published var username: String = ""
    @Published var isBusy: Bool = false
    @Published var addUserResult: Bool? = nil
    
    func setUsername() {
        if (self.username.isEmpty) {
            return
        }
        
        self.isBusy = true
        self.firestoreManager.addUser(username: self.username) { (user, result) in
            if let user = user {
                self.firestoreManager.user = user
            }
            self.addUserResult = result
            self.isBusy = false
        }
    }
    
}
