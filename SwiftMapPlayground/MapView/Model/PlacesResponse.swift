//
//  AUModel.swift
//  SwiftMapPlayground
//
//  Created by Swan Nay Phue Aung on 01/10/2024.
//
import Foundation
import MapKit


class PlacesResponse : Codable {
    
    let places : [AUPlace]
    
    enum CodingKeys: String,CodingKey {
        case places = "Places"
    }
    
    init(places: [AUPlace]) {
        self.places = places
    }
}

class AUPlace : NSObject, Codable, MKAnnotation {
    
    var facultyName: String
      var abbreviation: String
      var imageLogoName: String
      var latitude: Double
      var longitude: Double

    enum CodingKeys: String,CodingKey {
        case facultyName = "FacultyName"
        case abbreviation = "Abbreviation"
        case imageLogoName = "ImageLogoName"
        case latitude = "LocationLat"
        case longitude = "LocationLong"
    }
    
    init(facultyName: String, abbreviation: String, imageLogoName: String, latitude: Double, longitude: Double) {
           self.facultyName = facultyName
           self.abbreviation = abbreviation
           self.imageLogoName = imageLogoName
           self.latitude = latitude
           self.longitude = longitude
       }
    
    
    //Default MKAnnotation Properties for callout
    var coordinate: CLLocationCoordinate2D {
          return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
      }
    
    var title: String? {
          return facultyName
      }
    
    var subtitle: String? {
        return abbreviation
    }
}



