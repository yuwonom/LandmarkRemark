//
//  Remark.swift
//  LandmarkRemark
//
//  Created by Michael Yuwono on 26/7/20.
//  Copyright © 2020 Michael Yuwono. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Remark: Codable, Identifiable {
    
    @DocumentID var id: String?
    var coordinate: GeoPoint
    var notes: String
    var userId: String
    
}
