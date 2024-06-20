//
//  DWButton.swift
//  DessertWizard
//
//  Created by Manjul Shrestha on 6/18/24.
//

import SwiftUI

struct DWButton: View {
    
    var btnTitle : String
    var btnAction : (() -> Void)?
    
    var body: some View {
        Button {
            if let action = btnAction{
                action()
            }
        } label: {
            Text(btnTitle)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(.brandPrimary)
                .cornerRadius(12)
                .padding()
        }
    }
}

#Preview {
    DWButton(btnTitle: "OK")
}
