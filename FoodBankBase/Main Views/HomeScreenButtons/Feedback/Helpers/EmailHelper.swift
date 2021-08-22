//
//  EmailHelper.swift
//  FoodBankBase
//
//  Created by Brian Holloway on 8/8/21.
//

import Foundation
import MessageUI

class EmailHelper: NSObject, MFMailComposeViewControllerDelegate {
    static var shared = EmailHelper()
    private override init() {
        //
    }

    func sendEmail(subject: String, body: String, sendTo: String) {
        if !MFMailComposeViewController.canSendMail() {
            print("No mail account found")
            // Todo: Add a way to show banner to user about no mail app found or configured
            // Utilities.showErrorBanner(title: "No mail account found", subtitle: "Please setup a mail account")
            return // EXIT
        }

        let picker = MFMailComposeViewController()

        picker.setSubject(subject)
        picker.setMessageBody(body, isHTML: true)
        picker.setToRecipients([sendTo])
        picker.mailComposeDelegate = self

        EmailHelper.getRootViewController()?.present(picker, animated: true, completion: nil)
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        EmailHelper.getRootViewController()?.dismiss(animated: true, completion: nil)
    }

    static func getRootViewController() -> UIViewController? {
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController

        // OR If you use SwiftUI 2.0 based WindowGroup try this one
        // UIApplication.shared.windows.first?.rootViewController
    }
}
