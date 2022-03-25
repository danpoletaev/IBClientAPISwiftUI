//
//  TicketView.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import SwiftUI
import StockCharts

struct OrderConfirmation: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Image(systemName: "checkmark.seal.fill")
                .resizable()
                .foregroundColor(Color.green)
                .frame(width: 150, height: 150, alignment: .center)
            
            Text("Order Filled")
                .font(.title)
                .foregroundColor(Color.white)
                .padding(.vertical)
            
            Text("Bought 1 BIOL Market GTC")
                .font(.title3)
                .foregroundColor(Color.white)
                .padding(.bottom)
            
            
            VStack {
                Text("There will be graph")
            }
            .frame(width: UIScreen.screenWidth, height: 200, alignment: .center)
            .padding(.horizontal)
            .background(Color.gray)
            
            Divider()
                .padding(.vertical)
            
            HStack {
                VStack {
                    HStack {
                        Text("Action")
                            .foregroundColor(Color(.secondaryLabel))
                            .font(.system(size: 14))
                        
                        Spacer()
                            
                        Text("**Buy**")
                            .foregroundColor(Color.white)
                            .font(.system(size: 16))
                    }
                    .padding(.horizontal)
                    HStack {
                        Text("Quantity")
                            .foregroundColor(Color(.secondaryLabel))
                            .font(.system(size: 14))
                        
                        Spacer()
                        
                        Text("**1**")
                            .foregroundColor(Color.white)
                            .font(.system(size: 16))
                    }
                    .padding(.horizontal)
                    HStack {
                        Text("Order Type")
                            .foregroundColor(Color(.secondaryLabel))
                            .font(.system(size: 14))
                        
                        Spacer()
                        
                        Text("**Market**")
                            .foregroundColor(Color.white)
                            .font(.system(size: 16))
                    }
                    .padding(.horizontal)
                }
                
                Divider()
                
                VStack {
                    HStack {
                        Text("Time-in-force")
                            .foregroundColor(Color(.secondaryLabel))
                            .font(.system(size: 14))
                        
                        Spacer()
                        
                        Text("**Good till Cancel**")
                            .foregroundColor(Color.white)
                            .font(.system(size: 16))
                    }
                    .padding(.horizontal)
                    HStack {
                        Text("Order originator")
                            .foregroundColor(Color(.secondaryLabel))
                            .font(.system(size: 14))
                        
                        Spacer()
                        
                        Text("**Customer**")
                            .foregroundColor(Color.white)
                            .font(.system(size: 16))
                    }
                    .padding(.horizontal)
                }
            }
            .frame(width: UIScreen.screenWidth, height: 120, alignment: .center)
            
            Divider()
                .padding(.vertical)
            
            Button(action: {
                dismiss()
            }, label: {
                Text("Done")
                    .foregroundColor(Color.white)
                    .font(.title)
                    .frame(width: 300, height: 50, alignment: .center)
                    .background(CustomColor.graphBlue)
                    .cornerRadius(16)
                    .foregroundColor(Color.white)
                    .padding()
            })
            
//            Button("Done") {
//                dismiss()
//            }
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .center)
        .background(CustomColor.darkBg)
    }
}

struct TicketView: View {
    @StateObject var ticketViewModel = TicketViewModel()
    @State private var showingConfirmation = false

    
    var tickerTitle: String
    var exchange: String
    var conid: Int
    
    var body: some View {
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
                        TransactionView(showingConfirmation: $showingConfirmation, buying: false, ticket: tickerTitle, exchange: exchange, ticketViewModel: ticketViewModel)
                    }, label: {
                        Text("Sell")
                            .foregroundColor(Color.white)
                            .padding(5)
                            .frame(width: 160, alignment: .center)
                            .background(Color.red)
                            .cornerRadius(8)
                    })
                    
                    Spacer()
                    
                    NavigationLink(destination: {
                        TransactionView(showingConfirmation: $showingConfirmation, ticket: tickerTitle, exchange: exchange, ticketViewModel: ticketViewModel)
                    }, label: {
                        Text("Buy")
                            .foregroundColor(Color.white)
                            .padding(5)
                            .frame(width: 160, alignment: .center)
                            .background(Color.blue)
                            .cornerRadius(8)
                    })
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
        .sheet(isPresented: $showingConfirmation) {
            OrderConfirmation()
        }
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
    }
}

