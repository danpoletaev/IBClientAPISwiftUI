//
//  BuyingSellingView.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 21.03.2022.
//

import SwiftUI

struct TransactionView: View {
    @State var quantity: String = ""
    @State var limitPrice: String = ""
    @State var totalPrice: Double = 0
    @State var showingConfirmation: Bool = false
    @State private var order: Order? = nil

    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @EnvironmentObject var environmentModel: EnvironmentViewModel
    
    var buying: Bool = true
    var ticket: String
    var exchange: String
    
    @ObservedObject var ticketViewModel: TicketViewModel
    @StateObject private var transactionViewModel: TransactionViewModel
    @State private var selection = OrderTypes.MKT
    @State private var timeInForce = TifTypes.DAY
    @Binding var orderPlacedSuccessfully: Bool
    
    init(transactionViewModel: TransactionViewModel?, ticketViewModel: ObservedObject<TicketViewModel>, buying: Bool, ticket: String, exchange: String, orderPlacedSuccessfully: Binding<Bool>) {
        _transactionViewModel = StateObject(wrappedValue: transactionViewModel ?? TransactionViewModel(repository: nil, orders: nil))
        _ticketViewModel = ticketViewModel
        self.buying = buying
        self.ticket = ticket
        self.exchange = exchange
        self._orderPlacedSuccessfully = orderPlacedSuccessfully
    }
    
