//
//  AccountSettingsView.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 6/15/21.
//

import SwiftUI
import UserNotifications

struct AccountSettingsView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var user: FirebaseUserViewModel

    var body: some View {
        VStack {
            Form {
                Text("Name: \(self.user.userInfo.firstName) \(self.user.userInfo.lastName)")
                /*Button("Request Permission") {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            print("All set!")
                        } else if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                }

                Button("Schedule Notification") {
                    let content = UNMutableNotificationContent()
                    content.title = "Event"
                    content.subtitle = "Foodbank Event"
                    content.sound = UNNotificationSound.default

                    // show this notification five seconds from now
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                    // choose a random identifier
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                    // add our notification request
                    UNUserNotificationCenter.current().add(request)
                }
                */
                Button(action: {
                    self.user.logoutUser { (result) in
                        switch result {
                        case .failure(let error):
                            print(error)
                        case .success(_):
                            print("Logged User Out")
                        }
                    }
                }, label: {
                    Text("Log Out")
                })
                .accentColor(.red)
            }
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Account Settings")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(action: { presentation.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "arrow.backward")
                    .imageScale(.large)
            }),
            trailing: Button(action: {
                self.user.logoutUser { (result) in
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(_):
                        print("Logged Out User")
                    }
                }
            }, label: {
                Text("Log Out")
            })
        )
    }
}

struct AccountSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSettingsView()
            .environmentObject(FirebaseUserViewModel())
    }
}
