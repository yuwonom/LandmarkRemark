//
//  LocalStorageManager.swift
//  LandmarkRemark
//
//  Created by Michael Yuwono on 27/7/20.
//  Copyright © 2020 Michael Yuwono. All rights reserved.
//

import Foundation
import UIKit

struct storageKeys {
    static let userId = "userId"
}

class LocalStorageManager: ObservableObject {

    let storage = UserDefaults.standard
    
    func getUserId() -> String? {
        storage.string(forKey: storageKeys.userId)
    }
    
    func setUserId(userId: String) {
        storage.set(userId, forKey: storageKeys.userId)
    }
    
}
