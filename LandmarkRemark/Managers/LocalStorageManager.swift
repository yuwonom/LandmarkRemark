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

    // Local storage service manager
    let storage = UserDefaults.standard
    
    // Get persisted user ID from local storage, returning nil if not found
    func getUserId() -> String? {
        storage.string(forKey: storageKeys.userId)
    }
    
    // Store a new user ID to local storage
    func setUserId(userId: String) {
        storage.set(userId, forKey: storageKeys.userId)
    }
    
}
