//
//  PortfolioHeader.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import SwiftUI

struct PortfolioHeader: View {
    var accountSummary: AccountSummary
    @EnvironmentObject var environmentModel: EnvironmentViewModel
    var dailyPnL: CorePnLModel? = nil
    
    let ACCOUNT_SUMMARY_STRINGS = [AccountSummaryString(name: "maintmarginreq", label: "MntMgn"), AccountSummaryString(name: "excessliquidity", label: "ExLiq"), AccountSummaryString(name: "buyingpower", label: "Buy PWR"), AccountSummaryString(name: "netliquidation", label: "Net Lqa")]
    var body: some View {
        HStack {
            Text("Account")
                .foregroundColor(Color(.secondaryLabel))
                .font(.system(size: 14))
                .frame(width: 150, alignment: .leading)
            
            Spacer()
            
            Text("Daily P&L")
                .foregroundColor(Color(.secondaryLabel))
                .font(.system(size: 14))
                .frame(width: 80)
            Text("NLV")
                .foregroundColor(Color(.secondaryLabel))
                .font(.system(size: 14))
                .frame(width: 80)
        }
        .padding(.horizontal, 10)
        .frame(width: UIScreen.screenWidth, alignment: .leading)
        
        HStack {
            Text(environmentModel.accountViewModel.account?.accountId ?? "")
                .frame(width: 150, alignment: .leading)
            
            Spacer()
            
            Text(String(dailyPnL?.dpl ?? 0))
                .foregroundColor(dailyPnL?.dpl ?? 0 < 0 ? Color.red : Color.green)
                .frame(width: 80)
            Text("\(String(format: "%.2f", dailyPnL?.nl ?? 0) )")
                .frame(width: 80)
        }
        .padding(.horizontal, 10)
        .frame(width: UIScreen.screenWidth, alignment: .leading)
        HStack {
            if (!accountSummary.isEmpty) {
                HStack {
                    VStack {
                        AccountSummaryCard(label: ACCOUNT_SUMMARY_STRINGS[0].label, amount: accountSummary[ACCOUNT_SUMMARY_STRINGS[0].name]?.amount ?? 0)
                        
                        AccountSummaryCard(label: ACCOUNT_SUMMARY_STRINGS[1].label, amount: accountSummary[ACCOUNT_SUMMARY_STRINGS[1].name]?.amount ?? 0)
                    }
                    .padding(.vertical, 20)
                    
                    Divider()
                        .frame(maxHeight: 70)
                        .padding(.horizontal, 10)
                    
                    VStack {
                        AccountSummaryCard(label: ACCOUNT_SUMMARY_STRINGS[2].label, amount: accountSummary[ACCOUNT_SUMMARY_STRINGS[2].name]?.amount ?? 0)
                        
                        AccountSummaryCard(label: ACCOUNT_SUMMARY_STRINGS[3].label, amount: accountSummary[ACCOUNT_SUMMARY_STRINGS[3].name]?.amount ?? 0)
                    }
                    .padding(.vertical, 20)
                }
            }
        }
        .padding(.horizontal, 30)
        .frame(width: UIScreen.screenWidth)
        .background(CustomColor.darkBg)
    }
}

struct AccountSummaryCard: View {
    
    var label: String
    var amount: Double
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(Color(.secondaryLabel))
                .font(.system(size: 14))
                .frame(minWidth: 70, maxWidth: .infinity, alignment: .leading)
            Spacer()
            Text("\(String(format: "%.0f", amount))")
                .frame(minWidth: 50, maxWidth: .infinity, alignment: .leading)
        }
        .frame(alignment: .leading)
        .padding(.bottom, 5)
    }
}

struct PortfolioHeader_Preview: PreviewProvider {
    static var previews: some View {
        let environmentModel = MockedAccountModels.mockedEvnironmentModel
        
        let portfolioViewModel = PortfolioViewModel(repository: PortfolioRepository(portfolioApiService: MockPortfolioApiService(positions: nil), accountApiService: MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: nil), tickerApiService: MockTickerApiService(tickerInfo: nil, secDefResponse: nil, historyConidResponse: nil)))
        
        PortfolioHeader(accountSummary: portfolioViewModel.accountSummary, dailyPnL: portfolioViewModel.dailyPnL)
            .environmentObject(environmentModel)
            .onAppear(perform: {
                environmentModel.fetchData()
                portfolioViewModel.onAppear()
            })
            .environment(\.colorScheme, .dark)
            .background(CustomColor.lightBg)
    }
}
