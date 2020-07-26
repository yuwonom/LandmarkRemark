//
//  AddRemarkViewModel.swift
//  LandmarkRemark
//
//  Created by Michael Yuwono on 26/7/20.
//  Copyright © 2020 Michael Yuwono. All rights reserved.
//

import Foundation

class AddRemarkViewModel: ObservableObject {
    
    let title = "Add Remark"
    
    @Published var coordinateText: String = ""
    @Published var notes: String = ""
}
