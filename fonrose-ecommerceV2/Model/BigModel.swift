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

class BigModel : ObservableObject {
    
    //fonction qui crée un textfield
    
    func creerTextField(placeholder: String, text: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.text = text
        return textField
    }
    
    @Published var user: User = User(id: "", email: "", persons: [])
        
    @Published var signInErrorMessage = ""
    @Published var signOutErrorMessage = ""
    /*@Published var defaultLocationCoordinate = CLLocationCoordinate2D(latitude: 55, longitude: 25)
    @Published var userDBLat: CGFloat = 50.073658
    @Published var userDBLong: CGFloat = 14.418540*/
    
    //MARK: UserModel
    struct User: Identifiable, Codable {
        var id: String = UUID().uuidString
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
        var id: Int?
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
        var id = UUID().uuidString
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
        var price: String
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

    // cette fonction récupère les infos de type NeededMeasurementsModel depuis le fichier Json stocké dans GCS puis renvoie un tableau rempli de NeededMeasurementsModel avec les infos correspondantes
    func fetchNeededMeasurementsInfo() async throws -> [NeededMeasurementsModel] {
        
        /*{
         
         var mainViewArrayElements: [MainViewArrayElements] = []
         let storageURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/fonrose-ecommerce-v2.appspot.com/o/NeededMeasurementsInfo.json?alt=media&token=bd0281da-b3c7-4c60-9e09-15160a1c6b54")!
         
         do {
             
             let (data, _) = try await URLSession.shared.data(from: storageURL)
             let arrayElements = try  JSONDecoder().decode([MainViewArrayElements].self, from: data)
             
             for ArrayElements in arrayElements {
                 mainViewArrayElements.append(MainViewArrayElements(id: ArrayElements.id, imageName: ArrayElements.imageName, text: ArrayElements.text))
             }
             
         } catch {
             print("Une erreur est survenue lors de l'analyse JSON :  \(String(describing: error))")
         }
         
         return mainViewArrayElements
         
     }*/
        
        var neededMeasurement: [NeededMeasurementsModel] = []
        //let storageURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/fonrose-ecommerce-v2.appspot.com/o/NeededMeasurementsInfo.json?alt=media&token=bd0281da-b3c7-4c60-9e09-15160a1c6b54")!
        
        guard let storageURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/fonrose-ecommerce-v2.appspot.com/o/NeededMeasurementsInfo.json?alt=media&token=bd0281da-b3c7-4c60-9e09-15160a1c6b54") else {
                throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            }
            
        let (_, response) = try await URLSession.shared.data(from: storageURL)
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw NSError(domain: "Invalid HTTP Response", code: 0, userInfo: nil)
            }
        
         do {
             let (data, _) = try await URLSession.shared.data(from: storageURL)
             let neededmeasurInfo = try  JSONDecoder().decode([NeededMeasurementsModel].self, from: data)
             
             for neededMeasurementInfo in neededmeasurInfo {
                 neededMeasurement.append(BigModel.NeededMeasurementsModel(id: neededMeasurementInfo.id, productName: neededMeasurementInfo.productName, neededMeasurements: neededMeasurementInfo.neededMeasurements))
             }
             
             print("done")
             
         } catch {
             print("Une erreur est survenue lors de l'analyse JSON :  \(String(describing: error))")
         }
        
        return neededMeasurement
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    var measurementTab: [MeasurementModel] = []
    
