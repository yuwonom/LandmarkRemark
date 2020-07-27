//
//  EnterUsernameView.swift
//  LandmarkRemark
//
//  Created by Michael Yuwono on 26/7/20.
//  Copyright © 2020 Michael Yuwono. All rights reserved.
//

import SwiftUI

struct EnterUsernameView: View {
    
    @ObservedObject var viewModel: EnterUsernameViewModel = EnterUsernameViewModel()
    
    @Binding var showEnterUsernameView: Bool
    @Binding var showAddRemarkView: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Username")
                    TextField("username", text: Binding<String>(
                        get: { self.viewModel.username },
                        set: { self.viewModel.username = $0}))
                    .padding(.leading)
                }
                Spacer()
            }
            .padding()
            .navigationBarTitle(Text(self.viewModel.title), displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    self.showEnterUsernameView = false
                }) {
                    Text("Cancel")
                }
                .disabled(self.viewModel.isBusy),
                trailing: Button(action: {
                    self.viewModel.setUsername()
                }) {
                    Text("Save")
                }
                .disabled(self.viewModel.username.isEmpty || self.viewModel.isBusy)
            )
        }
        .onReceive(self.viewModel.$addUserResult) { (result) in
            if let result = result {
                if (result) {
                    self.showEnterUsernameView = false
                    self.showAddRemarkView = true
                }
            }
        }
    }
    
}

struct EnterUsernameView_Previews: PreviewProvider {
    
    static var previews: some View {
        EnterUsernameView(showEnterUsernameView: .constant(true), showAddRemarkView: .constant(false))
    }
    
}
