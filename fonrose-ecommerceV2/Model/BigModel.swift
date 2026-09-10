//
//  self.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 22/05/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseStorage
import CoreLocation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import MapKit
import AuthenticationServices
import GoogleSignIn
import PassKit

@available(iOS 15.0, *)
class BigModel : NSObject, ObservableObject {
    
    //fonction qui crée un textfield
    
    func creerTextField(placeholder: String, text: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.text = text
        return textField
    }
    
    @Published var user: User = User(id: "", email: "", persons: [])
    @Published var lastUserEmail: String = (UserDefaults.standard.string(forKey: "lastUserEmail") ?? "nil")
    @Published var lastUserPassword: String = (UserDefaults.standard.string(forKey: "lastUserPassword") ?? "nil")
    @Published var lastUserID: String = (UserDefaults.standard.string(forKey: "lastUserID") ?? "nil")
    @Published var lastCurrentPersonIndex: Int = (UserDefaults.standard.integer(forKey: "lastCurrentPersonIndex"))
    @Published var lastCurrentPersonId: String = (UserDefaults.standard.string(forKey: "lastCurrentPersonId") ?? "nil")
        
    @Published var signInErrorMessage = ""
    @Published var signOutErrorMessage = ""
    /*@Published var defaultLocationCoordinate = CLLocationCoordinate2D(latitude: 55, longitude: 25)
    @Published var userDBLat: CGFloat = 50.073658
    @Published var userDBLong: CGFloat = 14.418540*/
    
    //MARK: UserModel
    struct User: Identifiable, Codable {
        @DocumentID var id: String?
        var email: String
        var persons: [Person]
    }

    struct Location: Codable {
        @DocumentID var id: String?
        var civility: String
        var firstName: String
        var lastName: String
        var emailAdress: String
        var phoneNumber: String
        var adressCountry: String
        var adressPostalCode: String
        var adressCity: String
        var adressStreet: String
        var adressMailBox: String
        var adressBasement: String
        var adressStage: String
    }

    struct Measurements: Codable {
        @DocumentID var id: String?
        var measurements: [MeasurementModel]
    }
    
    struct MeasurementModel: Codable {
        var id: Int
        var measurementName: String
        var measurementValue: String
    }
    
    struct TstJSON: Codable {
        let id: String
        let name: String
    }
    
    struct ParcelInfos {
        let status: SuiviStatusEnum
    }

    struct PersonFirebaseConstants {
        static let email = "email"
        static let name = "name"
    }
    
    struct Person: Identifiable, Codable {
        @DocumentID var id: String?
        var email: String
        var name: String
        var measurements: Measurements?
        var location: Location?
        var orders: [Order]
        
    }
    
    struct DressPictures: Codable, Identifiable, Hashable {
        var id: Int
        let pictureName: String
        let productName: String
        var videoURL: String
        var price: Int
        var carouselProductPictures: [String]
    }
    
    struct NeededMeasurementsModel: Codable {
        var id: Int
        var productName: String
        var neededMeasurements: [Int]
    }
    
    struct Order: Codable, Identifiable {
        @DocumentID var id: String?
        var productName: String
        var status: OrderStatusEnum
        var location: Location
        var measurements: Measurements
        var orderDate: Date
    }
    
    
    

    var dressPictures: [DressPictures] = []
    
    
    //MARK: FetchImage
    func fetchImage(url: String) async throws -> Image {
        
        let storage = Storage.storage()
        let gcsReference = storage.reference(forURL: url)

        let imageData = try await gcsReference.data(maxSize: 10 * 1024 * 1024)

        guard let uiImage = UIImage(data: imageData) else {
            throw NSError(domain: "MyApp", code: 1, userInfo: [NSLocalizedDescriptionKey: "Error converting image data to UIImage."])
        }

        return Image(uiImage: uiImage)
        
    }
    
    
    
    
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    @Published var productImages: [Image] = []
    @Published var images: [Image] = []
    @Published var mainArrayInfos: [BigModel.MainViewArrayElements] = []
    @Published var productMainArrayInfos: [BigModel.DressPictures] = []
    
    
    
    
    
    
    
    
    
    //MARK: Fetch Main Array Images
    
    func fetchArrayOfImages() async throws -> [Image] {
        
        let localMainArrayInfos = try await self.fetchMainViewArrayInfos()
        var localImages: [Image] = []
        
        do {
            
            print("💡")
            for i in 0..<localMainArrayInfos.count {
                print("a\(i)")
                let image = try await self.fetchImage(url: localMainArrayInfos[i].imageName)
                print("z\(i)")
                localImages.append(image)
                print("💋 \(i)")
            }
            print("💡 fin")
            
        }
        catch {
            print("(fetchProductInfo) Une erreur est survenue lors de l'analyse JSON :  \(String(describing: error))")
        }
        
        return localImages
        
    }
    
    
    //MARK: Fetch Product Array Images
    
