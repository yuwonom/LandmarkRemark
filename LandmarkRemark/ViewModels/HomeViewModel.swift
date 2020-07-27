//
//  HomeViewModel.swift
//  LandmarkRemark
//
//  Created by Michael Yuwono on 26/7/20.
//  Copyright © 2020 Michael Yuwono. All rights reserved.
//

import Combine
import Foundation
import MapKit
import Resolver

class HomeViewModel: ObservableObject {
    
    let title = "Landmark Remark"
    
    @Published var firestoreManager: FirestoreManager = Resolver.resolve()
    @Published var locationManager: LocationManager = Resolver.resolve()
    @Published var localStorageManager: LocalStorageManager = Resolver.resolve()
    
    @Published var annotations: [MKPointAnnotation] = [MKPointAnnotation]()
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init() {
        self.firestoreManager.$remarks.sink { (remarks) in
            self.loadAnnotations(remarks: remarks)
        }
        .store(in: &cancellables)
    }
    
    func loadUserId() {
        guard let userId = self.localStorageManager.getUserId() else {
            return
        }
        
        self.firestoreManager.getUser(id: userId) { (user) in
            self.firestoreManager.user = user
        }
    }
    
    func loadAnnotations(remarks: [Remark]) {
        for remark in remarks {
            firestoreManager.getUser(id: remark.userId) { (user) in
                guard let user = user else {
                    return
                }
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: remark.coordinate.latitude, longitude: remark.coordinate.longitude)
                annotation.title = user.username
                annotation.subtitle = remark.notes
                self.annotations.append(annotation)
            }
        }
    }
}
