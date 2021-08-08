//
//  FoodBankMapView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 7/3/21.
//

import SwiftUI
import MapKit

struct FoodBankMapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 47.66558123405208,
            longitude: -122.38048848981833
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.05,
            longitudeDelta: 0.05
        )
    )
    
    @Environment(\.presentationMode) var presentation

    let locations: [Location] = [
        Location(
            name: "Ballard Food Bank",
            coordinate:
                CLLocationCoordinate2D(
                    latitude: 47.66558123405208,
                    longitude: -122.38048848981833
                )
        )
    ]

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: locations) { location in
            MapAnnotation(coordinate: location.coordinate, anchorPoint: CGPoint(x: 1, y: 1)) {
                Circle()
                    .fill()
                    .foregroundColor(.red)
                    .frame(width: 50, height: 50, alignment: .center)
                    .background(
                        Rectangle()
                            .rotation(Angle(degrees: 45))
                            .foregroundColor(.red)
                            .clipShape(
                                Rectangle()
                                    .offset(x: 10, y: 10.0)
                            )
                            .clipShape(
                                Rectangle()
                                    .offset(x: -10, y: 10.0)
                            )
                    )

            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Map")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(action: { presentation.wrappedValue.dismiss()
            }
            , label: {
                Image(systemName: "arrow.backward")
                    .imageScale(.large)
                    .accentColor(Color("darkInvert"))
            })
        )
    }
}

struct FoodBankMapView_Previews: PreviewProvider {
    static var previews: some View {
        FoodBankMapView()
    }
}
