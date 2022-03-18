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

struct AccountInfoRow: View {
    var key: String = ""
    var value: String = ""
    var body: some View {
        HStack {
            Text(key)
                .foregroundColor(Color(.secondaryLabel))
                .font(.system(size: 14))
            Spacer()
            Text(value)
        }
        .padding()
    }
}
