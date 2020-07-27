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
    @Published var keywords: String = ""
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init() {
        self.firestoreManager.$remarks.sink { (remarks) in
            self.loadAnnotations(remarks: remarks, keywords: self.keywords)
        }
        .store(in: &cancellables)
        
        self.$keywords.sink { (keywords) in
            self.loadAnnotations(remarks: self.firestoreManager.remarks, keywords: keywords)
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
    
    private func loadAnnotations(remarks: [Remark], keywords: String) {
        let group = DispatchGroup()
        var annotations = [MKPointAnnotation]();
        
        for remark in remarks {
            group.enter()
            firestoreManager.getUser(id: remark.userId) { (user) in
                guard let user = user else {
                    group.leave()
                    return
                }
                
                // Filter remarks being shown on the map based on keywords
                let showRemark = user.username.contains(self.keywords) || remark.notes.contains(self.keywords) || self.keywords.isEmpty
                if !showRemark {
                    group.leave()
                    return
                }
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: remark.coordinate.latitude, longitude: remark.coordinate.longitude)
                annotation.title = user.username
                annotation.subtitle = remark.notes
                annotations.append(annotation)
                
                group.leave()
            }
        }

        group.notify(queue: .main) {
            self.annotations = annotations;
        }
    }
}
