//
//  LineViewController.swift
//  EcologicMobilityGrenoble
//
//  Created by Xamarin on 23/01/2018.
//  Copyright © 2018 iut. All rights reserved.
//

import UIKit

class LineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var lineStop:Stop?
    var lineUrlString : String = ""
    var linesTable : [Line] = []
    
    @IBOutlet weak var lineTableView: UITableView!
    let controlLineTask = DispatchGroup()


    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(linesTable.count)
    }
    
    //rempli la liste
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lineCell", for: indexPath) as! StopListViewTableViewCell
        /*cell.name.text = self.linesTable[indexPath.row].getName()
        cell.longitude.text = self.stopsTable[indexPath.row].getLon()
        cell.latitude.text = self.stopsTable[indexPath.row].getLat()
        cell.lines.text = self.stopsTable[indexPath.row].getLines()*/
        return(cell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var lineContent : String
        for lineContent in (self.lineStop?.getLinesTable())!{
            lineUrlString = UrlConstructor.getLineInfoUrl(lineId: lineContent)
            controlLineTask.enter()
            getData(urlSource: lineUrlString)
            controlLineTask.wait()
            
        }
        print(lineStop?.getLat())
        
        
        // Do any additional setup after loading the view.
    }
    
    func getData(urlSource : String){
        
        
        /*stopUrlString = UrlConstructor.getStopUrl(longitude: self.mapLocation.getLongitude(), lattitude: self.mapLocation.getLatitude(), distance: "1000")*/
        guard let dataUrl = URL(string: urlSource) else { return }
        //get the data from the api
        URLSession.shared.dataTask(with: dataUrl) { (data, response, err) in
            guard let data = data else{ return }
            let dataAsString = String(data: data, encoding: .utf8)
            
            do{
                self.linesTable = try JSONDecoder().decode([Line].self, from: data)
                print(self.linesTable[0].id)
                self.controlLineTask.leave()
                
            }catch let jsonErr{
                print("Error serializing json.", jsonErr)
            }
            }.resume()
    }


        // Do any additional setup after loading the view.

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
