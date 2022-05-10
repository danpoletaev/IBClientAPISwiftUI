//
//  HomeView.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import SwiftUI
import StockCharts
import ActivityIndicatorView

struct HomeView: View {
    @EnvironmentObject var environmentModel: EnvironmentViewModel
    @StateObject var homeViewModel: HomeViewModel
    
    init(homeViewModel: HomeViewModel?) {
        _homeViewModel = StateObject(wrappedValue: homeViewModel ?? HomeViewModel(homeRepository: nil))
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ZStack {
                VStack(alignment: .center) {
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                // acount number + amount
                                Text(environmentModel.accountViewModel.account?.accountId ?? "Fetching")
                                    .foregroundColor(Color(.secondaryLabel))
                                    .font(.system(size: 14))
                                Text("\(environmentModel.accountViewModel.account?.currency ?? "USD")\(environmentModel.accountViewModel.total?.endVal ?? "0")")
                                    .foregroundColor(Color.white)
                                    .font(.system(.title2))
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                Text("Change(All Time)")
                                    .foregroundColor(Color(.secondaryLabel))
                                    .font(.system(size: 14))
                                Text("\(environmentModel.accountViewModel.account?.currency ?? "USD")\(String(format: "%.2f", homeViewModel.accountPerformance.moneyChange ?? 0))")
                                    .foregroundColor(homeViewModel.accountPerformance.moneyChange ?? 0 < 0 ? Color.red : Color.green)
                                    .font(.system(.title2))
                            }
                        }
                        if self.homeViewModel.accountPerformance.graphData.count < 1 {
                            Spacer()
                        } else {
                            LineChartView(
                                lineChartController:
                                    LineChartController(
                                        prices: self.homeViewModel.accountPerformance.graphData, dates: self.homeViewModel.accountPerformance.dates, downtrendLineColor: CustomColor.graphBlue, dragGesture: true
                                    )
                            )
                        }
                    }
                    .padding()
                    .frame(width: UIScreen.screenWidth, height: 300, alignment: .center)
                    .background(CustomColor.darkBg)
                    .padding()
                    .opacity(homeViewModel.isGraphLoading ? 0.5 : 1)
                    
                    VStack {
                        HStack(alignment: .firstTextBaseline) {
                            Text("Top Portfolio Positions")
                                .font(.system(.headline))
                            Spacer()
                            Button(action: {
                                self.environmentModel.tagSelection = 0
                            }, label: {
                                Image(systemName: "arrow.up.forward.app")
                                    .resizable()
                                    .frame(width: 20, height: 20, alignment: .center)
                            })
                        }
                        .padding(.horizontal)
                        .padding(.top, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                Text("Instument")
                                    .foregroundColor(Color(.secondaryLabel))
                                    .font(.system(size: 14))
                                    .frame(minWidth: 100, maxWidth: .infinity, alignment: .leading)
                                Text("Last")
                                    .foregroundColor(Color(.secondaryLabel))
                                    .font(.system(size: 14))
                                    .frame(minWidth: 100, maxWidth: .infinity)
                                Text("Change")
                                    .foregroundColor(Color(.secondaryLabel))
                                    .font(.system(size: 14))
                                    .frame(minWidth: 70, maxWidth: .infinity)
                                Text("Position")
                                    .foregroundColor(Color(.secondaryLabel))
                                    .font(.system(size: 14))
                                    .frame(minWidth: 70, maxWidth: .infinity)
                                
                                Text("P&L")
                                    .foregroundColor(Color(.secondaryLabel))
                                    .font(.system(size: 14))
                                    .frame(minWidth: 70, maxWidth: .infinity)
                            }
                            .padding(.horizontal, 10)
                            
                            VStack {
                                Divider()
                                ForEach(homeViewModel.topPortfolio, id: \.conid) { position in
                                    NavigationLink(destination: {
                                        TicketView(ticketViewModel: nil, tickerTitle: position.name ?? "Ticker", exchange: position.listingExchange ?? "Exchange", conid: position.conid)
                                    }, label: {
                                        PortfolioListItem(ticketViewModel: nil, ticker: position.contractDesc ?? "", listingExchange: position.listingExchange ?? "NASDAQ", conid: position.conid, last: position.mktPrice ?? 0, position: position.position ?? 0, unrealizedPnL: position.unrealizedPnl ?? 0, changeFromLastPrice: position.priceChange ?? "0")
                                    })
                                    Divider()
                                }
                            }
                            .background(CustomColor.darkBg)
                        }
                        Divider()
                        if homeViewModel.topPortfolio.count == 0 {
                            Text("You don't have any positions yet")
                                .foregroundColor(Color(.secondaryLabel))
                                .padding(.top, 10)
                            Spacer()
                        }
                    }
                    .frame(width: UIScreen.screenWidth, alignment: .leading)
                    .frame(minHeight: 200)
                    .background(CustomColor.darkBg)
                    .opacity(homeViewModel.topPortfolioLoading ? 0.5 : 1)
                    .padding(.bottom, 5)
                    
                    VStack {
                        HStack {
                            Text("Daily Gainers")
                                .font(.system(.headline))
                                .padding(.leading, 10)
                            Spacer()
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(self.homeViewModel.secDefConids, id: \.conid) { info in
                                    CustomScreenerItem(ticketViewModel: nil, ticker: info.ticker ?? "", conid: info.conid, listingExchange: info.listingExchange ?? "", name: info.name ?? "")
                                }
                            }
                        }
                        if homeViewModel.dailyGainersLoading {
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 5)
                    .frame(width: UIScreen.screenWidth)
                    .frame(minHeight: 70)
                    .opacity(homeViewModel.dailyGainersLoading ? 0.5 : 1)
                    Spacer()
                }
                ActivityIndicatorView(isVisible: $homeViewModel.isLoading, type: .scalingDots)
                    .foregroundColor(Color.white)
                    .frame(width: 80, height: 50, alignment: .center)
            }
        }
        .onAppear(perform: {
            if environmentModel.authorized {
                environmentModel.fetchData()
                homeViewModel.onAppear()
            }
            
        })
        .onChange(of: environmentModel.authorized, perform: { newValue in
            if newValue {
                environmentModel.fetchData()
                homeViewModel.onAppear()
            }
        })
    }
}

struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        let environmentModel = MockedAccountModels.mockedEvnironmentModel
        
        let homeViewModel = HomeViewModel(homeRepository: HomeRepository(homeApiService: MockHomeApiService(scannerResponse: nil), portfolioApiService: nil, tickerApiService: nil, accountApiService: MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: nil)))
        
        Group {
            
            HomeView(homeViewModel: homeViewModel)
                .environmentObject(environmentModel)
                .environment(\.colorScheme, .dark)
                .background(CustomColor.lightBg)
                .onAppear(perform: {
                    homeViewModel.onAppear()
                })
                .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            
            HomeView(homeViewModel: homeViewModel)
                .environmentObject(environmentModel)
                .environment(\.colorScheme, .dark)
                .background(CustomColor.lightBg)
                .onAppear(perform: {
                    homeViewModel.onAppear()
                })
                .previewDevice(PreviewDevice(rawValue: "iPad Air (4th generation)"))
            
        }
    }
}

