//
//  ResourceFactory.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-09-25.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import Foundation

class ResourceManager {
    
    public var selected: Resource?
    public var remoteResources: Array<Resource>?
    static let shared = ResourceManager()

    private init() {
        // initializer code here
    }
    
    func retrieveRemoteResources(completion: @escaping (Bool)->()) {
        if remoteResources != nil {
            completion(true)
            return
        }
        let url = dataDownloadUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let webClient = WebClient()
        do {
            try webClient.fileDownload(urlPath: url!, successBlock: {(_ resp: Array<String>?) in
                guard let _ = resp else {
                    return
                }
                if resp!.count > 1 {
                    self.remoteResources = Array<Resource>()
                    for i in 1..<resp!.count {
                        self.createResource(resp![i])
                    }
                }
                completion(true)
            }, failureBlock: {(_ resp: String) in
                NSLog("Failure: " + resp)
                completion(false)
            })
        } catch {
            NSLog("Failure - in catch")
            completion(false)
        }
    }
    
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
    
    private func createResource(_ str: String) {
        let tokens = str.split(separator: Character(","))
        if tokens.count > 1 {
            var resource = Resource(id: String(tokens[1]), name: String(tokens[1]))
            var category = String(tokens[0])
            if category.count == 0 {
                resource.category == "Other"
            } else {
            resource.category = String(category)
            }
            remoteResources?.append(resource)
        }
    }
}
