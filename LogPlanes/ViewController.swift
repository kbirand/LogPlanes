//
//  ViewController.swift
//  LogPlanes
//
//  Created by Koray Birand on 7/1/15.
//  Copyright (c) 2015 Koray Birand. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var passArray : NSMutableArray = NSMutableArray()
    var counter : Int = 1

    @IBOutlet var receivedDataTextView: NSTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(ViewController.getFlights), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    
    func roundToTens(_ x : Double) -> Int {
        return 10 * Int(round(x / 10.0))
    }
    
    
    @objc func getFlights() //-> NSMutableArray {
    {
        let url = URL(string:"http://krk.data.fr24.com/zones/fcgi/feed.js?bounds=41,39,31,35&adsb=1&mlat=1&flarm=1&faa=1&estimated=1&air=1&gnd=0&vehicles=0&gliders=1&limit=1800&array=1")
        
        let cachePolicy = NSURLRequest.CachePolicy.reloadRevalidatingCacheData
        
        let request : URLRequest = NSMutableURLRequest(url: url!, cachePolicy: cachePolicy, timeoutInterval: 5) as URLRequest
        
        var response: URLResponse? = nil
        var _: NSError? = nil
        
        let reply = try! NSURLConnection.sendSynchronousRequest(request, returning: &response)
       
        let results = NSString(data:reply, encoding:String.Encoding.utf8.rawValue)
        
        if results != nil {
        
            var dim01 = results?.components(separatedBy: "\n")
        
            if (dim01?.count)! >= 1 {
            
            dim01?.remove(at: 0)
            dim01?.removeLast()
            var aaaa : NSArray
                aaaa = dim01! as NSArray
            
            passArray = NSMutableArray()
            if aaaa.count != 0 {
                
                for xx in 0...(aaaa.count-1) {
                    
                    let myLine: AnyObject = aaaa[Int(xx)] as AnyObject
                    var parsedDate = myLine.components(separatedBy: ",")
                    let lat = Double(parsedDate[3])!
                    let lon = Double(parsedDate[4])!
                    let flightNo = koray.midString(parsedDate[15].description, startPos: 1, charToGet: (parsedDate[15].description).count-2)
                    let altitude = Double(parsedDate[6])! / 3.2808
                    let heading = Float(parsedDate[5])
                    let from = koray.midString( parsedDate[13].description, startPos: 1, charToGet: 3)
                    let to =  koray.midString( parsedDate[14].description, startPos: 1, charToGet: 3)
                    
                    let tempArray = ["lat":lat , "lon":lon , "flightNo":flightNo, "altitude":altitude ] as [String : Any]
                    passArray.add(tempArray)
                    
                    let todaysDate:Date = Date()
                    let dateFormatter:DateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
                    let DateInFormat : String = dateFormatter.string(from: todaysDate)
                    
                    let dataSegment = ("\(counter);\(flightNo);\(lat);\(lon);\(altitude);\(from)-\(to);\(heading ?? 0);\(DateInFormat)\n")
                    self.receivedDataTextView.textStorage?.mutableString.append(dataSegment as String)
                    self.receivedDataTextView.needsDisplay = true
                    self.receivedDataTextView.scrollToEndOfDocument(nil)
                    let dataToWrite = self.receivedDataTextView.string
                    let myFilePath = "/Users/koraybirand/Desktop/log_Ankara.txt"
                    try! dataToWrite.write(toFile: myFilePath, atomically: false, encoding: String.Encoding.utf8)
                
                    counter = counter + 1
                    
                   
                }
            }
        }
        
        }
        //return passArray
        
    }


}

