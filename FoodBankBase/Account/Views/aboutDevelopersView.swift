//
//  aboutDevelopersView.swift
//  FoodBankBase
//
//  Created by Benjamin Roberts on 9/4/21.
//

import SwiftUI

struct aboutDevelopersView: View {
    @Environment(\.presentationMode) var presentation
    var body: some View {
        VStack {
            Text("Food&Share was developed by Ben Roberts and Ian Holloway in collaboration with the Ballard Foodbank. We are currently attending highschool in the Seattle area, and we love coding on projects like this. Please feel free to reach out to us at benradroberts@gmail.com and ianholloway@gmail.com")
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color("darkInvert"))
                .font(.custom("HelveticaNeue-Medium", size: 16))
                .padding()
                .padding(.horizontal)
            Spacer()
                .navigationBarTitleDisplayMode(.large)
                .navigationTitle("About the Developers")
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(
                    leading: Button(action: { presentation.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "arrow.backward")
                            .imageScale(.large)
                }))
        }
    }
}

struct aboutDevelopersView_Previews: PreviewProvider {
    static var previews: some View {
        aboutDevelopersView()
    }
}
