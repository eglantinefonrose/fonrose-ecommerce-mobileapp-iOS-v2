//
//  MapViewModel.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 27/03/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI
import Foundation
import MapKit
import CoreLocation

struct Place: Identifiable {
    
    var id = UUID().uuidString
    var placemark: CLPlacemark
    
}

@available(iOS 14.0, *)
class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    //MARK: User's location
    
    @Published var authorizationStatus: CLAuthorizationStatus
    
    private let locationManager: CLLocationManager
    //CLLocationManager = big boss qui gère CoreLocation
    //quand on fait locationManager.blablabla on veut utiliser qqch proposé par CoreLocation
    
    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
        //on fait locationManager.blablabla parce-que la fonction qui permet de demander l'autorisation à l'utilisateur est une fonction proposée par CoreLocation
    }
    
    @Published var lastSeenLocation: CLLocation?
    @Published var userHomePlacemark: CLPlacemark?

    // Les placemarks contiennent l'adresse correspondante à des coordonnées (lat, long) données

    /*guard let est équivalent de "if let"
     on définit d'abord currentPlacemark comme une constante égale à placemarks?.first
     ensuite si lastSeenLocation est diférrent de 0 on appelle les fonctions fetchCountryAndCity et self.region
     sinon on fait return
     */
    
    func fetchCountryAndCity(for location: CLLocation?) {
        guard let location = location else { return }
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
        //placemarks est un tableau avec tous les placemarks des positions de l'utilisateur
            self.userHomePlacemark = placemarks?.first
        }
    }
    
    func reverseLocation(for location: CLLocation?) {
        guard let location = location else { return }
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
        //placemarks est un tableau avec tous les placemarks des positions de l'utilisateur
            self.userHomePlacemark = placemarks?.first
        }
    }
    
    //MARK: Location authorization

    @Published var permissionDenied = false
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .denied:
            permissionDenied = true
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            manager.requestLocation()
        default:
            ()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    //MARK: Map
    
    @Published var places: [Place] = []
    @Published var searchTxt = ""
    
    //Récupérer l'adresse de l'utilisateur
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //locations est un tableau avec les positions successives de l'utilisateur
        
        /*guard let est équivalent de "if let"
         on définit d'abord lastSeenLocation comme une constante égale à locations.first
         ensuite si lastSeenLocation est diférrent de 0 on appelle les fonctions fetchCountryAndCity et self.region
         sinon on fait return
         */
        guard let lastSeenLocation = locations.first else { return }
        fetchCountryAndCity(for: locations.first)
        //"region" correspond à une zone autour de laquelle la map va se centrer
        
        self.region = MKCoordinateRegion(center: lastSeenLocation.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        //self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 25.276987, longitude: 55.296249), latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        pinSelectedPlace(pointSelectedPlaceLat: Int(CLLocationDegrees(25.276987)), pointSelectedPlaceLong: Int(CLLocationDegrees(55.296249)))
        
        //CLLocationDegrees(25.276987)), pointSelectedPlaceLong: Int(CLLocationDegrees(55.296249)
        
        //la fonction configure la region sur laquelle la map se centre
        //donc quand on affiche une mapView, elle est centrée sur la region
        self.mapView.setRegion(self.region, animated: true)
        
        //la fonction
        self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
        
    }
    
    @Published var mapView = MKMapView()
    @Published var region: MKCoordinateRegion!
    @Published var mapType: MKMapType = .standard
    
    func updateMapType(){
        if mapType == .standard {
            mapType = .hybrid
            mapView.mapType = mapType
        }
        else {
            mapType = .standard
            mapView.mapType = mapType
        }
    }
    
    func focusLocation() {
        
        guard let _ = region else {return}
        
        //modifie la region qu'on voit sur la map pour mettre celle centrée sur le point où on est
        mapView.setRegion(region, animated: true)
        
        //je crois que ça sert à créer une animation mais pas sure
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
        
    }
    
    func searchQuery() {
        
        //on commence par supprimer tous les éléments actuellement présents dans places
        places.removeAll()
        
        //"request" est defini comme une chaine de caractère qu'on va convertir du langage naturel (adresse) en un point sur la map
        let request = MKLocalSearch.Request()
        
        //request.naturalLanguageQuery correspond à la chaine de caractère de la requète de l'utilisateur a tapé dans le textField
        request.naturalLanguageQuery = searchTxt
        
        //la fonction "MKLocalSearch" convertit l'adresse rentrée par l'utilisateur dans la barre de recherche en un point GPS
        //"start" veut dire que la recherche est en cours jusqu'à l'obtention d'un résultat, et à ce moment là le résultat est envoyé au CompletionHandler
        MKLocalSearch(request: request).start { (response, _) in
        
            //le guard let est utilisé pour être sûr que la recherche n'est pas = à nil
            guard let result = response else {return}
            self.places = result.mapItems.compactMap({ (item) -> Place? in
                return Place(placemark: item.placemark)
            
                //on met dans le tableau "places" (qui contient des objets de type Place) un tableau de map Items (une localisation géographique et les données qui vont avec comme l'adresse correspondant aux coordonées GPS) qui représentent le résultat de la recherche faite (grâce à la barre de recherche)
                //la fonction mapItemps.compactMap renvoie un tableau d'objets de type Place avec à l'intérieur les coordonnées GPS correspondant aux adresses tapées dans la barre de recherche
            
            })
        }
    }
    
    func selectPlace(place: Place) {
        searchTxt = ""
        
        //la variable "coordinate" correspond aux coordonnées d'un objet place de type "Place"
        guard let coordinate = place.placemark.location?.coordinate else {return}
        
        //un MKPointAnnotation correspond au nom qu'il y a marqué à côté de l'épingle qui s'affiche sur la map
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = coordinate
        pointAnnotation.title = place.placemark.name ?? "No name"
        
        //Moving map to that location
            
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
        
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(pointAnnotation)
        
    }
    
    func pinHome() {
        guard let homeCoordinate = userHomePlacemark?.location?.coordinate else {return}
        
        let pointHomeAnnotation = MKPointAnnotation()
        pointHomeAnnotation.coordinate = homeCoordinate
        pointHomeAnnotation.title = userHomePlacemark?.name ?? "No name"
        
        let coordinateHomeRegion = MKCoordinateRegion(center: homeCoordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(coordinateHomeRegion, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
        
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(pointHomeAnnotation)
        
    }
    
    func pinSelectedPlace(pointSelectedPlaceLat: Int, pointSelectedPlaceLong: Int) {
        
        let selectedPlaceCoordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(pointSelectedPlaceLat), longitude: CLLocationDegrees(pointSelectedPlaceLong))
        
        let pointSelectedPlaceAnnotation = MKPointAnnotation()
        pointSelectedPlaceAnnotation.coordinate = selectedPlaceCoordinate
        pointSelectedPlaceAnnotation.title = "No name"
        
        let coordinateSelectedPlaceRegion = MKCoordinateRegion(center: selectedPlaceCoordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(coordinateSelectedPlaceRegion, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
        
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(pointSelectedPlaceAnnotation)
        
        /*let homeCoordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(25.276987), longitude: CLLocationDegrees(55.296249))
        
        let coordinateSelectedPlaceRegion = MKCoordinateRegion(center: homeCoordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(coordinateSelectedPlaceRegion, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
        
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(MKPointAnnotation())*/
        
    }
    
}

