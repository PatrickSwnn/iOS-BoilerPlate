//
//  LocationDataService.swift
//  MapKitPlayground
//
//  Created by Swan Nay Phue Aung on 17/08/2024.
//

import Foundation

class LocationViewModel : ObservableObject {
    
    static let shared = LocationViewModel()
    @Published var locations : [AUPlace] = []
    
    let ABACCenter = AUPlace(facultyName: "ABAC Center", abbreviation: "ABAC", imageLogoName: "eng_logo", latitude: 13.612320, longitude: 100.836808)
    
    init() {
        guard let jsonContent = readJSONFile(named: "abac_location", withExtension: "json") else { return }
        locations.append(contentsOf: jsonContent)
    }
    private func readJSONFile(named fileName: String, withExtension fileExtension: String) -> [AUPlace]? {
            // Locate the file in the bundle
            if let fileURL = Bundle.main.url(forResource: fileName, withExtension: fileExtension) {
                do {
                    // Read the data from the file
                    let data = try Data(contentsOf: fileURL)
                    // Decode the data to the AppInfo struct
                    let appInfo = try JSONDecoder().decode(PlacesResponse.self, from: data)
                    return appInfo.places
                } catch {
                    print("Error reading or decoding file: \(error.localizedDescription)")
                }
            } else {
                print("File not found.")
            }
            return nil
        }
    
}