    func fetchArrayOfProductImages() async throws -> [Image] {
        
        let localMainArrayInfos = try await self.fetchProductInfo()
        var localImages: [Image] = []
        
        do {
            
            print("💡")
            for i in 0..<localMainArrayInfos.count {
                print("a\(i)")
                let image = try await self.fetchImage(url: localMainArrayInfos[i].pictureName)
                print("z\(i)")
                localImages.append(image)
                print("💋 \(i)")
            }
            print("💡 fin")
            
        }
        catch {
            print("(fetchProductInfo) Une erreur est survenue lors de l'analyse JSON :  \(String(describing: error))")
        }
        
        return localImages
        
    }
    
    
    
    
    
    
    
    
    
    //MARK: Fetch Products Informations
    
    var infoFetched = false
    @Published var isItFirstTime = true
    
    var imageRef = ""
    
    func fetchProductInfo() async throws -> [DressPictures] {
        
        /*var mainViewArrayElements: [MainViewArrayElements] = []
         guard let storageURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/fonrose-ecommerce-v2.appspot.com/o/MainViewTextImages.json?alt=media&token=b461478e-7076-46c1-87f2-d578f3262c3b") else {
             throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
         }
         
         do {
             
             let (data, _) = try await URLSession.shared.data(from: storageURL)
             let arrayElements = try  JSONDecoder().decode([MainViewArrayElements].self, from: data)
             
             for ArrayElements in arrayElements {
                 mainViewArrayElements.append(MainViewArrayElements(id: ArrayElements.id, imageName: ArrayElements.imageName, text: ArrayElements.text, nextScreen: ArrayElements.nextScreen))
             }
             
         } catch {
             print("(mainViewArrayElements) Une erreur est survenue lors de l'analyse JSON :  \(String(describing: error))")
         }
         
         return mainViewArrayElements*/
        
        var internDressPictures: [DressPictures] = []
        
        guard let storageURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/fonrose-ecommerce-v2.appspot.com/o/DressPictureData.json?alt=media&token=164c9c3d-a153-4b6d-b1c6-0d401a43722e") else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
         
         do {
             
            let (data, _) = try await URLSession.shared.data(from: storageURL)
            let dressPic = try JSONDecoder().decode([DressPictures].self, from: data)
             
             for dressPicture in dressPic {
                 internDressPictures.append(DressPictures(id: dressPicture.id, pictureName: dressPicture.pictureName, productName: dressPicture.productName, videoURL: dressPicture.videoURL, price: dressPicture.price, carouselProductPictures: dressPicture.carouselProductPictures))
             }
             
             print("product fetched")
             
         } catch {
             print("(fetchProductInfo) Une erreur est survenue lors de l'analyse JSON :  \(String(describing: error))")
         }
        
        self.dressPictures = internDressPictures
        return internDressPictures
        
        /*let textStorageURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/fonrose-ecommerce-v2.appspot.com/o/DressPictureData.json?alt=media&token=0bf1a35a-0ad0-44e5-b0a9-7d1053e0648a")!
        let task = URLSession.shared.dataTask(with: textStorageURL) { data, response, error in
            guard let data = data, error == nil else {
                print("Une erreur est survenue : \(String(describing: error))")
                return
            }
            do {
                let decoder = JSONDecoder()
                let dressPic = try decoder.decode([DressPictures].self, from: data)
                
                for dressPicture in dressPic {
                    print(dressPicture.price)
                    self.dressPictures.append(DressPictures(id: dressPicture.id, pictureName: dressPicture.pictureName, productName: dressPicture.productName, videoURL: dressPicture.videoURL, price: dressPicture.price, carouselProductPictures: dressPicture.carouselProductPictures))
                }
                self.infoFetched = true
                
            } catch {
                print("Une erreur est survenue lors de l'analyse JSON :  \(String(describing: error))")
            }
        }
        task.resume()*/
        
    }
    
    struct MainViewArrayElements: Identifiable, Codable {
        var id: Int
        var imageName: String
        var text: String
        var nextScreen: ViewEnum
    }
    
    //MARK: Fetch Main View Array Infos
    func fetchMainViewArrayInfos() async throws -> [MainViewArrayElements] {
        
        var mainViewArrayElements: [MainViewArrayElements] = []
        guard let storageURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/fonrose-ecommerce-v2.appspot.com/o/MainViewTextImages.json?alt=media&token=b461478e-7076-46c1-87f2-d578f3262c3b") else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        do {
            
            let (data, _) = try await URLSession.shared.data(from: storageURL)
            let arrayElements = try  JSONDecoder().decode([MainViewArrayElements].self, from: data)
            
            for ArrayElements in arrayElements {
                mainViewArrayElements.append(MainViewArrayElements(id: ArrayElements.id, imageName: ArrayElements.imageName, text: ArrayElements.text, nextScreen: ArrayElements.nextScreen))
            }
            
        } catch {
            print("(mainViewArrayElements) Une erreur est survenue lors de l'analyse JSON :  \(String(describing: error))")
        }
        
