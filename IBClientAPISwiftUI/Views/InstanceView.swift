//
//  InstanceView.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 09.05.2022.
//

import SwiftUI


func verifyUrl(urlString: String?) -> Bool {
    guard let urlString = urlString,
          let url = URL(string: urlString) else {
              return false
          }
    
    let regex = "http[s]?://(([^/:.[:space:]]+(.[^/:.[:space:]]+)*)|([0-9](.[0-9]{3})))(:[0-9]+)?((/[^?#[:space:]]+)([^#[:space:]]+)?(#.+)?)?"
    let test = NSPredicate(format:"SELF MATCHES %@", regex)
    let result = test.evaluate(with: urlString)
    
    if !result {
        return false
    }
    
    if !urlString.contains("http://") && !urlString.contains("https://") {
        return false
    }
    
    if (urlString.contains("https://")) {
        let urlArr = urlString.components(separatedBy: "https://")
        
        if (urlArr.count < 2) {
            return false
        } else if (urlArr[1].isEmpty) {
            return false
        }
    } else if (urlString.contains("http://")) {
        let urlArr = urlString.components(separatedBy: "http://")
        if (urlArr.count < 2) {
            return false
        } else if (urlArr[1].isEmpty) {
            return false
        }
    } else {
        return false
    }
    
    return UIApplication.shared.canOpenURL(url)
}

struct InstanceView: View {
    @EnvironmentObject var environmentModel: EnvironmentViewModel
    @State private var instanceAddress: String = ""
    @State private var isValidationError: Bool = false
    @StateObject var globalEnvironment = GlobalEnivronment.shared
    
    var body: some View {
        ZStack {
            
            VStack {
                Text("Please, write address of the gateway:")
                    .padding(.bottom, 2)
            
                Text(verbatim: "Please, enter the url of the started gateway in the format: https://localhost:5000")
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(.secondaryLabel))
                    .font(.system(size: 14))
                    .padding(.bottom)
                
                TextField("Ex: https://localhost:5000", text: $instanceAddress)
                    .placeholder("https://localhost:5000", when: instanceAddress.isEmpty)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textInputAutocapitalization(.never)
                    .keyboardType(.URL)
                    .disableAutocorrection(true)
                    .onChange(of: instanceAddress, perform: {newValue in
                        self.isValidationError = !verifyUrl(urlString: newValue)
                    })
                
                if isValidationError {
                    Text("URL validation error: Please, check the format of the url!")
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.red)
                        .font(.system(size: 14))
                        .padding(.vertical)
                }
                
                Button(action: {
                    if verifyUrl(urlString: instanceAddress) {
                        globalEnvironment.instanceURL = instanceAddress
                    }
                    
                }) {
                    Text("Submit")
                        .font(.title3)
                        .frame(width: 200, height: 50, alignment: .center)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(8)
                }
                .padding(.top, 20)
                .opacity(instanceAddress.isEmpty || isValidationError ? 0.5 : 1)
                .disabled(instanceAddress.isEmpty || isValidationError)
                
            }
            .padding(.horizontal)
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .center)
            .background(CustomColor.lightBg)
            .edgesIgnoringSafeArea(.all)
            
            VStack{
                Image("ib-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                    .padding(.top, 100)
                
                Spacer()
            }
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .center)
            
        }
    }
}

struct InstanceView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            InstanceView()
                .environment(\.colorScheme, .dark)
                .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            
            InstanceView()
                .environment(\.colorScheme, .dark)
                .previewDevice(PreviewDevice(rawValue: "iPad Air (4th generation)"))
        }
    }
}
