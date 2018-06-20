//
//  MapGeoloc.swift
//  EcologicMobilityGrenoble
//
//  Created by Xamarin on 16/01/2018.
//  Copyright © 2018 iut. All rights reserved.
//

import Foundation

class mapLocation : Decodable{
    var lat: Double
    var lng: Double
    
    init(lat : Double, lng : Double){
        self.lat=lat
        self.lng=lng
    }
    
    public func getLat() -> String{
        return String(self.lat)
    }
    
    public func getLng() -> String{
        return String(self.lng)
    }
    
}

class MapGeoloc : Decodable{
    var location: mapLocation
    var accuracy: Double
    
    init(lat : Double, lng : Double, accuracy : Double){
        self.location = mapLocation(lat : lat, lng : lng)
        self.accuracy = accuracy
    }
    
    /*init(json: [String: Any]){
     id = json["id"] as? String ?? ""
     name = json["name"] as? String ?? ""
     lines = json["lines"] as? [String] ?? []
     lon = json["lon"] as? Double ?? 0.0
     lat = json["lat"] as? Double ?? 0.0
     }*/
    
    public func getLatitude() -> String{
        return self.location.getLat()
    }
    
    public func getLongitude() -> String{
        return self.location.getLng()
    }
    
    public func getAccuracy() -> String{
        return String(self.accuracy)
    }
    
    
}
