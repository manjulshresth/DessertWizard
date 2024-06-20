//
//  DWAlert.swift
//  DessertWizard
//
//  Created by Manjul Shrestha on 6/17/24.
//

import SwiftUI

struct AlertContent {
    let title : String
    let message : String
    let buttonTitle : String
}

struct DWAlert{
    static let invalidURLContent = AlertContent(title: "Invalid URL", message: "The url is invalid", buttonTitle: "OK")
    static let invalidResponseContent = AlertContent(title: "Invalid Response", message: "The response sent from the server is invalid", buttonTitle: "OK")
    static let invalidDataContent = AlertContent(title: "Invalid Data", message: "The data sent from the server is not valid", buttonTitle: "OK")
    static let invalidConnectionErrorContent = AlertContent(title: "Connection Error", message: "Could not connect to the internet", buttonTitle: "OK")
}
