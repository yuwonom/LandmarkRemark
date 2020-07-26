//
//  AddRemarkView.swift
//  LandmarkRemark
//
//  Created by Michael Yuwono on 26/7/20.
//  Copyright © 2020 Michael Yuwono. All rights reserved.
//

import SwiftUI

struct AddRemarkView: View {
    
    @ObservedObject var viewModel: AddRemarkViewModel = AddRemarkViewModel()
    
    @Binding var showAddRemarkView: Bool
    
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
                Divider()
                HStack {
                    Text("Notes")
                    TextField("notes", text: Binding<String>(
                        get: { self.viewModel.notes },
                        set: { self.viewModel.notes = $0}))
                    .padding(.leading)
                }
                Spacer()
            }
        }
    }
    
}

struct AddRemarkView_Previews: PreviewProvider {
    static var previews: some View {
        AddRemarkView(showAddRemarkView: .constant(true))
    }
}
