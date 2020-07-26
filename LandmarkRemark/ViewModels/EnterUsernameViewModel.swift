//
//  EnterUsernameViewModel.swift
//  LandmarkRemark
//
//  Created by Michael Yuwono on 26/7/20.
//  Copyright © 2020 Michael Yuwono. All rights reserved.
//

import Foundation

class EnterUsernameViewModel: ObservableObject {
    
    let title = "Enter Username"
    
    @Published var username: String = ""
    
}
