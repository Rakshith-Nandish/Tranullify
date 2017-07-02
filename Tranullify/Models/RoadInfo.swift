
import Foundation
import ObjectMapper

class RoadInfo:Mappable {
    
    var id: Int = 0
    var highway: String = ""
    var isOneWay: Bool = false
    var position: [[Double]] = []
    var name: String = ""
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map){
        id <- map["id"]
        highway <- map["properties.highway"]
        isOneWay <- map["properties.oneway"]
        position <- map["coordinates"]
        name <- map["properties.name"]
    }
}