        return mainViewArrayElements
        
    }
    
    
    
    //
    //
    //
    //
    //
    //MARK: Measurements
    //
    //
    
    
    
    
    
    
    // cette fonction récupère les infos de type NeededMeasurementsModel depuis le fichier Json stocké dans GCS puis renvoie un tableau rempli de NeededMeasurementsModel avec les infos correspondantes
    func fetchNeededMeasurementsInfo() async throws -> [NeededMeasurementsModel] {
        
        var neededMeasurement: [NeededMeasurementsModel] = []
        
        guard let storageURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/fonrose-ecommerce-v2.appspot.com/o/NeededMeasurementsInfo.json?alt=media&token=bd0281da-b3c7-4c60-9e09-15160a1c6b54") else {
                throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            }
            
        /*let (_, response) = try await URLSession.shared.data(from: storageURL)
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw NSError(domain: "Invalid HTTP Response", code: 0, userInfo: nil)
            }*/
        
         do {
             let (data, _) = try await URLSession.shared.data(from: storageURL)
             let neededmeasurInfo = try  JSONDecoder().decode([NeededMeasurementsModel].self, from: data)
             
             for neededMeasurementInfo in neededmeasurInfo {
                 neededMeasurement.append(NeededMeasurementsModel(id: neededMeasurementInfo.id, productName: neededMeasurementInfo.productName, neededMeasurements: neededMeasurementInfo.neededMeasurements))
             }
             
         } catch {
             print("Une erreur est survenue lors de l'analyse JSON :  \(String(describing: error))")
         }
        
        return neededMeasurement
        
    }
    
    
    
    
    
    
    
    
    var allMeasurements: [MeasurementModel] = []
    
    func fetchAllMeasurementInfo() {
        
        let storageURL = URL(string:   "https://firebasestorage.googleapis.com/v0/b/fonrose-ecommerce-v2.appspot.com/o/MeasurementData.json?alt=media&token=f48b83af-ea18-4f35-9d55-bb817ac4bfbf")!
        let task = URLSession.shared.dataTask(with: storageURL) { data, response, error in
            guard let data = data, error == nil else {
                print("Une erreur est survenue : \(String(describing: error))")
                return
            }
            do {
                let decoder = JSONDecoder()
                let measurInfo = try decoder.decode([MeasurementModel].self, from: data)
                
                for measurement in measurInfo {
                    self.allMeasurements.append(MeasurementModel(id: measurement.id, measurementName: measurement.measurementName, measurementValue: measurement.measurementValue))
                }
                print("all measurements : \(self.allMeasurements.count)")
                
            } catch {
                print("Une erreur est survenue lors de l'analyse JSON :  \(String(describing: error))")
            }
            
        }
        
        task.resume()
        
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @Published var test2012: String = ""
    
    
    
    
    
    
   var neededMeasurements: [BigModel.MeasurementModel] = []
    
    //MARK: updateMeasurementModel
    var tabMeasurementModel: [MeasurementModel] = []
    var isMeasurementModelUpdated: Bool = false
    func updateMeasurementModel() async {
        
        self.neededMeasurements.removeAll()
        
        do {
            
            fetchAllMeasurementInfo()
            let fetchedNeededMeasurementIndexs = try await fetchNeededMeasurementsInfo()[self.dressPictures[self.selectedProductId ?? 0].id].neededMeasurements
            
            //if self.currentPersonIndex != nil {
                for i in 0..<fetchedNeededMeasurementIndexs.count {
                        
                        DispatchQueue.main.async {
                            self.neededMeasurements.append(self.allMeasurements[fetchedNeededMeasurementIndexs[i]])
                        }
                    
                }
                print("fetchedNeededMeasurementIndexs.count \(fetchedNeededMeasurementIndexs.count)")
                print("needed measurements count = \(neededMeasurements.count)")
            //} else {
                //print("current person nil")
            //}
            
            print("neededMeasurements \(neededMeasurements.count)")
            print(neededMeasurements.count)
            //print("measurements \(String(describing: self.user.persons[self.currentPersonIndex ?? 0].measurements?.measurements.count))")
            
        } catch {
            print("error")
        }
        print("fetch is done")
        
    }
    
    
    
    
    /*DispatchQueue.main.async {
     self.user.persons[self.currentPersonIndex ?? 0].measurements = []
     for i in 0..<self.neededMeasurement[self.selectedProductId ?? 0].neededMeasurements.count {
         self.user.persons[self.currentPersonIndex ?? 0].measurements?.append(self.allMeasurements[self.neededMeasurement[self.selectedProductId ?? 0].neededMeasurements[i]])
         print(self.user.persons[self.currentPersonIndex ?? 0].measurements?[i].measurementName)
        }
    }*/
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: Fetch Person
    @Published var selectedProductId: Int? = nil
    
    func fetchPerson() async {
        do {
            let userId: String = self.user.id!
            let collectionRef = try await db.collection("users").document("user\(userId)").collection("persons").getDocuments()
            
            var newlyLoadedPersons : [Person] = []
            //self.user.currentPersonIndex =
            //self.user.persons.removeAll()
            for document in collectionRef.documents {
                var person: Person = Person(email: "", name: "tt", orders: [])
                do {
                  person = try document.data(as: Person.self)
                  newlyLoadedPersons.append(person)
                  print(person.name)
                }
                catch {
                  print(error)
                }
                
            }
            print("On vient de charger \(newlyLoadedPersons.count) personnes")

            // Store the new loaded persons in the BigModel (we do this in the main thread because
            // the BigModel is bound to some views (and we want to avoid the "[SwiftUI] Publishing changes from background threads is not allowed"
            //  - As newlyLoadedPersons is going to be used in an async closure, its value needs to be stored
            //    in a constant to avoid the "Reference to captured var 'newlyLoadedPersons' in concurrently-executing code" error
            let constantNewlyLoadedPersons = newlyLoadedPersons
            DispatchQueue.main.async {
                self.user.persons = constantNewlyLoadedPersons
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }

    //MARK: Edit Person
    
    func editCurrentPersonNameInDb(newName: String, completion: (String) -> Void) {
        
        do {
            var person: Person = self.user.persons[self.currentPersonIndex!]
            let currentPersonID: String = self.user.persons[self.currentPersonIndex!].id!
            person.name = newName
            try db.collection("users").document("user\(auth.currentUser?.uid ?? "")").collection("persons").document(currentPersonID).setData(from: person)
            completion(newName)
        }
        catch {
            print(error.localizedDescription)
        }
        
    }
    
    //try db.collection("users").document("user\(auth.currentUser?.uid ?? "")").collection("persons").document().setData(from: BigModel.Person(email: newPersonEmail, name: newPersonName, orders: []))
    
        
    //MARK: Fetch Measurements
    func fetchMeasurements() async {
        
        do {
            guard let userId = auth.currentUser?.uid else { return }
            let collectionRef = try await db.collection("users").document("user\(userId)").collection("persons").document(self.currentPersonId).collection("Measurements").getDocuments()
            
            self.user.persons[self.currentPersonIndex ?? 0].measurements = Measurements(measurements: [])
            for document in collectionRef.documents {
                var measurements: Measurements = Measurements(measurements: [])
                do {
                    measurements = try document.data(as: Measurements.self)
                    self.user.persons[self.currentPersonIndex ?? 0].measurements = measurements
                    UserDefaults.standard.set(measurements.measurements[0].measurementValue, forKey: "measurementText0")
                    UserDefaults.standard.set(measurements.measurements[1].measurementValue, forKey: "measurementText1")
                    UserDefaults.standard.set(measurements.measurements[2].measurementValue, forKey: "measurementText2")
                    UserDefaults.standard.set(measurements.measurements[3].measurementValue, forKey: "measurementText3")
                    UserDefaults.standard.set(measurements.measurements[4].measurementValue, forKey: "measurementText4")
                    UserDefaults.standard.set(measurements.measurements[5].measurementValue, forKey: "measurementText5")
                    UserDefaults.standard.set(measurements.measurements[6].measurementValue, forKey: "measurementText6")
                    UserDefaults.standard.set(measurements.measurements[7].measurementValue, forKey: "measurementText7")
                    UserDefaults.standard.set(measurements.measurements[8].measurementValue, forKey: "measurementText8")
                    UserDefaults.standard.set(measurements.measurements[9].measurementValue, forKey: "measurementText9")
                    UserDefaults.standard.set(measurements.measurements[10].measurementValue, forKey: "measurementText10")
                    UserDefaults.standard.set(measurements.measurements[11].measurementValue, forKey: "measurementText11")
                }
                catch {
                    print(error)
                }
                
            }
                        
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    /*collection("users").document("user\(userId)").collection("persons").document(self.currentPersonId).*/
    
    
    
    
    
    //MARK: Fetch Location
    func fetchLocation() async {
        
        do {
         guard let userId = auth.currentUser?.uid else { return }
         let collectionRef = try await db.collection("users").document("user\(userId)").collection("persons").document(self.currentPersonId).collection("Location").getDocuments()
         
         self.user.persons[self.currentPersonIndex ?? 0].location = nil
         for document in collectionRef.documents {
             var location: Location? = nil
             do {
                 location = try document.data(as: Location.self)
                 self.user.persons[self.currentPersonIndex ?? 0].location = location
             }
             catch {
                 print(error)
             }
             
         }
         
        } catch {
             print(error.localizedDescription)
        }
    }
    
    
    func fetchOrders() {
        
        guard let userId = auth.currentUser?.uid else { return }
            
        let collectionRef = Firestore.firestore().collection("users").document("user\(userId)").collection("persons").document(self.currentPersonId).collection("Orders")
        
        collectionRef.getDocuments { snapshot, error in
            guard error == nil else {
                print("ERROR WHEN FETCHING LOCATION \(error!.localizedDescription)")
               return
            }

            if let snapshot = snapshot {
                for document in snapshot.documents {
                    do {
                        self.user.persons[self.currentPersonIndex ?? 0].orders = try document.data(as: [Order].self)
                    } catch {
                        print(error)
                    }
                }
            }
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func initializeMeasurements () async {
        
        fetchAllMeasurementInfo()
                    
            guard let userId = auth.currentUser?.uid else { return }
            let docRef = db.collection("users").document("user\(userId)").collection("persons").document(self.currentPersonId).collection("Measurements").document()
            var fbMeasurements: Measurements = Measurements(measurements: [])
            
            do {
                
                fbMeasurements.measurements = []
                for i in 0..<self.allMeasurements.count {
                    fbMeasurements.measurements.append(MeasurementModel(id: allMeasurements[i].id, measurementName: allMeasurements[i].measurementName, measurementValue: ""))
                }
                try docRef.setData(from: fbMeasurements)
            }
            catch {
                print(error)
            }
            
        }
    
    func initializeLocation() async {
        
        print(self.currentPersonId)
        guard let userId = auth.currentUser?.uid else { return }
        let docRef = db.collection("users").document("user\(userId)").collection("persons").document(self.currentPersonId).collection("Location").document()
        
        do {
            try docRef.setData(from: BigModel.Location(civility: "", firstName: "", lastName: "", emailAdress: "", phoneNumber: "", adressCountry: "", adressPostalCode: "", adressCity: "", adressStreet: "", adressMailBox: "", adressBasement: "", adressStage: ""))
        }
        catch {
            print(error)
        }
                
    }

    @Published var currentview = ViewEnum.Home_homeFeed0
    @Published var currentPopUpView = ViewEnum.Auth_LogInEmailView
    @Published var lastViews: [ViewEnum] = []
    @Published var fullViewHistory: [ViewEnum] = []
    @Published var previousView: ViewEnum? = nil
    
    //MARK: HomeFeed
    @Published var showMenu: Bool = false

    //MARK: Service Client
    @Published var orderID : String? = nil
    @Published var orderStatus : SuiviStatusEnum? = nil
    
    //MARK: Authentification
    @Published var currentUserName: String = ""
    
    let auth = Auth.auth()
    let db = Firestore.firestore()
    @Published var signedIn = false
    @Published var currentPersonIndex: Int? = nil
    @Published var currentPersonId: String = ""
    @Published var isPersonChosen = false
    @Published var isSignInPopUpPresented = false
    @Published var numberArray: [Int] = [0]
    
    //MARK: Persons
    @Published var personNumber: String = ""
    @Published var deletedPersonID: String = ""
    @Published var deletedPersonName: String = ""
    
    //
    //
    //
    //
    //
    //MARK: Auth
    //
    //
    
    func updateUserInfos() {
        
        DispatchQueue.main.async {
            Task {
                //self.user.id = self.auth.currentUser?.uid ?? "nil"
                //self.user = User(id: self.auth.currentUser?.uid ?? "error", email: self.auth.currentUser?.email ?? "error", persons: [])
                //self.signedIn = true
                
                // Charge les Person qui correspondent au User connecté (signedIn)
                await self.fetchPerson()
                
                if (self.user.persons.count != 0) && (self.currentPersonIndex != nil) {
                    self.authCurrentView = .Auth_UserInfo
                } else {
                    if self.user.persons.count == 0 {
                        self.authCurrentView = .HelpView
                    }
                    else {
                        self.authCurrentView = .Auth_PersonPickerView
                    }
                }
            }
        }
        
    }
    
    @Published var deletedPersonIndex: Int = 0
    
    func deleteAllPersons() {
        
        let docRef = db.collection("user\(self.auth.currentUser?.uid ?? "nil")").document("person\(personNumber)")
        
        docRef.delete() { err in
            
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                self.user.persons.removeAll()
                print("Document successfully removed!")
                
            }
        }
    }
    
    func deleteSelectedPerson() {
        
        db.collection("users").document("user\(Auth.auth().currentUser?.uid ?? "nil")").collection("persons").document(self.deletedPersonID).delete() { err in
             if let err = err {
                 print("Error removing document: \(err)")
             } else {
                 print("Document successfully removed!")
                 self.deletedPersonID = ""
             }
         }
        
    }
        
    
    //
    //
    //
    //
    // MARK: SIGN IN WITH APPLE
    //
    //
    //
    //
    
    @Published var authCurrentView =  ViewEnum.Auth_LogInEmailView
    @Published var authLastViews: [ViewEnum] = []
    
    func signInWithApple(inputID: String, inputEmail: String) {
        
        if inputID != "" {
            
            let docRef = self.db.collection("users").document("user\(inputID)")
            
            docRef.getDocument { (document, error) in
                if let document = document {
                    if document.exists {
                        do {
                            let jsonData = try document.data(as: User.self)
                            DispatchQueue.main.async {
                                Task {
                                    self.user = jsonData
                                    self.signedIn = true
                                    await self.fetchPerson()
                                    self.authCurrentView = .Auth_PersonPickerView
                                }
                            }
                        } catch {
                            print("Error decoding user data: \(error.localizedDescription)")
                        }
                    } else {
                        let newUser: User = User(id: inputID, email: inputEmail, persons: [])
                        self.db.collection("users").document(inputID).setData(["email": inputEmail])
                        Task {
                            self.user = newUser
                            self.signedIn = true
                            UserDefaults.standard.set(inputID, forKey: "ID")
                            UserDefaults.standard.set(inputEmail, forKey: "email")
                            UserDefaults.standard.set(true, forKey: "signedIn")
                            await self.fetchPerson()
                            self.authCurrentView = .Auth_PersonPickerView
                        }
                    }
                } else {
                    
                }
            }
            
        } else {
            print("connectUserID = ''")
        }
        
    }
    
    func signOut() {
        try? auth.signOut()
        self.signedIn = false
        print("current user id is \(self.auth.currentUser?.uid ?? "nil")")
        self.selectedProductId = nil
        self.isPersonChosen = false
        self.currentPersonIndex = nil
        self.currentPersonId = ""
        //self.lastUserID = ""
        self.user.id = ""
        self.user.email = ""
        self.user.persons = []
        UserDefaults.standard.set(false, forKey: "signedIn")
        UserDefaults.standard.set("", forKey: "ID")
        UserDefaults.standard.set("", forKey: "email")
        
        self.authCurrentView = .Auth_LogInEmailView
        
        self.signedIn = false
    }
    
    
    //
    //
    //
    //
    //
    
    
    //MARK: Finalize Order
    
    func addAnOrder(location: Location) {
                
        let newOrder =
        Order(
            productName: dressPictures[selectedProductId ?? 0].productName,
            status: .CommandeEnregistree,
            location: location,
            measurements: user.persons[currentPersonIndex ?? 0].measurements ?? Measurements(measurements: []), orderDate: Date(timeIntervalSinceNow: 0))
        
        let collectionRef = self.db.collection("Orders")
        
        guard let userId = auth.currentUser?.uid else { return }
            
        let collectionUserRef = Firestore.firestore().collection("users").document("user\(userId)").collection("persons").document(self.currentPersonId).collection("Orders")
        
        do {
            try collectionRef.document().setData(from: newOrder)
            try collectionUserRef.document().setData(from: newOrder)
          }
          catch {
            print(error)
          }
        
    }
    
    func fetchOrders() async throws {
        user.persons[currentPersonIndex ?? 0].orders.removeAll()
        
        guard let userId = auth.currentUser?.uid else { return }
        let collectionRef = try await Firestore.firestore().collection("users").document("user\(userId)").collection("persons").document(self.currentPersonId).collection("Orders").getDocuments()
        
        for document in collectionRef.documents {
            var order: Order
            do {
                order = try document.data(as: Order.self)
                self.user.persons[currentPersonIndex ?? 0].orders.append(order)
            }
            catch {
                print(error)
            }
            
        }
    }
    
    @Published var isMeasurements0Requested: Bool = false
    @Published var isMeasurements1Requested: Bool = false
    @Published var isMeasurements2Requested: Bool = false
    @Published var isMeasurements3Requested: Bool = false
    @Published var isMeasurements4Requested: Bool = false
    @Published var isMeasurements5Requested: Bool = false
    @Published var isMeasurements6Requested: Bool = false
    @Published var isMeasurements7Requested: Bool = false
    @Published var isMeasurements8Requested: Bool = false
    @Published var isMeasurements9Requested: Bool = false
    @Published var isMeasurements10Requested: Bool = false
    @Published var isMeasurements11Requested: Bool = false

    @Published var needToSeeEveryMeasurements: Bool = false
    
    func isMeasurementRequested(measurementName: String) async -> Bool {
        
        do {
            
            print("isMeasurementRequested neededMeasurements.count \(neededMeasurements.count)")
            
            for i in 0..<(neededMeasurements.count) {
                if measurementName == neededMeasurements[i].measurementName {
                    
                    print("return true")
                    print("neededMeasurements.count \(neededMeasurements.count)")
                    return true
                }
            }
        }
        
        
        print("return false")
        return false
        
    }
    
    
    func getRequestedMeasurements() async {
        
        await updateMeasurementModel()
        
        self.isMeasurements0Requested = await self.isMeasurementRequested(measurementName: "armpits-measurement")
        self.isMeasurements1Requested = await self.isMeasurementRequested(measurementName: "arms-length")
        self.isMeasurements2Requested = await self.isMeasurementRequested(measurementName: "head-measurement")
        self.isMeasurements3Requested = await self.isMeasurementRequested(measurementName: "pelvis-measurement")
        self.isMeasurements4Requested = await self.isMeasurementRequested(measurementName: "pelvis-knee")
        self.isMeasurements5Requested = await self.isMeasurementRequested(measurementName: "shoulders-measurement")
        self.isMeasurements6Requested = await self.isMeasurementRequested(measurementName: "shoulders-pelvis")
        self.isMeasurements7Requested = await self.isMeasurementRequested(measurementName: "chest-size")
        self.isMeasurements8Requested = await self.isMeasurementRequested(measurementName: "crotch")
        self.isMeasurements9Requested = await self.isMeasurementRequested(measurementName: "armpits-tits")
        self.isMeasurements10Requested = await self.isMeasurementRequested(measurementName: "tits-belly-button")
        self.isMeasurements11Requested = await self.isMeasurementRequested(measurementName: "tits-hips")
        
        DispatchQueue.main.async {
            self.currentview = .Measurement_Mensurations
        }
        
    }
    
    var neededMeasurementsTab: [MeasurementModel] = []
    
    
    
    
    //MARK: PAYMENT
    
    typealias PaymentCompletionHandler = (Bool) -> Void
    var paymentController: PKPaymentAuthorizationController?
    var paymentSummaryItems = [PKPaymentSummaryItem]()
    var paymentStatus = PKPaymentAuthorizationStatus.failure
    var completionHandler: PaymentCompletionHandler?
    var addressHandler: ((String) -> Void)?
    
    static let supportedNetworks: [PKPaymentNetwork] = [
        .visa,
        .masterCard
    ]
    
    func shippingMethodCalculator() -> [PKShippingMethod] {
        let today = Date()
        let calendar = Calendar.current
        
        let shippingStart = calendar.date(byAdding: .day, value: 5, to: today)
        let shippingEnd = calendar.date(byAdding: .day, value: 10, to: today)
        
        if let shippingEnd = shippingEnd, let shippingStart = shippingStart {
            let startComponents = calendar.dateComponents([.calendar, .year, .month, .day], from: shippingStart)
            let endComponents = calendar.dateComponents ([.calendar, .year, .month, .day], from: shippingEnd)
            
            let shippingDelivery = PKShippingMethod(label: "Delivery", amount: NSDecimalNumber(string: "0.00"))
            shippingDelivery.dateComponentsRange = PKDateComponentsRange(start: startComponents, end: endComponents)
            shippingDelivery.detail = "Sweaters sent to your address"
            shippingDelivery.identifier = "DELIVERY"
            return [shippingDelivery]
       }
        
        return []
        
    }
    
    func startPayment(products: [BigModel.DressPictures], total: Int, completion: @escaping PaymentCompletionHandler) {
            
        completionHandler = completion
        paymentSummaryItems = []
        
        BigModel.shared.dressPictures.forEach { product in
            let item = PKPaymentSummaryItem(label: product.productName, amount: NSDecimalNumber(string: "\(product.price) .00"), type: .final)
            paymentSummaryItems.append(item)
        }
        
        let total = PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(string: "\(total).00"), type: .final)
        paymentSummaryItems.append(total)
        
        let paymentRequest = PKPaymentRequest ()
        paymentRequest.paymentSummaryItems = paymentSummaryItems
        paymentRequest.merchantIdentifier = "merchant.com.fonrose.fonrose-ecommerceV2"
        paymentRequest.merchantCapabilities = .capability3DS
        paymentRequest.countryCode = "US"
        paymentRequest.currencyCode = "USD"
        paymentRequest.supportedNetworks = BigModel.supportedNetworks
        paymentRequest.shippingType = .delivery
        paymentRequest.shippingMethods = shippingMethodCalculator ()
        paymentRequest.requiredShippingContactFields = [.name, .postalAddress]
        
        paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
        paymentController?.delegate = self
        paymentController?.present(completion: { (presented: Bool) in
            if presented {
                debugPrint("Presented payment controller")
            } else {
                debugPrint("Failed to present payment controller")
            }
        })
    }
    
    @Published private(set) var paymentSuccess = false
    @Published private(set) var products: [DressPictures] = []
    @Published private(set) var total: Int = 0
    
    func updateTotal() {
        if self.selectedProductId != nil {
            self.total = self.dressPictures[self.selectedProductId ?? 0].price
        } else {
            print("no product selected")
        }
    }
    
    func pay() {
        startPayment(products: products, total: total) { success in
            self.paymentSuccess = success
            self.products = []
            self.total = 500
        }
    }
    
    
    
    
    
    
    

    
    func isThereAPersonWithTheSameName(name: String) -> Bool {
        for i in 0..<self.user.persons.count {
            if name == self.user.persons[i].name {
                return true
            }
        }
        return false
    }
    
    
    //
    //
    // SINGLETON
    //
    //
    
    public static var shared = BigModel()  // BigModel(shouldInjectMockedData:true)

    
    
    
    //
    //
    // MOCK FOR TESTING
    //
    //
    
    override init() {
        super.init()
        print("Constructor BigModel - default")
        signedIn = UserDefaults.standard.bool(forKey: "signedIn")
        if signedIn {
            let ID = UserDefaults.standard.string(forKey: "ID") ?? ""
            let email = UserDefaults.standard.string(forKey: "email") ?? ""
            signInWithApple(inputID: ID, inputEmail: email)
        }
    }

    init(shouldInjectMockedData: Bool) {
        print("Constructor BigModel - shouldInjectMockedData==true")
        
        let theMeasurement = Measurements(measurements: [MeasurementModel(id: 0, measurementName: "armpits", measurementValue: ""), MeasurementModel(id: 1, measurementName: "shoulders", measurementValue: ""), MeasurementModel(id: 2, measurementName: "legs", measurementValue: "")])
        let theLocation = Location(id: "idLocation", civility: "Mr", firstName: "Eglantine", lastName: "Fonrose", emailAdress: "egl@gmail.com", phoneNumber: "782068157", adressCountry: "France", adressPostalCode: "59300", adressCity: "Va", adressStreet: "3 rue bessmeres", adressMailBox: "3", adressBasement: "1", adressStage: "3")
        
        let person001 : Person = Person(id: "idPerson001", email: "eglantine.fonrose@gmail.com", name: "Eglantine Fonrose", measurements: theMeasurement, location: theLocation, orders: [])
        let person002 : Person = Person(id: "idPerson002", email: "malo.fonrose@gmail.com", name: "Malo Fonrose", measurements: theMeasurement, location: theLocation, orders: [Order(productName: "Robe", status: .CommandeEnregistree, location: theLocation, measurements: theMeasurement, orderDate: Date(timeIntervalSinceNow: 0))])
        //let person001: Person = Person(data: "data")
        //let person002: Person = Person(data: "data")
        let thePersons : [Person] = [ person001 , person002 ]

        self.user = User(id: "eee", email: "bfonrose@gmail.com", persons: [])
        
        self.selectedProductId = 0
        self.currentPersonIndex = 0 // Eglantine
    }
    
}

extension BigModel: PKPaymentAuthorizationControllerDelegate {
    
    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        // Handle payment authorization here
        
        // Accessing the shipping contact information
        let shippingContact = payment.shippingContact
        if let postalAddress = shippingContact?.postalAddress {
            
            var newLocation = user.persons[currentPersonIndex ?? 0].location ?? BigModel.Location(civility: "", firstName: "", lastName: "", emailAdress: "", phoneNumber: "", adressCountry: "", adressPostalCode: "", adressCity: "", adressStreet: "", adressMailBox: "", adressBasement: "", adressStage: "")
            newLocation.adressStreet = postalAddress.street
            newLocation.adressCity = postalAddress.city
            newLocation.adressCountry = postalAddress.country
            newLocation.adressPostalCode = postalAddress.postalCode
            print("postalAddress.street = \(postalAddress.street)")
            print("postalAddress.city = \(postalAddress.city)")
            print("postalAddress.country = \(postalAddress.country)")
            print("postalAddress.postalCode = \(postalAddress.postalCode)")
            
            // Printing the postal address to the console
            if currentPersonIndex != nil && user.persons[currentPersonIndex ?? 0].location != nil  {
                
                addAnOrder(location: newLocation)
                
                /*for i in 0..<bigModel.user.persons[bigModel.currentPersonIndex].orders.count {
                    
                    guard let userID = Auth.auth().currentUser?.uid else {return}
                    
                    let docRef = db.collection("users").document("user\(userID)")

                      docRef.getDocument { document, error in
                        if let error = error as NSError? {
                          self.errorMessage = "Error getting document: \(error.localizedDescription)"
                        }
                        else {
                          if let document = document {
                            do {
                              self.book = try document.data(as: Book.self)
                            }
                            catch {
                              print(error)
                            }
                          }
                        }
                      }
                }*/
                
            }
        }
        
        // Complete the payment authorization process
        let paymentAuthorizationResult = PKPaymentAuthorizationResult(status: .success, errors: nil)
        completion(paymentAuthorizationResult)
    }
    
    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        // Dismiss the payment authorization controller
        controller.dismiss(completion: nil)
    }
    
}

extension UIApplication {
    
    func rootController()->UIViewController {
        guard let window = connectedScenes.first as? UIWindowScene else {return .init()}
        guard let viewcontroller = window.windows.last?.rootViewController else {return .init()}
        return viewcontroller
    }
    
}

extension View {
    func getRootViewController () -> UIViewController {
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        guard let root = screen.windows.first?.rootViewController else {
            return.init()
        }
        return root
    }
}
