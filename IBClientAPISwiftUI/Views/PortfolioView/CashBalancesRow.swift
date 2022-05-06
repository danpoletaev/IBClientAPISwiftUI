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
    @EnvironmentObject var environmentModel: EnvironmentViewModel
    
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

struct CashBalancesRow_Preview: PreviewProvider {
    static var previews: some View {
        
        let environmentModel = MockedAccountModels.mockedEvnironmentModel
        
        
        Group {
            CashBalancesRow(key: "key", value: 124.2)
                .environmentObject(environmentModel)
                .onAppear(perform: {
                    environmentModel.fetchData()
                })
                .environment(\.colorScheme, .dark)
                .background(CustomColor.lightBg)
                .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            
            CashBalancesRow(key: "key", value: 124.2)
                .environmentObject(environmentModel)
                .onAppear(perform: {
                    environmentModel.fetchData()
                })
                .environment(\.colorScheme, .dark)
                .background(CustomColor.lightBg)
                .previewDevice(PreviewDevice(rawValue: "iPad Air (4th generation)"))
        }
        
    }
}
