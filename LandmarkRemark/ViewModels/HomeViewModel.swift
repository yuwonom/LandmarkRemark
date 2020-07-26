//
//  HomeViewModel.swift
//  LandmarkRemark
//
//  Created by Michael Yuwono on 26/7/20.
//  Copyright © 2020 Michael Yuwono. All rights reserved.
//

import Foundation
import Resolver

class HomeViewModel: ObservableObject {
    
    let title = "Landmark Remark"
    
    @Published var firestoreManager: FirestoreManager = Resolver.resolve()
    @Published var locationManager: LocationManager = Resolver.resolve()
}
