//
//  StopListView.swift
//  EcologicMobilityGrenoble
//
//  Created by Xamarin on 11/01/2018.
//  Copyright © 2018 iut. All rights reserved.
//

import UIKit
import CoreLocation

class StopListView: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var stopUrlString : String = ""
    var mapUrlString : String = ""
    var stopsTable : [Stop] = []
    var mapLocation : MapGeoloc = MapGeoloc(lat: 0.0, lng: 0.0, accuracy: 0)
    
    //let locationManager:CLLocationManager = CLLocationManager()
    let controlGroup1 = DispatchGroup()
    let controlGroup2 = DispatchGroup()
    
    @IBOutlet weak var myTableView: UITableView!
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(stopsTable.count)
    }
    
    //rempli la liste
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stopCell", for: indexPath) as! StopListViewTableViewCell
        cell.name.text = self.stopsTable[indexPath.row].getName()
        cell.longitude.text = self.stopsTable[indexPath.row].getLon()
        cell.latitude.text = self.stopsTable[indexPath.row].getLat()
        cell.lines.text = self.stopsTable[indexPath.row].getLines()
        return(cell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        
        //get user location
        //locationManager.delegate = self
        //locationManager.requestLocation()
        /*locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        var latitude : String = String(describing: locationManager.location?.coordinate.latitude)
        var longitude : String = String(describing: locationManager.location?.coordinate.longitude)
        
        locationManager.stopUpdatingLocation()*/
        controlGroup1.enter()
        controlGroup2.enter()
        
        //construct Url    longitude: "5.724524", lattitude: "45.188529"
        
        mapUrlString = UrlConstructor.getMapGeoloc()
        getLocalisation(urlSource: mapUrlString)
        controlGroup1.wait()
        
        
        //var locationObject : MapGeoloc = getLocalisation(urlSource: mapUrlString)
        
        //controlGroup1.wait()
        //stopUrlString = UrlConstructor.getStopUrl(longitude: "5.724524", lattitude: "45.188529", distance: "500")
        //populate list
        getData(urlSource: stopUrlString)
        controlGroup2.wait()
        self.myTableView.reloadData()
        
        
    }
    
    func getData(urlSource : String){
        //set Url with the right type
        
       
        //controlGroup1.enter()
        //var locationObject : MapGeoloc = getLocalisation(urlSource: mapUrlString)
        //controlGroup1.wait()
        
        //stopUrlString = UrlConstructor.getStopUrl(longitude: "5.724524", lattitude: "45.188529", distance: "500")
        
        stopUrlString = UrlConstructor.getStopUrl(longitude: self.mapLocation.getLongitude(), lattitude: self.mapLocation.getLatitude(), distance: "1000")
         guard let dataUrl = URL(string: stopUrlString) else { return }
            //get the data from the api
            URLSession.shared.dataTask(with: dataUrl) { (data, response, err) in
                guard let data = data else{ return }
                let dataAsString = String(data: data, encoding: .utf8)
                
                do{
                    self.stopsTable = try JSONDecoder().decode([Stop].self, from: data)
                    print(self.stopsTable[0].name)
                    self.controlGroup2.leave()
                    
                }catch let jsonErr{
                    print("Error serializing json.", jsonErr)
                }
                }.resume()
        }
    
    func getLocalisation(urlSource : String){
        guard let dataUrl = URL(string: urlSource) else { return  }
        
        var request = URLRequest(url : dataUrl)
        request.httpMethod = "POST"
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, err) in
            guard let data = data else{ return }
            let dataPostAsString = String(data: data, encoding: .utf8)
            
            do{
                self.mapLocation = try JSONDecoder().decode(MapGeoloc.self, from: data)
                self.controlGroup1.leave()
            }catch let jsonErr{
                print("Error serializing json.", jsonErr)
            }
        }).resume()
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //go to stop activity
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = indexPath.row
        performSegue(withIdentifier: "showStop", sender: self)
    }
    
    //pass the data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? StopViewController{
            destination.myStop = stopsTable[(myTableView.indexPathForSelectedRow?.row)!]
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
