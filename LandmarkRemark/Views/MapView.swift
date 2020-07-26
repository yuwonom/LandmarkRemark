//
//  MapView.swift
//  LandmarkRemark
//
//  Created by Michael Yuwono on 26/7/20.
//  Copyright © 2020 Michael Yuwono. All rights reserved.
//

import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {

    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: UIScreen.main.bounds)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        
    }
    
}

struct MapView_Previews: PreviewProvider {
    
    static var previews: some View {
        MapView()
    }
    
}
