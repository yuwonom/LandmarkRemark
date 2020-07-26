//
//  AddRemarkView.swift
//  LandmarkRemark
//
//  Created by Michael Yuwono on 26/7/20.
//  Copyright © 2020 Michael Yuwono. All rights reserved.
//

import MapKit
import SwiftUI

struct AddRemarkView: View {
    
    @ObservedObject var viewModel: AddRemarkViewModel
    
    @Binding var showAddRemarkView: Bool
    
    init(showAddRemarkView: Binding<Bool>, coordinate: CLLocationCoordinate2D) {
        self.viewModel = AddRemarkViewModel(coordinate: coordinate)
        self._showAddRemarkView = showAddRemarkView
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image(systemName: "pin")
                        .padding(.leading)
                    Text(viewModel.coordinateText)
                        .padding(.horizontal)
                    Spacer()
                }
                .padding(.vertical)
                Divider()
                HStack {
                    Text("Notes")
                        .padding(.leading)
                    TextField("notes", text: Binding<String>(
                        get: { self.viewModel.notes },
                        set: { self.viewModel.notes = $0}))
                        .padding(.leading)
                }
                .padding(.vertical)
                Spacer()
            }
            .padding()
            .navigationBarTitle(Text(viewModel.title), displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    self.showAddRemarkView = false
                }) {
                    Text("Cancel")
                },
                trailing: Button(action: {
                    self.viewModel.addRemark()
                }) {
                    Text("Create")
                })
        }
    }
    
}

struct AddRemarkView_Previews: PreviewProvider {
    
    static var previews: some View {
        AddRemarkView(showAddRemarkView: .constant(true), coordinate: CLLocationCoordinate2D())
    }
    
}
