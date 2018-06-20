//
//  Stop.swift
//  EcologicMobilityGrenoble
//
//  Created by Xamarin on 15/01/2018.
//  Copyright © 2018 iut. All rights reserved.
//

import Foundation

class Stop : Decodable{
    var id: String
    var name: String
    var lines: [String]
    var lon: Double
    var lat: Double
    
    /*init(json: [String: Any]){
        id = json["id"] as? String ?? ""
        name = json["name"] as? String ?? ""
        lines = json["lines"] as? [String] ?? []
        lon = json["lon"] as? Double ?? 0.0
        lat = json["lat"] as? Double ?? 0.0
    }*/
    
    public func getName() -> String{
        return self.name
    }
    
    public func getLon() -> String{
        return String(self.lon)
    }
    
    public func getLat() -> String{
        return String(self.lat)
    }
    
    public func getLinesTable() -> [String]{
        return self.lines
    }
    
    public func getLines() -> String{
        var indice: Int
        var lineString : String = ""
        for indice in 0..<self.lines.count{
            lineString += " " + self.lines[indice]
        }
        return lineString
    }
    
    
}
