//
//  AuthorizationSheet.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 06.05.2022.
//

import Foundation
import SwiftUI

struct AuthorizationSheet: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var environmentModel: EnvironmentViewModel
    
    @State var errorAgain = false
    
    var body: some View {
        if DataManager().API_URL.starts(with: "https") {
            SFSafariViewWrapper(url: URL(string: "https://\(APIConstants.COMMON_BASE_URL)")!)
        } else {
            VStack {
                Image(systemName: "xmark.icloud.fill")
                    .resizable()
                    .frame(width: 140, height: 100, alignment: .center)
                    .foregroundColor(Color.red)
                    .padding(.top, 60)
                    .padding(.bottom, 40)
                
                Text("You are not logged in or server is not started. Please, login by going to:")
                    .font(.title2)
                    .padding(10)
                    .accessibility(identifier: "loginErrorStaticText")
                if errorAgain {
                    Text("Please, try again.")
                        .foregroundColor(Color.red)
                        .padding(10)
                        .accessibilityIdentifier("errorLoginText")
                }
                Link("http://\(APIConstants.COMMON_BASE_URL)", destination: URL(string: "http://\(APIConstants.COMMON_BASE_URL)")!)
                    .padding(.bottom, 40)
                
                Button(action: {
                    self.errorAgain = false
                    environmentModel.getIServerAccount { (data, error) in
                        if (error == nil && data != nil) {
                            self.dismiss()
                        } else {
                            self.errorAgain = true
                        }
                    }
                }, label: {
                    Text("Reconnect")
                        .foregroundColor(Color.white)
                        .font(.title)
                        .frame(width: 300, height: 50, alignment: .center)
                        .background(CustomColor.graphBlue)
                        .cornerRadius(16)
                        .foregroundColor(Color.white)
                        .padding()
                        .accessibility(identifier: "loginReconnectButton")
                })
            }
            .interactiveDismissDisabled()
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .center)
            .background(CustomColor.lightBg)
        }
    }
}

struct SheetUnauthorized_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            AuthorizationSheet()
                .environment(\.colorScheme, .dark)
                .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            
            AuthorizationSheet()
                .environment(\.colorScheme, .dark)
                .previewDevice(PreviewDevice(rawValue: "iPad Air (4th generation)"))
        }
    }
}
