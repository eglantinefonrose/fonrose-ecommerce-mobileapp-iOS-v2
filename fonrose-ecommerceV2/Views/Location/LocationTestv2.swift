//
//  LocationTest.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine Fonrose on 24/04/2024.
//  Copyright © 2024 fonrose. All rights reserved.
//

import SwiftUI
import MapKit

struct AddressSearchView: View {
    @State private var searchText = ""
    @State private var searchResults: [MKMapItem] = []
    @State private var isSearching = false

    var body: some View {
        VStack {
            SearchBarTest(text: $searchText, isSearching: $isSearching)

            List(searchResults, id: \.self) { mapItem in
                Text("\(mapItem.name ?? "Unknown"), \(mapItem.placemark.locality ?? ""), \(mapItem.placemark.postalCode ?? ""), \(mapItem.placemark.country ?? "")")
            }
        }
        .onChange(of: searchText) { _ in
            search()
        }
    }

    private func search() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        let search = MKLocalSearch(request: request)

        search.start { response, _ in
            guard let response = response else {
                return
            }

            DispatchQueue.main.async {
                self.searchResults = response.mapItems
            }
        }
    }
}

struct SearchBarTest: View {
    @Binding var text: String
    @Binding var isSearching: Bool

    var body: some View {
        HStack {
            TextField("Search for an address", text: $text)
                .padding(.leading, 24)
                .autocorrectionDisabled()
                .onChange(of: text) { _ in
                    isSearching = true
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)

            if isSearching {
                Button(action: {
                    withAnimation {
                        text = ""
                        isSearching = false
                    }
                }) {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(.gray)
                        .padding(.trailing, 8)
                }
                .transition(.move(edge: .trailing))
            }
        }
        .padding(.horizontal)
    }
}

struct AddressSearchView_Previews: PreviewProvider {
    static var previews: some View {
        AddressSearchView()
    }
}
