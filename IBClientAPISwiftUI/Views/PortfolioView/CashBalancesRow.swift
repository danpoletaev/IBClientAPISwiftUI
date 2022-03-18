//
//  CashBalancesRow.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import SwiftUI

struct CashBalancesRow: View {
    let key: String
    let value: Double
    @EnvironmentObject var environmentModel: EnvironmentModel
    
    var body: some View {
        HStack {
            Text("\(key) \(environmentModel.accountViewModel.account?.currency ?? "")")
            Spacer()
            HStack {
                Text(String(format: "%.2f", value))
                Text("(Market Value)")
                    .foregroundColor(Color(.secondaryLabel))
                    .font(.system(size: 14))
                    .frame(width: 100, alignment: .leading)
            }
        }
        .padding(.horizontal, 10)
        .frame(width: UIScreen.screenWidth, alignment: .leading)
    }
}
