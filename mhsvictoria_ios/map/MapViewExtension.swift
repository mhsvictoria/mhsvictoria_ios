//
//  MapViewExtension.swift
//  mhsvictoria_ios
//
//  Created by Riley Peel on 2020-10-26.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import Foundation
import MapKit

extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
