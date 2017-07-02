
//  ViewController.swift
//  Tranullify

import UIKit
import GoogleMaps
import MapKit
import ObjectMapper

class ViewController: UIViewController {
    
    @IBOutlet weak var mapViewRoadAnalysis: GMSMapView!
    
    var roads: [RoadInfo]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMap()
        readJson()
        for road in roads {
            if road.name == "Outer Ring Road" {
             drawPolyLine(road: road)     
            }
        }
    }
    
    func loadMap() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 12.9260, longitude: 77.6762, zoom: 15.0)
        mapViewRoadAnalysis.camera = camera
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 12.9260, longitude: 77.6762)
        marker.title = "Bellandur"
        marker.snippet = "Bangalore"
        
        marker.map = mapViewRoadAnalysis
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func readJson() {
        do {
            if let file = Bundle.main.url(forResource: "DemoResponse", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    // json is a dictionary
                    print(object)
                    print("its a dcitionary")
                    //roads = Mapper<RoadInfo>().map(JSON: object)
                    print(roads)
                } else if let object = json as? [Any] {
                    // json is an array
                    roads = Mapper<RoadInfo>().mapArray(JSONObject: object)
                    print(roads)
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func drawPolyLine(road: RoadInfo) {
        let path = GMSMutablePath()

        for coordinate in road.position {
            path.addLatitude(coordinate[1], longitude: coordinate[0])
        }
        
        let polyLine = GMSPolyline(path: path)
        polyLine.strokeColor = UIColor.red
        polyLine.strokeWidth = 4.0
        polyLine.map = mapViewRoadAnalysis
    }
}


