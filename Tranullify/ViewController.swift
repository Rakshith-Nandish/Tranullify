
//  ViewController.swift
//  Tranullify

import UIKit
import GoogleMaps
import MapKit
import ObjectMapper

class ViewController: UIViewController {
    
    @IBOutlet weak var mapViewRoadAnalysis: GMSMapView!
    
    @IBOutlet weak var labelSelectedType: UILabel!
    var roads: [RoadInfo]!
    
    @IBOutlet weak var buttonOneWay: UIButton!
    @IBOutlet weak var buttonAlternateRoute: UIButton!
    
    var polyLineForOneWay: GMSPolyline?
    var polyLineForAlternateRoutes: GMSPolyline?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMap()
        readJson()
    }
    
    func loadMap() {
        let camera = GMSCameraPosition.camera(withLatitude: 12.9260, longitude: 77.6762, zoom: 16.0)
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
    
    
    //MARK: Button actions
    @IBAction func buttonActionHandlers(_ sender: UIButton) {
        mapViewRoadAnalysis.clear()
        if sender == buttonOneWay {
            labelSelectedType.text = "Showing One-Way(s)"
            for road in roads {
                if road.name == "Outer Ring Road" {
                    drawPolyLineForOneWay(road: road)
                }
            }
        }else {
            labelSelectedType.text = "Showing Alternate-route(s)"
            for road in roads {
                if road.highway != "trunk" && road.highway != "trunk_link" && road.highway != "secondary" && road.highway != "primary_link" && road.highway != "tertiary" && road.highway != "footway" && road.name != "Outer Ring Road" {
                    drawPolyLineForAlternateRoutes(road: road)
                }
            }
        }
    }
    
    
    
    func drawPolyLineForOneWay(road: RoadInfo) {
        let path = GMSMutablePath()

        for coordinate in road.position {
            path.addLatitude(coordinate[1], longitude: coordinate[0])
        }
        
        polyLineForOneWay = GMSPolyline(path: path)
        polyLineForOneWay?.strokeColor = UIColor.red
        polyLineForOneWay?.strokeWidth = 4.0
        polyLineForOneWay?.map = mapViewRoadAnalysis
    }
    
    func drawPolyLineForAlternateRoutes(road: RoadInfo) {
        let path = GMSMutablePath()
        for coordinate in road.position {
            path.addLatitude(coordinate[1], longitude: coordinate[0])
        }
        
        polyLineForAlternateRoutes = GMSPolyline(path: path)
        polyLineForAlternateRoutes?.strokeColor = UIColor.blue
        polyLineForAlternateRoutes?.strokeWidth = 4.0
        polyLineForAlternateRoutes?.map = mapViewRoadAnalysis
    }
}


