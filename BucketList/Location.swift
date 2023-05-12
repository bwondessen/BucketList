//
//  Location.swift
//  BucketList
//
//  Created by Bruke on 8/2/22.
//

import Foundation
import CoreLocation

struct Location: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static let example = Location(id: UUID(), name: "St. Louis Arch", description: "The big archy thing located in St. Louis, MO. It's pretty cool. Lived here all my life, but never been. Still cool, tho 👍", latitude: 38.624691 , longitude: -90.184776)
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
