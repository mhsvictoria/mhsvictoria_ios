//
//  ResourceFactory.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-09-25.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import Foundation

class ResourceManager {
    
    public static var selected: Resource?
    
    func retrieveAllResources() -> Array<Resource?>? {
        return nil
    }
    
    func retrieveAllMappedResources() -> Array<Resource?>? {
        return nil
    }
    
    func create(json: String?) -> Resource? {
        return nil
    }
    
    func update(resource: Resource) -> Resource? {
        return nil
    }
    
    func delete(id: String) -> Bool {
        return true
    }
}
