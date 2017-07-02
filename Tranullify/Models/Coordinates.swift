
import Foundation
import ObjectMapper

class Coordinates: Mappable {
    
    var latitiude: Double = 0.0
    var longitude: Double = 0.0
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        
    }
}
