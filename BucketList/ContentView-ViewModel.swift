//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Bruke on 8/5/22.
//

import Foundation
import LocalAuthentication
import MapKit

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var mapRegeion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 38.789217, longitude: -90.322614), span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15))
        @Published private(set) var locations: [Location]
        @Published var selectedPlace: Location?
        @Published var isUnlocked = false
        
        @Published var username = ""
        @Published var password = ""
        
        let savePath = FileManager.documentsDirecotry.appendingPathComponent("SavedPlaces")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("Unable to save data. ")
            }
        }
        
        func addLocation() {
            let newLocation = Location(id: UUID(), name: "New locatoin", description: "", latitude: mapRegeion.center.latitude, longitude: mapRegeion.center.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace = selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself unlock your places."
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    if success {
                        Task { @MainActor in
                            self.isUnlocked = true
                        }
                    } else {
                        // error
                    }
                }
            } else {
                // no biometrics
            }
        }
        
        func signIn(username: String, password: String) {
            if username == "username" && password == "password" {
                self.isUnlocked = true
            }
        }
    }
}
