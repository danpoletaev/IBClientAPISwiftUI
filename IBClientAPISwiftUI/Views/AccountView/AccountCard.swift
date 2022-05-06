//
//  AccountCard.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import SwiftUI

import SwiftUI

struct AccountCard: View {
    @Binding var account: Account?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Basic account information")
                Spacer()
                Text(account?.accountId ?? "Fetching")
            }
            .padding()
            
            
            Group {
                Divider()
                AccountInfoRow(key: "ID", value: account?.accountId ?? "Fetching")
                Divider()
                AccountInfoRow(key: "Type", value: account?.type == "INDIVIDUAL" ? "Personal" : "Organistaion")
                Divider()
                AccountInfoRow(key: "Currency", value: account?.currency ?? "Fetching")
            }
            Divider()
        }
        .padding(.top, 10)
        .frame(width: UIScreen.screenWidth)
        .background(CustomColor.darkBg)
    }
}

struct AccountCard_Preview: PreviewProvider {
    @State static var testAccount: Account? = Account(id: "1", accountId: "1", accountVan: "Account Van", accountTitle: "First Name", displayName: "Display Name Poletaev", accountAlias: "UA", accountStatus: 123123.12, currency: "CZK", type: "INDIVIDUAL", tradingType: "STKCASH", ibEntity: "IB-CE", faclient: false, clearingStatus: "0", covestor: false, parent: AccountParent(mmc: [], accountId: "", isMParent: false, isMChild: false, isMultiplex: false), desc: "Description")
    
    static var previews: some View {
        
        Group {
            AccountCard(account: $testAccount)
                .environment(\.colorScheme, .dark)
                .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            
            AccountCard(account: $testAccount)
                .environment(\.colorScheme, .dark)
                .previewDevice(PreviewDevice(rawValue: "iPad Air (4th generation)"))
        }
        
    }
}
