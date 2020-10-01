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
    public var remoteResources: Dictionary<String, Array<Resource>>?
    public static let shared = ResourceManager()

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
                    self.remoteResources = Dictionary<String, Array<Resource>>()
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
        NSLog(">>>>>> TOKENS: \(tokens)")
        if tokens.count > 1 {
            var category = "Other"
            let cat = tokens[0].replacingOccurrences(
            of: "\\s",
            with: "",
            options: .regularExpression,
            range:nil)
            if cat.count > 0 {
                category = cat
            } else {
                category = "Other"
            }
            NSLog(">>>>>> CATEGORY: \(category)")
            let name = tokens[1].replacingOccurrences(
            of: "\\n",
            with: "",
            options: .regularExpression,
            range:nil)
            let resource = Resource(id: name, name: name, category: category)
            
            if remoteResources?[resource.category] == nil {
                remoteResources?[resource.category] = Array<Resource>()
            }
            remoteResources![resource.category]?.append(resource)
            
        }
    }
}
