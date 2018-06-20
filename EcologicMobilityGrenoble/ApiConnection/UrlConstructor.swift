//
//  UrlConstructor.swift
//  EcologicMobilityGrenoble
//
//  Created by Xamarin on 15/01/2018.
//  Copyright © 2018 iut. All rights reserved.
//

import Foundation


/**
 * Created by William on 22/11/2017.
 */

public class UrlConstructor {
    
    let myGoogleApiKey: String = "AIzaSyDeDG09ZXIlnEfkHNkA1zHqHyCb2t7SZks";
    
    //public static String getGeolocUrl()
    //{
    // return("https://www.googleapis.com/geolocation/v1/geolocate?key="+myGoogleApiKey);
    //}
    
    public class func getStopUrl(longitude: String, lattitude : String, distance: String) -> String{
        return("http://data.metromobilite.fr/api/linesNear/json?x=" + longitude + "&y=" + lattitude + "&dist=" + distance + "&details=false")
    
    }
    
    
    public class func getLineInfoUrl(lineId : String) -> String{
        return("https://data.metromobilite.fr/api/routers/default/index/routes?codes=" + lineId)
    
    }
    
    public class func getStopTimeUrl(stopId : String) -> String{
        return("https://data.metromobilite.fr/api/routers/default/index/stops/" + stopId + "/stoptimes")
    
    }
    
    public class func getMapGeoloc() -> String{
        return("https://www.googleapis.com/geolocation/v1/geolocate?key=AIzaSyDeDG09ZXIlnEfkHNkA1zHqHyCb2t7SZks")
    }
    
    
    
    public class func getGeoCoordonates(numRue : String,nomRue : String) -> String{
        return("https://maps.googleapis.com/maps/api/geocode/json?address="+numRue+","+"+rue+de+"+"nomRue+"+"Grenoble&key=https://www.googleapis.com/geolocation/v1/geolocate?key=AIzaSyDeDG09ZXIlnEfkHNkA1zHqHyCb2t7SZks");
        
    }
    
}
