//
//  AddRemarkViewModel.swift
//  LandmarkRemark
//
//  Created by Michael Yuwono on 26/7/20.
//  Copyright © 2020 Michael Yuwono. All rights reserved.
//

import FirebaseFirestore
import Foundation
import MapKit
import Resolver

class AddRemarkViewModel: ObservableObject {
    
    let title = "Add Remark"
    
    @Published var firestoreManager: FirestoreManager = Resolver.resolve()
    @Published var coordinateText: String = ""
    @Published var notes: String = ""
    @Published var isBusy: Bool = false
    @Published var addUserResult: Bool? = nil
    
    private var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.coordinateText = String(format: "%.5f", coordinate.latitude) + "º, " + String(format: "%.5f", coordinate.longitude) + "º"
    }
    
    func addRemark() {
        if (self.notes.isEmpty) {
            return
        }
        
        self.isBusy = true
        let coordinate = GeoPoint(latitude: self.coordinate.latitude, longitude: self.coordinate.longitude)
        self.firestoreManager.addRemark(notes: self.notes, coordinate: coordinate) { (result) in
            self.addUserResult = result
            self.isBusy = false
        }
    }
}
