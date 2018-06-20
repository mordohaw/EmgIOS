//
//  Line.swift
//  EcologicMobilityGrenoble
//
//  Created by Xamarin on 23/01/2018.
//  Copyright © 2018 iut. All rights reserved.
//

import Foundation

class Line : Decodable{
    var id: String
    var shortName: String
    var longName: String
    var color: String
    var textColor: String
    var mode: String
    var type: String
    
    /*init(json: [String: Any]){
     id = json["id"] as? String ?? ""
     name = json["name"] as? String ?? ""
     lines = json["lines"] as? [String] ?? []
     lon = json["lon"] as? Double ?? 0.0
     lat = json["lat"] as? Double ?? 0.0
     }*/
    
    public func getId() -> String{
        return String(self.id)
    }
    
    
    
}

