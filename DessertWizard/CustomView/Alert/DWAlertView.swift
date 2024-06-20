//
//  DWAlertView.swift
//  DessertWizard
//
//  Created by Manjul Shrestha on 6/18/24.
//

import SwiftUI

struct DWAlertView: View {
    
    var title: String
    var message : String
    var btnTitle: String
    
    //Closure to handle button click
    var btnAction : (() -> Void)?
    
    var body: some View {
        VStack(alignment: .center) {
            Text(title)
                .font(.title2)
                .foregroundStyle(.textPrimary)
                .multilineTextAlignment(.center)
                .padding(.top, 10)
            
            Text(message)
                .font(.title3)
                .foregroundStyle(.textPrimary)
                .multilineTextAlignment(.center)
                .padding()
            DWButton(btnTitle: btnTitle, btnAction: btnAction)

        }
        .frame(width: 300, height: 250)
        .background(.white)
        .cornerRadius(12)
        .shadow(radius: 40)
    }
}

#Preview {
    DWAlertView(title: "Error", message: "Message here", btnTitle: "OK")
}
