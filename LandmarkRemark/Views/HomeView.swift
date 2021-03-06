//
//  HomeView.swift
//  LandmarkRemark
//
//  Created by Michael Yuwono on 26/7/20.
//  Copyright © 2020 Michael Yuwono. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel = HomeViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    @State var addButtonDisabled: Bool = true
    @State var showEnterUsernameView: Bool = false
    @State var showAddRemarkView: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                MapView(annotations: self.$viewModel.annotations)
                if !self.viewModel.firestoreManager.remarks.isEmpty {
                    TextField("Keywords", text: Binding<String>(
                        get: { self.viewModel.keywords },
                        set: { self.viewModel.keywords = $0}))
                    .padding(.all)
                    .background(colorScheme == .dark ? Color.black : Color.white)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitle(Text(self.viewModel.title), displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: {
                    if self.viewModel.firestoreManager.user == nil {
                        self.showEnterUsernameView.toggle()
                    } else {
                        self.showAddRemarkView.toggle()
                    }
                }) {
                    Image(systemName: "plus")
                }
                .disabled(self.addButtonDisabled))
        }
        .background(EmptyView().sheet(isPresented: self.$showEnterUsernameView) {
            EnterUsernameView(showEnterUsernameView: self.$showEnterUsernameView, showAddRemarkView: self.$showAddRemarkView)
        })
        .background(EmptyView().sheet(isPresented: self.$showAddRemarkView) {
            AddRemarkView(showAddRemarkView: self.$showAddRemarkView, coordinate: self.viewModel.locationManager.location!.coordinate)
        })
        .onReceive(self.viewModel.locationManager.$location) { (location) in
            self.addButtonDisabled = location == nil
        }
        .onAppear {
            self.viewModel.loadUserId()
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeView()
    }
    
}
