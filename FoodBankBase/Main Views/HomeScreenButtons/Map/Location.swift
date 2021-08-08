//
//  Location.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 8/7/21.
//

import Foundation
import MapKit

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
