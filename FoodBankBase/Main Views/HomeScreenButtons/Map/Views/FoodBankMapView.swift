//
//  FoodBankMapView.swift
//  FoodBankBase
//
//  Created by Ben Roberts on 10/12/21.
//

import SwiftUI
import MapKit

struct place: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    let image: String
    let color: String
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct FoodBankMapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 47.66558123405208,
            longitude: -122.38048848981833
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.08,
            longitudeDelta: 0.08
        )
    )
    
    let places = [
        place(name: "Ballard Food Bank", latitude: 47.66558123405208, longitude: -122.38048848981833, image: "gearshape.fill", color: "customOrange"),
        place(name: "Sound Health", latitude: 47.662342, longitude: -122.341719, image: "cross.circle", color: "customRed"),
        place(name: "Ballard Library", latitude: 47.66981, longitude: -122.384271, image: "book.circle", color: "customPurple"),
        place(name: "Wallingford Foodbank", latitude: 47.692046, longitude: -122.355477, image: "house", color: "wallingfordPurple")
        // place(name: "Queen Anne Foodbank", latitude: 47.622258334842456, longitude: -122.35386959247157, image: "heart.circle", color: "wallingfordPurple")
    ]
    
    @Environment(\.presentationMode) var presentation

    var body: some View {
        ScrollView {
            VStack {
                Map(coordinateRegion: $region, annotationItems: places) { place in
                    MapAnnotation(coordinate: place.coordinate, anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
                        Image(systemName: place.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 25, height: 25)
                            .clipShape(Circle())
                            .foregroundColor(Color(place.color))
                    }
                }
                .frame(width: 400, height: 450)
                .padding(.top)
                Divider()
                HStack {
                    Spacer()
                    Spacer()
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                        .foregroundColor(Color("customOrange"))
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Ballard Food Bank") // 17
                            .foregroundColor(Color("navyBlue"))
                            .font(.custom("HelveticaNeue-Medium", size: 20))
                        Text("Food, mail, ect.")// 16
                            .foregroundColor(Color("textGrey"))
                            .font(.custom("HelveticaNeue-Medium", size: 16))
                    }
                    Spacer()
                    Text("1400 NW LEARY WAY" ) // 19
                        .foregroundColor(Color("textGrey"))
                        .font(.custom("HelveticaNeue-Medium", size: 14))
                    Spacer()
                }
                Divider()
                HStack {
                    Spacer()
                    Spacer()
                    Image(systemName: "cross.circle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                        .foregroundColor(Color("customRed"))
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Sound Health Clinic") // 17
                            .foregroundColor(Color("navyBlue"))
                            .font(.custom("HelveticaNeue-Medium", size: 20))
                        Text("Mental/substance health")// 16
                            .foregroundColor(Color("textGrey"))
                            .font(.custom("HelveticaNeue-Medium", size: 16))
                    }
                    Spacer()
                    Text("   4200 Stone Way N") // 17
                        .foregroundColor(Color("textGrey"))
                        .font(.custom("HelveticaNeue-Medium", size: 14))
                    Spacer()
                }
                Divider()
                HStack {
                    Spacer()
                    Spacer()
                    Image(systemName: "book.circle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                        .foregroundColor(Color("customPurple"))
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Ballard Library SPL") // 17
                            .foregroundColor(Color("navyBlue"))
                            .font(.custom("HelveticaNeue-Medium", size: 20))
                        Text("Computers, Wi-Fi ")// 16
                            .foregroundColor(Color("textGrey"))
                            .font(.custom("HelveticaNeue-Medium", size: 16))
                    }
                    Spacer()
                    Text("5614 22nd Ave. N.W.") // 19
                        .foregroundColor(Color("textGrey"))
                        .font(.custom("HelveticaNeue-Medium", size: 14))
                    Spacer()
                }
                Divider()
                HStack {
                    Spacer()
                    Spacer()
                    Image(systemName: "house")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                        .foregroundColor(Color("wallingfordPurple"))
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Greenwood Food") // 20
                            .foregroundColor(Color("navyBlue"))
                            .font(.custom("HelveticaNeue-Medium", size: 20))
                        Text("Food/family resources")//
                            .foregroundColor(Color("textGrey"))
                            .font(.custom("HelveticaNeue-Medium", size: 16))
                    }
                    Spacer()
                    Text("1501 North 45th Street") // 19
                        .foregroundColor(Color("textGrey"))
                        .font(.custom("HelveticaNeue-Medium", size: 14))
                    Spacer()
                }
                Divider()
                /*HStack {
                    Spacer()
                    Spacer()
                    Image(systemName: "heart.circle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                        .foregroundColor(Color("queenAnneGreen"))
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Queen Anne Food") // 17
                            .foregroundColor(Color("navyBlue"))
                            .font(.custom("HelveticaNeue-Medium", size: 20))
                        Text("Food and resources")// 16
                            .foregroundColor(Color("textGrey"))
                            .font(.custom("HelveticaNeue-Medium", size: 16))
                    }
                    Spacer()
                    Text("205 2nd Ave N") // 19
                        .foregroundColor(Color("textGrey"))
                        .font(.custom("HelveticaNeue-Medium", size: 14))
                    Spacer()
                }
                 */
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Map")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(action: { presentation.wrappedValue.dismiss()
            }, label: {
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
