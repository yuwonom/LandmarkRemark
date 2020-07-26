//
//  AppDelegate+Injection.swift
//  LandmarkRemark
//
//  Created by Michael Yuwono on 26/7/20.
//  Copyright © 2020 Michael Yuwono. All rights reserved.
//

import Resolver

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        // Register all services
        register { FirestoreManager() }.scope(application)
        register { LocationManager() }.scope(application)
    }
    
}