    //MARK: updateMeasurementModel
    var isMeasurementModelUpdated: Bool = false
    func updatedMeasurementModel() async -> [MeasurementModel] {
        
        self.user.persons[self.currentPersonIndex ?? 0].measurements?.measurements.removeAll()
        
        do {
            
            let fetchedNeededMeasurementIndexs = try await fetchNeededMeasurementsInfo()[self.dressPictures[self.selectedProductId ?? 0].id ].neededMeasurements
            
            if self.currentPersonIndex != nil {
                for i in 0..<fetchedNeededMeasurementIndexs.count {
                    
                    Task {
                        
                        DispatchQueue.main.async {
                            //self.user.persons[self.currentPersonIndex ?? 0].measurements?.measurements.append(self.allMeasurements[fetchedNeededMeasurementIndexs[i]])
                            //print(self.allMeasurements[fetchedNeededMeasurementIndexs[i]].measurementName)
                            self.measurementTab.append(self.allMeasurements[fetchedNeededMeasurementIndexs[i]])
                            print("append")
                        }
                        
                    }
                    
                }
            } else {
                print("current person nil")
            }
            
            print(fetchedNeededMeasurementIndexs.count)
            
            //print("measurements \(String(describing: self.user.persons[self.currentPersonIndex ?? 0].measurements?.measurements.count))")
            
        } catch {
            print("error")
        }
        
        return measurementTab
        
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
            guard let userId = auth.currentUser?.uid else { return }
            let collectionRef = try await db.collection("users").document("user\(userId)").collection("persons").getDocuments()
            
            self.user.persons.removeAll()
            for document in collectionRef.documents {
                var person: Person = Person(email: "", name: "tt", orders: [])
                do {
                  person = try document.data(as: Person.self)
                    self.user.persons.append(person)
                    print(person.id)
                }
                catch {
                  print(error)
                }
                
            }
            
            print("Il y a \(self.user.persons.count) personnes")
            
        } catch {
            print(error.localizedDescription)
        }
    }

    
        
    //MARK: Fetch Measurements
    func fetchMeasurements() {
        
        /*guard let userId = auth.currentUser?.uid else { return }
        
        self.db.collection("users").document("user\(userId)").collection("persons").document(self.currentPersonId).collection("Measurements").getDocuments { [self] snapshot, error in
            
            guard error == nil else {
                print("ERROR WHEN FETCHING MEASUREMENTS \(error!.localizedDescription)")
                return
            }
                  
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let dbArmpitsMeasurement = document.data()["ArmpitsMeasurement"] as? String ?? "nil"
                    let dbArmsLength = document.data()["ArmsLength"] as? String ?? "nil"
                    let dbHeadMeasurement = document.data()["HeadMeasurement"] as? String ?? "nil"
                    let dbPelvisMeasurement = document.data()["PelvisMeasurement"] as? String ?? "nil"
                    let dbPelvisKnee = document.data()["PelvisKnee"] as? String ?? "nil"
                    let dbShouldersMeasurement = document.data()["ShouldersMeasurement"] as? String ?? "nil"
                    let dbShouldersPelvis = document.data()["ShouldersPelvis"] as? String ?? "nil"
                    
                    //ajout des données de mensurations à la personne sélectionnée du tableau personne, donc à la personne venant d'être crée
                    self.user.persons[self.currentPersonIndex].measurements = BigModel.Measurements(id: document.documentID, ArmpitsMeasurement: dbArmpitsMeasurement, ArmsLength: dbArmsLength, HeadMeasurement: dbHeadMeasurement, PelvisMeasurement: dbPelvisMeasurement, PelvisKnee: dbPelvisKnee, ShouldersMeasurement: dbShouldersMeasurement, ShouldersPelvis: dbShouldersPelvis)
                    
                }
                print("measurements fetched \(self.currentPersonId)")
            }
            
        }*/
        
        /*guard let userId = auth.currentUser?.uid else { return }
            
        let collectionRef = Firestore.firestore().collection("users").document("user\(userId)").collection("persons").document(self.currentPersonId).collection("Measurements")
        
        collectionRef.getDocuments { snapshot, error in
            guard error == nil else {
                print("ERROR WHEN FETCHING MEASUREMENTS \(error!.localizedDescription)")
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    do {
                        self.user.persons[self.currentPersonIndex].measurements = try document.data(as: Measurements.self)
                    } catch {
                        print(error)
                    }
                }
            }
        }*/
    }
    
    
    
    
    
    
    
    
    
    
    
    /*collection("users").document("user\(userId)").collection("persons").document(self.currentPersonId).*/
    
    
    
    
    
    //MARK: Fetch Location
    func fetchLocation() {
        
        //fetch location
        guard let userId = auth.currentUser?.uid else { return }
            
        let collectionRef = Firestore.firestore().collection("users").document("user\(userId)").collection("persons").document(self.currentPersonId).collection("Location")
        
        collectionRef.getDocuments { snapshot, error in
            guard error == nil else {
                print("ERROR WHEN FETCHING LOCATION \(error!.localizedDescription)")
               return
            }

            if let snapshot = snapshot {
                for document in snapshot.documents {
                    do {
                        self.user.persons[self.currentPersonIndex ?? 0].location = try document.data(as: Location.self)
                    } catch {
                        print(error)
                    }
                }
            }
        }
        
        /*{ snapshot, error in
            
            guard error == nil else {
                print("ERROR WHEN FETCHING LOCATION \(error!.localizedDescription)")
               return
            }
                  
            if let snapshot = snapshot {
                
                for document in snapshot.documents {

                    let dbCivility = document.data()["civility"] as? String ?? ""
                    let dbFirstName = document.data()["firstName"] as? String ?? ""
                    let dbLastName = document.data()["lastName"] as? String ?? ""
                    let dbEmailAdress = document.data()["emailAdress"] as? String ?? ""
                    let dbPhoneNumber = document.data()["phoneNumber"] as? String ?? ""
                    let dbAdressCountry = document.data()["adressCountry"] as? String ?? ""
                    let dbAdressPostalCode = document.data()["adressPostalCode"] as? String ?? ""
                    let dbAdressCity = document.data()["adressCity"] as? String ?? ""
                    let dbAdressStreet = document.data()["adressStreet"] as? String ?? ""
                    let dbAdressMailBox = document.data()["adressMailBox"] as? String ?? ""
                    let dbAdressBasement = document.data()["adressBasement"] as? String ?? ""
                    let dbAdressStage = document.data()["adressStage"] as? String ?? ""
                    let dbAdressLat = document.data()["adressLat"] as? CGFloat ?? 44
                    let dbAdressLong = document.data()["adressLong"] as? CGFloat ?? 44

                    self.user.persons[self.currentPersonIndex].location = BigModel.Location(id: document.documentID, civility: dbCivility, firstName: dbFirstName, lastName: dbLastName, emailAdress: dbEmailAdress, phoneNumber: dbPhoneNumber, adressCountry: dbAdressCountry, adressPostalCode: dbAdressPostalCode, adressCity: dbAdressCity, adressStreet: dbAdressStreet, adressMailBox: dbAdressMailBox, adressBasement: dbAdressBasement, adressStage: dbAdressStage, adressLat: dbAdressLat, adressLong: dbAdressLong)

                }
                
                print("location infos fetched \(self.currentPersonId)")
                
            }
            
        }*/
        
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func initializeMeasurements() {
        
        guard let userId = auth.currentUser?.uid else { return }
        let docRef = db.collection("users").document("user\(userId)").collection("persons").document(self.currentPersonId).collection("Measurements").document()
        
        do {
            try docRef.setData(from: BigModel.MeasurementModel(measurementName: "", measurementValue: ""))
        }
        catch {
            print(error)
        }
        //db.collection("users").document("user\(userId)").collection("persons").document(self.currentPersonId).collection("Measurements").document().setData(["ArmpitsMeasurement": "", "ArmsLength": "", "HeadMeasurement": "", "PelvisMeasurement": "", "PelvisKnee": "", "ShouldersMeasurement": "", "ShouldersPelvis": ""])
        
    }
    
    func initializeLocation() {
        
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
    @Published var currentPopUpView = ViewEnum.Auth_SignInView
    @Published var lastViews: [ViewEnum] = []
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
    
    func signIn(email: String, password: String) {
        
        //[weak self] sert à ce que Xcode considère les variables email et password comme des "Strongs References" pour pas qu'elles soient effacées si jamais elles ne servent pas
        // !!!!!! il faut que l'adresse email soit valide et que le mdp ait + de 6 caractères, sinon erreur
    
        auth.signIn(withEmail: email, password: password) { Result, Error in
            guard Result != nil, Error == nil else {
                print((Error != nil) ? "error message = \(String(describing: Error?.localizedDescription))" : "no error")
                self.signInErrorMessage = Error?.localizedDescription ?? ""
                return
            }
            
            print("sign in")
            print(self.auth.currentUser?.uid ?? "fck")
            
            self.user = User(id: self.auth.currentUser?.uid ?? "error", email: self.auth.currentUser?.email ?? "error", persons: [])
            //self.fetchPerson()
            self.authCurrentView = .Auth_PersonPickerView
        }
    }
    
    //MARK: Des modifications de l'appli à la db Firebase
    func newUserSignIn(email: String, password: String) {
        
        //[weak self] sert à ce que Xcode considère les variables email et password comme des "Strongs References" pour pas qu'elles soient effacées si jamais elles ne servent pas
        // !!!!!! il faut que l'adresse email soit valide et que le mdp ait + de 6 caractères, sinon erreur
        auth.signIn(withEmail: email, password: password) { [weak self] Result, Error in
            guard Result != nil, Error == nil else {
                print((Error != nil) ? "error message = \(Error.debugDescription)" : "no error")
                return
            }
            
            DispatchQueue.main.async {
                self!.signedIn = true
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
    
    //MARK: Sign up
    
    @Published var authCurrentView =  ViewEnum.Auth_SignInView
    @Published var authLastViews: [ViewEnum] = []
    
    var newUserAccountEmail: String = ""
    var newUserAccountPassword: String = ""
    
    func signUp(newUserEmail: String, newUserPassword: String) {
        
        auth.createUser(withEmail: newUserEmail, password: newUserPassword) { Result, Error in
            guard Result != nil, Error == nil else {
                self.signOutErrorMessage = Error?.localizedDescription ?? ""
                return
            }

            self.db.collection("users").document("user\(self.auth.currentUser?.uid ?? "nil")").setData(["email": self.auth.currentUser?.email ?? "no email"])
            self.user.id = self.auth.currentUser?.uid ?? "nil"
            self.user.email = self.auth.currentUser?.email ?? "nil"
            self.currentPersonIndex = nil
            self.signedIn = true
            self.authCurrentView = .Auth_PersonPickerView
            
        }
    
    }
    
    var newEmail: String = ""
    
    func changeEmailAdress(_ newValue : String) {
        newEmail = newValue
        objectWillChange.send()
    }
    
    var newPassword: String = ""
    
    func changePassword(_ newValue : String) {
        newPassword = newValue
        objectWillChange.send()
    }
    
    func signOut() {
        try? auth.signOut()
        self.signedIn = false
        print("current user id is \(self.auth.currentUser?.uid ?? "nil")")
        
        self.isPersonChosen = false
        self.user.id = ""
        self.user.email = ""
        self.user.persons = []
        
        self.currentview = .Home_homeFeed0
        self.authCurrentView = .Auth_SignInView
        
        self.signedIn = false
    }
    
    
    //
    //
    //
    //
    // SIGN IN WITH PHONE NUMBER
    //
    //
    //
    //
    
    
    @Published var mobileNo: String = ""
    @Published var otpCode: String = ""
    @Published var CLIENT_CODE: String = ""
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    func getOTPCode() {
        UIApplication.shared.closeKeyboard()
        Task {
            do {
                Auth.auth().settings?.isAppVerificationDisabledForTesting = true
                let code = try await PhoneAuthProvider.provider().verifyPhoneNumber("+\(mobileNo)", uiDelegate: nil)
                
                await MainActor.run(body: {
                    CLIENT_CODE = code
                })
                
            } catch {
                await handleError(error: error)
            }
        }
    }
    
    func verifyOTPCode() {
        UIApplication.shared.closeKeyboard()
        Task {
            // do : si il n'y a pas d'erreur lors de l'appel de la fonction Auth.auth().signIn(with: credential)
            do {
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: CLIENT_CODE, verificationCode: otpCode)
                // try await dit au programme d'attendre la réponse de la fonction Auth.auth().signIn avant d'éxecuter la suite (print("Success !"))
                try await Auth.auth().signIn(with: credential)
                print("Success !")
                
                DispatchQueue.main.async {
                    Task {
                        self.signedIn = true
                        await self.fetchPerson()
                        self.authCurrentView = .Auth_PersonPickerView
                        self.user.id = self.auth.currentUser?.uid ?? "nil"
                    }
                }
                
            } catch {
                // catch : si il y a une erreur, les lignes suivantes sont executées
                await handleError(error: error)
                print(error.localizedDescription)
            }
        }
    }
    
    func handleError(error: Error) async {
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            print(errorMessage)
            showError.toggle()
        })
    }
    
    
    //
    //
    //
    //
    //
    
    
    //MARK: Finalize Order
    
    func addAnOrder(location: Location, measurements: [MeasurementModel], productName: String) {
                
        let newOrder =
        Order(
            productName: dressPictures[selectedProductId ?? 0].productName,
            status: .CommandeEnregistree,
            location: user.persons[currentPersonIndex ?? 0].location ?? Location(civility: "", firstName: "", lastName: "", emailAdress: "", phoneNumber: "", adressCountry: "", adressPostalCode: "", adressCity: "", adressStreet: "", adressMailBox: "", adressBasement: "", adressStage: ""),
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
    
    func isMeasurementRequested(measurementName: String) -> Bool {
        for i in 0..<(self.user.persons[self.currentPersonIndex ?? 0].measurements?.measurements.count ?? 0) {
            if measurementName == self.user.persons[self.currentPersonIndex ?? 0].measurements?.measurements[i].measurementName ?? "Armpits measurement" {
                return true
            }
        }
        return false
    }
    
    /*let collectionRef = try await db.collection("users").document("user\(userId)").collection("persons").getDocuments()
     
     self.user.persons.removeAll()
     for document in collectionRef.documents {
         var person: Person = Person(email: "", name: "tt", orders: [])
         do {
           person = try document.data(as: Person.self)
             self.user.persons.append(person)
             print(person.id)
         }
         catch {
           print(error)
         }
         
     }*/
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
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
    
    init() {
        print("Constructor BigModel - default")
    }

    init(shouldInjectMockedData: Bool) {
        print("Constructor BigModel - shouldInjectMockedData==true")
        
        let theMeasurement = Measurements(measurements: [MeasurementModel(measurementName: "armpits", measurementValue: ""), MeasurementModel(measurementName: "shoulders", measurementValue: ""), MeasurementModel(measurementName: "legs", measurementValue: "")])
        let theLocation = Location(id: "idLocation", civility: "Mr", firstName: "Eglantine", lastName: "Fonrose", emailAdress: "egl@gmail.com", phoneNumber: "782068157", adressCountry: "France", adressPostalCode: "59300", adressCity: "Va", adressStreet: "3 rue bessmeres", adressMailBox: "3", adressBasement: "1", adressStage: "3")
        
        let person001 : Person = Person(id: "idPerson001", email: "eglantine.fonrose@gmail.com", name: "Eglantine Fonrose", measurements: theMeasurement, location: theLocation, orders: [])
        let person002 : Person = Person(id: "idPerson002", email: "malo.fonrose@gmail.com", name: "Malo Fonrose", measurements: theMeasurement, location: theLocation, orders: [Order(productName: "Robe", status: .CommandeEnregistree, location: theLocation, measurements: theMeasurement, orderDate: Date(timeIntervalSinceNow: 0))])
        //let person001: Person = Person(data: "data")
        //let person002: Person = Person(data: "data")
        let thePersons : [Person] = [ person001 , person002 ]

        self.user = User(id: "eee", email: "bfonrose@gmail.com", persons: thePersons)
        
        self.currentPersonIndex = 0 // Eglantine
    }

    
}
