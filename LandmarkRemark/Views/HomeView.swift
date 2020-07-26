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
    
    @State var showEnterUsernameView: Bool = false
    
    var body: some View {
        NavigationView {
            MapView()
                .edgesIgnoringSafeArea(.bottom)
                .navigationBarTitle(Text(self.viewModel.title), displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: {
                    self.showEnterUsernameView.toggle()
                }) {
                    Image(systemName: "plus")
                })
        }
        .sheet(isPresented: self.$showEnterUsernameView) {
            EnterUsernameView(showEnterUsernameView: self.$showEnterUsernameView)
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeView()
    }
    
}
