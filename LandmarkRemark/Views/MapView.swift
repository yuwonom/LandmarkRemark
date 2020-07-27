//
//  MapView.swift
//  LandmarkRemark
//
//  Created by Michael Yuwono on 26/7/20.
//  Copyright © 2020 Michael Yuwono. All rights reserved.
//

import MapKit
import Resolver
import SwiftUI

struct MapView: UIViewRepresentable {
    
    let locationManager: LocationManager = Resolver.resolve()
    
    @Binding var annotations: [MKPointAnnotation]
    
    init(annotations: Binding<[MKPointAnnotation]>) {
        self._annotations = annotations
    }

    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView(frame: UIScreen.main.bounds)
        map.showsUserLocation = true
        return map
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        // Refresh annotations
        view.removeAnnotations(view.annotations)
        view.addAnnotations(self.annotations)
        
        // Set map region callback when the first location is received
        self.locationManager.setOnFirstLocationUpdateHandler { (location) in
            guard let location = location else {
                return
            }
            
            let spanDelta = 0.1
            let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: spanDelta, longitudeDelta: spanDelta))
            view.setRegion(region, animated: true)
        }
    }
    
}

struct MapView_Previews: PreviewProvider {
    
    static var previews: some View {
        MapView(annotations: .constant([MKPointAnnotation]()))
    }
    
}
