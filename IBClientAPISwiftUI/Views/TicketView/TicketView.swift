//
//  TicketView.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import SwiftUI
import StockCharts
import ActivityIndicatorView

struct TicketView: View {
    @StateObject var ticketViewModel: TicketViewModel
    
    
    var tickerTitle: String
    var exchange: String
    var conid: Int
    
    init(ticketViewModel: TicketViewModel?, tickerTitle: String, exchange: String, conid: Int) {
        _ticketViewModel = StateObject(wrappedValue: ticketViewModel ?? TicketViewModel(repository: nil))
        self.tickerTitle = tickerTitle
        self.exchange = exchange
        self.conid = conid
    }
    
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            Text(tickerTitle)
                            Text(exchange)
                                .foregroundColor(Color(.secondaryLabel))
                                .font(.system(size: 14))
                            
                        }
                        .padding(.horizontal)
                        .frame(width: UIScreen.screenWidth, alignment: .leading)
                    }
                    
                    HStack {
                        Text(ticketViewModel.tickerInfo?.bid ?? "0")
                            .font(.system(size: 40))
                        VStack {
                            Text("\(ticketViewModel.tickerInfo?.changeFromLastPrice ?? "") $")
                                .foregroundColor(ticketViewModel.tickerInfo?.changeFromLastPricePercentage ?? 0 < 0 ? Color.red : Color.green)
                                .font(.system(size: 14))
                            Text("\(ticketViewModel.tickerInfo?.changeFromLastPricePercentage ?? 0, specifier: "%.2f") %")
                                .foregroundColor(ticketViewModel.tickerInfo?.changeFromLastPricePercentage ?? 0 < 0 ? Color.red : Color.green)
                                .font(.system(size: 14))
                        }
                        Spacer()
                        
                        VStack {
                            HStack {
                                Text("High")
                                    .foregroundColor(Color(.secondaryLabel))
                                Text(ticketViewModel.tickerInfo?.high ?? "0")
                            }
                            HStack {
                                Text("Low")
                                    .foregroundColor(Color(.secondaryLabel))
                                Text(ticketViewModel.tickerInfo?.low ?? "0")
                            }
                        }
                    }.padding(.horizontal)
                    
                    TicketGraph(tickerInfo: $ticketViewModel.tickerInfo, graphData: $ticketViewModel.graphData, dates: $ticketViewModel.dates)
                    Divider()
                    MarketData(tickerInfo: $ticketViewModel.tickerInfo)
                    Divider()
                        .padding(.vertical, 10)
                    PositionItem(tickerInfo: $ticketViewModel.tickerInfo)
                    
                    HStack {
                        
                        NavigationLink(destination: {
                            TransactionView(transactionViewModel: nil, ticketViewModel: ObservedObject(wrappedValue: ticketViewModel), buying: false, ticket: tickerTitle, exchange: exchange)
                        }, label: {
                            Text("Sell")
                                .foregroundColor(Color.white)
                                .padding(5)
                                .frame(width: 160, alignment: .center)
                                .background(Color.red)
                                .cornerRadius(8)
                                .opacity(ticketViewModel.tickerInfo == nil ? 0.5 : 1)
                        })
                            .disabled(ticketViewModel.tickerInfo == nil)
                        
                        Spacer()
                        
                        NavigationLink(destination: {
                            TransactionView(transactionViewModel: nil, ticketViewModel: ObservedObject(wrappedValue: ticketViewModel), buying: true, ticket: tickerTitle, exchange: exchange)
                        }, label: {
                            Text("Buy")
                                .foregroundColor(Color.white)
                                .padding(5)
                                .frame(width: 160, alignment: .center)
                                .background(Color.blue)
                                .cornerRadius(8)
                                .opacity(ticketViewModel.tickerInfo == nil ? 0.5 : 1)
                        })
                            .disabled(ticketViewModel.tickerInfo == nil)
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                }
                .frame(width: UIScreen.screenWidth, alignment: .center)
                .background(CustomColor.darkBg)
                .navigationTitle("Bar")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    TicketNavigationBar(title: tickerTitle, subTitle: exchange)
                }
            }
            .opacity(ticketViewModel.isLoading ? 0.5 : 1)
            .onAppear(perform: {
                ticketViewModel.onAppear(conid: conid, period: "1m")
            })
            .task {
                do {
                    await ticketViewModel.retrieveMessages()
                }
            }
            .onDisappear(perform: {
                ticketViewModel.onDisappear()
            })
            
            ActivityIndicatorView(isVisible: $ticketViewModel.isLoading, type: .scalingDots)
                .foregroundColor(Color.white)
                .frame(width: 80, height: 50, alignment: .center)
        }
    }
}

struct TicketView_Previews: PreviewProvider {
    static var previews: some View {
        let ticketViewModel = TicketViewModel(repository: TicketRepository(apiService: MockTickerApiService(tickerInfo: nil, secDefResponse: nil, historyConidResponse: nil), acccountApiService: nil))
        
        TicketView(ticketViewModel: ticketViewModel, tickerTitle: "BIOL", exchange: "NASDAQ", conid: 1)
            .environment(\.colorScheme, .dark)
            .background(CustomColor.lightBg)
            .onAppear(perform: {
                ticketViewModel.onAppear(conid: 1, period: "Q")
            })
    }
}

