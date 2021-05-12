//
//  ResourceFactory.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-09-25.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import Foundation
import CodableCSV

class ResourceManager {
    
    weak var delegate: ResourceManagerDelegate?
    
    func fetchResources() {
        let url = dataDownloadUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let webClient = WebClient()
        do {
            try webClient.fileDownload(urlPath: url!, successBlock: {(_ resp: [Resource]) in
                
                self.delegate?.didFetchResources(resources: resp)
            }, failureBlock: {(_ resp: String) in
                NSLog("Failure: " + resp)
            })
        } catch {
            NSLog("Failure - in catch")
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
        /*
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
            let resource = Resource(i name: name, category: category)
            
            if remoteResources?[resource.category] == nil {
                remoteResources?[resource.category] = Array<Resource>()
            }
            remoteResources![resource.category]?.append(resource)
            
        } */
    }
    
    func fakeFetch() {
        let csv = """
                    category,name,serviceProvider,referralNeeded,location,rapidAccess,minAgeServed,maxAgeServed,cost,identity,language,emailAddress,phoneNumber,physicalAddress,virtualAddress,photoLink,description
                    Crisis,National Suicide Hotline,,1,Phone,TRUE,0,120,0,,"English, French, Language Support",,1-800-SUICIDE,,https://www.crisisservicescanada.ca/en/,,
                    """
        let string = """
            name,age,hasPet
            John,22,true
            """

        let csvDecoder = CSVDecoder {
            $0.headerStrategy = .firstLine
            $0.boolStrategy = .insensitive
        }
        
        
        do {
            let resource = try csvDecoder.decode(Student.self, from: string)
            print(resource)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    

}

protocol ResourceManagerDelegate: class {
    func didFetchResources(resources: [Resource])
}

struct Student: Codable {
    var name: String
    var age: Int
}