    var body: some View {
        VStack {
            ScrollView {
                Group {
                    HStack {
                        Text(ticket)
                        Text(exchange)
                            .foregroundColor(Color(.secondaryLabel))
                            .font(.system(size: 14))
                        Spacer()
                    }
                    
                    HStack {
                        Text(ticketViewModel.tickerInfo?.bid ?? "")
                            .font(.system(size: 40))
                        VStack {
                            Text(ticketViewModel.tickerInfo?.changeFromLastPrice ?? "")
                                .foregroundColor(ticketViewModel.tickerInfo?.changeFromLastPricePercentage ?? 0 < 0 ? Color.red : Color.green)
                            Text("\(ticketViewModel.tickerInfo?.changeFromLastPricePercentage ?? 0, specifier: "%.2f") %")
                                .foregroundColor(ticketViewModel.tickerInfo?.changeFromLastPricePercentage ?? 0 < 0 ? Color.red : Color.green)
                        }
                        Spacer()
                        VStack {
                            HStack {
                                Text("High")
                                    .foregroundColor(Color(.secondaryLabel))
                                    .font(.system(size: 14))
                                Text(ticketViewModel.tickerInfo?.high ?? "")
                            }
                            HStack {
                                Text("Low")
                                    .foregroundColor(Color(.secondaryLabel))
                                    .font(.system(size: 14))
                                Text(ticketViewModel.tickerInfo?.low ?? "")
                            }
                        }
                    }
                    .padding(.bottom, 4)
                    
                    
                    HStack {
                        HStack {
                            Text("BID")
                                Spacer()
                            Text("1,000 x \(ticketViewModel.tickerInfo?.bid ?? "0")")
                        }
                        .foregroundColor(Color.blue)
                        .background(Color.blue.opacity(0.1))
                        
                        Spacer()
                        
                        HStack {
                            Text("1,000 x \(ticketViewModel.tickerInfo?.ask ?? "0")")
                                Spacer()
                            Text("ASK")
                        }
                        .foregroundColor(Color.red)
                        .background(Color.red.opacity(0.1))
                    }
                }
                .padding(.horizontal)
                
                
                Divider()
                    .padding(.vertical)
                
                HStack {
                    VStack {
                        Text("Account")
                            .foregroundColor(Color(.secondaryLabel))
                            .font(.system(size: 16))
                        Text(environmentModel.accountViewModel.account?.accountId ?? "")
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("Position")
                            .foregroundColor(Color(.secondaryLabel))
                            .font(.system(size: 16))
                        Text("\(ticketViewModel.tickerInfo?.positions ?? "0")")
                    }
                }
                .padding(.horizontal)
                
                Group {
                    Divider()
                        .padding(.vertical)
                    HStack {
                        Text("Quantity")
                            .font(.title3)
                            .foregroundColor(Color(.secondaryLabel))
                            .onChange(of: quantity, perform: {
                                if let tempQuant = Double($0) {
                                    if let tempBid = Double(ticketViewModel.tickerInfo?.bid ?? "0.0") {
                                        self.totalPrice = tempQuant * tempBid
                                    }
                                }
                                
                            })
                        Spacer()
                        TextField("5", text: $quantity)
                            .keyboardType(.numberPad)
                            .padding(10)
                            .frame(width: 200)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(.secondaryLabel), lineWidth: 2)
                            )
                            .accessibility(identifier: "quanityTF")
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Spacer()
                        Text("$\(String(totalPrice))")
                            .foregroundColor(Color(.secondaryLabel))
                    }
                    .padding(.horizontal)
                    
                    Divider()
                        .padding(.bottom)
                    
                    HStack {
                        Text("Order Type")
                            .font(.title3)
                            .foregroundColor(Color(.secondaryLabel))
                        
                        Spacer()
                        
                        Picker("Order Type", selection: $selection) {
                            ForEach(OrderTypes.allCases, id: \.self) { value in
                                Text(value.localizedName)
                                    .disabled(true)
                                    .tag(value)
                                    .font(.title3)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    Divider()
                        .padding(.vertical)
                    
                    
//                    if selection == OrderTypes.LMT {
//                        HStack {
//                            Text("Limit price")
//                                .font(.title3)
//                                .foregroundColor(Color(.secondaryLabel))
//
//                            Spacer()
//                            TextField("5", text: $limitPrice)
//                                .keyboardType(.numberPad)
//                                .padding(10)
//                                .frame(width: 200)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 8)
//                                        .stroke(Color(.secondaryLabel), lineWidth: 2)
//                                )
//                                .accessibility(identifier: "limitPrice")
//                        }
//                        .padding(.horizontal)
//
//                        Divider()
//                            .padding(.vertical)
//                    }
                    
                    HStack {
                        Text("Time-in-force")
                            .font(.title3)
                            .foregroundColor(Color(.secondaryLabel))
                        
                        Spacer()
                        
                        Picker("Time-in-force", selection: $timeInForce) {
                            ForEach(TifTypes.allCases, id: \.self) { value in
                                Text(value.localizedName)
                                    .tag(value)
                                    .font(.title3)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    Divider()
                        .padding(.vertical)
                }
                
                
                Button(action: {
                    
                    let order = Order(conid: Int(ticketViewModel.tickerInfo?.conid ?? 0), secType: "STK", orderType: selection.rawValue, side: buying ? "BUY" : "SELL", tif: timeInForce.rawValue, quantity: Double(quantity) ?? 0)
                    
                    transactionViewModel.placeOrder(order: order) { orders in
                        self.order = order
                        self.showingConfirmation = true
                    }
                }) {
                    Text("Submit")
                        .font(.title3)
                        .frame(width: 200, height: 50, alignment: .center)
                        .background(buying ? Color.blue : Color.red)
                        .foregroundColor(Color.white)
                        .cornerRadius(8)
                }
                .opacity(quantity.length == 0 ? 0.5 : 1)
                .disabled(quantity.length == 0)
                
            }
        }
        .onChange(of: orderPlacedSuccessfully, perform: { newValue in
            if newValue {
                self.mode.wrappedValue.dismiss()
            }
        })
        .sheet(isPresented: $showingConfirmation) {
            OrderConfirmation(placedOrder: $order, orderPlacedSuccessfully: $orderPlacedSuccessfully, transactionViewModel: transactionViewModel)
        }
        .padding(.top, 20)
        .frame(width: UIScreen.screenWidth, alignment: .leading)
        .navigationTitle("Bar")
        .background(CustomColor.darkBg)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            TransactionNavBar(buying: buying)
        }
    }
}


struct TransactionView_Previews: PreviewProvider {
    @State static var orderPlacedSuccessfully = false
    static var previews: some View {
        
        let transactionViewModel = TransactionViewModel(repository: TransactionRepository(apiService: MockTransactionApiService(placeOrderResponse: nil, replyItemResponse: nil), accountApiService: MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: nil)), orders: nil)
        
        let ticketViewModel = ObservedObject(wrappedValue: TicketViewModel(repository: TicketRepository(apiService: MockTickerApiService(tickerInfo: nil, secDefResponse: nil, historyConidResponse: nil), acccountApiService: MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: nil))))
        
        Group {
            TransactionView(transactionViewModel: transactionViewModel, ticketViewModel: ticketViewModel    , buying: true, ticket: "BIOL", exchange: "NASDAQ", orderPlacedSuccessfully: $orderPlacedSuccessfully)
                .environment(\.colorScheme, .dark)
                .background(CustomColor.darkBg)
                .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            
            TransactionView(transactionViewModel: transactionViewModel, ticketViewModel: ticketViewModel    , buying: true, ticket: "BIOL", exchange: "NASDAQ", orderPlacedSuccessfully: $orderPlacedSuccessfully)
                .environment(\.colorScheme, .dark)
                .background(CustomColor.darkBg)
                .previewDevice(PreviewDevice(rawValue: "iPad Air (4th generation)"))
        }
    }
}
