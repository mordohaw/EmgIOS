//
//  StopViewController.swift
//  EcologicMobilityGrenoble
//
//  Created by Xamarin on 23/01/2018.
//  Copyright © 2018 iut. All rights reserved.
//

import UIKit
import CoreLocation

class StopViewController: UIViewController {
    var myStop:Stop?
    var lineUrlString : String = ""
    var linesTable : [Line] = []
    
    let controlLineTask = DispatchGroup()


    @IBAction func passLines(_ sender: UIButton) {
        performSegue(withIdentifier: "goToLines", sender: self)
    }
    
    //pass the data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LineViewController{
            destination.lineStop = myStop
        }
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        var lineContent : String
        for lineContent in (self.myStop?.getLinesTable())!{
            lineUrlString = UrlConstructor.getLineInfoUrl(lineId: lineContent)
            controlLineTask.enter()
            getData(urlSource: lineUrlString)
            controlLineTask.wait()

        }
        
        
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
