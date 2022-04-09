//
//  CashBalances.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import SwiftUI

struct CashBalances: View {
    var isLong: Bool = true
    var assetList: [String: Double] = [:]
    
    var body: some View {
        HStack {
            Text("Cash Balances")
                .foregroundColor(Color(.secondaryLabel))
                .font(.system(size: 14))
            Spacer()
            Text(isLong ? "Long" : "Short")
                .foregroundColor(isLong ? Color.green : Color.red)
        }
        .padding(.horizontal, 10)
        .frame(width: UIScreen.screenWidth, alignment: .leading)
        
        VStack {
            Divider()
            ForEach(assetList.sorted(by: >), id: \.key) { key, value in
                CashBalancesRow(key: key, value: value)
                Divider()
            }
        }
        .background(CustomColor.darkBg)
    }
}

struct CashBalances_Previews: PreviewProvider {
    static var previews: some View {
        let assetListMocked = MockedAccountModels.allocationResponse.assetClass.long
        CashBalances(isLong: true, assetList: assetListMocked)
            .environmentObject(MockedAccountModels.mockedEvnironmentModel)
            .background(CustomColor.lightBg)
            .environment(\.colorScheme, .dark)
    }
}
