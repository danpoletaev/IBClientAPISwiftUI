//
//  AccountView.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import SwiftUI

struct AccountView: View {
    
    @EnvironmentObject var environmentModel: EnvironmentModel
    
    var body: some View {
        ScrollView {
            VStack {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 120, height: 120, alignment: .center)

                
                Text((environmentModel.accountViewModel.account != nil) ? environmentModel.accountViewModel.account?.accountTitle ?? "" : "Fetching")
                    .font(.system(.title2))
                    .padding(.vertical, 10)
            }
            
            AccountCard(account: $environmentModel.accountViewModel.account)
        }
        .padding(.top, 20)
        .frame(width: UIScreen.screenWidth)
        .onAppear(perform: {
            environmentModel.fetchData()
        })
    }
}

struct AccountView_Previews: PreviewProvider {
    
    static var previews: some View {
        let environmentModel = MockedAccountModels.mockedEvnironmentModel
        
        AccountView().environmentObject(environmentModel)
            .onAppear(perform: {
                environmentModel.fetchData()
            })
        .background(CustomColor.lightBg)
        .environment(\.colorScheme, .dark)
    }
}
