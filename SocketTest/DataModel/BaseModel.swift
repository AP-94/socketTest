//
//  BaseModel.swift
//  SocketTest
//
//  Created by Alessandro Pace on 24/10/2020.

import Foundation

protocol Mappable: Codable {
    init?(jsonData: Data?)
    init?(jsonString: String)
}

extension Mappable {
    
    init?(jsonData: Data?) {
        
        guard let data = jsonData else { return nil }
        do {
            self = try JSONDecoder().decode(Self.self, from: data)
        }
        catch {
            return nil
        }
    }
    
    init?(jsonString: String) {
        
        guard let data = jsonString.data(using: .utf8) else {
            return nil
        }
        self.init(jsonData: data)
    }
    
    var jsonString: String {
        var res = ""
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        if let data = try? encoder.encode(self) {
            res = String(data: data, encoding: .utf8) ?? ""
        }
        return res
    }
}

class BaseModel: Mappable {
    
    var id: Int
    var name: String
    var items: [BaseModel]?
    var oneDate: Date
    
    // These are the mapping between class/structure properties and json names
    private enum CodingKeys: String, CodingKey {
        case id
        case name    = "alias"
        case items   = "objects"
        case oneDate = "birth"
    }
    
    
    // You should implement this method 'only' if you want to decode your object in a specific fashion
    // This example maps a Date object from a json string of type "MM-dd-yyyy"
    //*
     
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id    = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name  = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        items = try values.decodeIfPresent([BaseModel].self, forKey: .items)
        
        let birthString = try values.decodeIfPresent(String.self, forKey: .oneDate) ?? ""
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        oneDate = formatter.date(from: birthString) ?? Date()
    }
    // */
 
}

