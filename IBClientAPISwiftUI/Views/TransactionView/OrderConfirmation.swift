//
//  OrderConfirmation.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 27.03.2022.
//

import SwiftUI

struct OrderConfirmation: View {
    @Environment(\.dismiss) var dismiss
    @Binding var placedOrder: Order?
    @Binding var orderPlacedSuccessfully: Bool
    @StateObject var transactionViewModel: TransactionViewModel
    @State private var showingErrorAlert = false
    @State var replyError: ReplyItemError? = nil
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Image(systemName: "clock.fill")
                    .resizable()
                    .foregroundColor(Color.orange)
                    .frame(width: 100, height: 100, alignment: .center)
                    .padding(.top, 20)
                
                Text("Order needs confirmation")
                    .font(.title)
                    .foregroundColor(Color.white)
                    .padding(.vertical)
                
                VStack {
                    ForEach(self.transactionViewModel.orders[0].message, id: \.self) { message in
                        let htmlString = "<html><style>body {font-size: 1.2em} h4 {font-size: 2em}</style><body style=\"color: white\">\(message)</body></html>"
                        HTMLView(htmlString: htmlString)
                            .padding(.horizontal)
                            .frame(alignment: .center)
                            .frame(maxWidth: .infinity, minHeight: 200)
                        Divider()
                    }
                }
                
                
                HStack {
                    VStack {
                        HStack {
                            Text("Action")
                                .foregroundColor(Color.white.opacity(0.7))
                                .font(.system(size: 14))
                            
                            Spacer()
                            
                            Text("**\(placedOrder?.side ?? "SIDE")**")
                                .foregroundColor(Color.white)
                                .font(.system(size: 16))
                        }
                        .padding(.horizontal)
                        HStack {
                            Text("Quantity")
                                .foregroundColor(Color.white.opacity(0.7))
                                .font(.system(size: 14))
                            
                            Spacer()
                            
                            Text("**\(placedOrder?.quantity ?? 0)**")
                                .foregroundColor(Color.white)
                                .font(.system(size: 16))
                        }
                        .padding(.horizontal)
                        HStack {
                            Text("Order Type")
                                .foregroundColor(Color.white.opacity(0.7))
                                .font(.system(size: 14))
                            
                            Spacer()
                            
                            Text("**\(placedOrder?.orderType ?? "Type")**")
                                .foregroundColor(Color.white)
                                .font(.system(size: 16))
                        }
                        .padding(.horizontal)
                    }
                    
                    Divider()
                    
                    VStack {
                        HStack {
                            Text("Time-in-force")
                                .foregroundColor(Color.white.opacity(0.7))
                                .font(.system(size: 14))
                            
                            Spacer()
                            
                            Text("**\(placedOrder?.tif ?? "tif")**")
                                .foregroundColor(Color.white)
                                .font(.system(size: 16))
                        }
                        .padding(.horizontal)
                    }
                }
                
                Divider()
                    .padding(.vertical)
                
                Button(action: {
                    self.transactionViewModel.confirmOrder(id: self.transactionViewModel.orders[0].id) { (replyResponse, error) in
                        if replyResponse != nil {
                            self.orderPlacedSuccessfully = true
                            dismiss()
                        } else if error != nil {
                            self.replyError = error
                            self.showingErrorAlert = true
                        }
                    }
                }, label: {
                    Text("Confirm")
                        .foregroundColor(Color.white)
                        .font(.title)
                        .frame(width: 300, height: 50, alignment: .center)
                        .background(CustomColor.graphBlue)
                        .cornerRadius(16)
                        .foregroundColor(Color.white)
                        .padding()
                })
            }
        }
        .background(CustomColor.darkBg)
        .alert(self.replyError?.error ?? "", isPresented: $showingErrorAlert) {
                    Button("OK", role: .cancel) { }
                }
    }
}

struct OrderConfirmation_Peviews: PreviewProvider {
    @State static var orderPlacedSuccessfully = false
    @State static var placedOrder: Order? = Order(acctId: "222", conid: 1, secType: "STK", orderType: "GTC", side: "BUY", tif: "GRE", quantity: 2.53)
    static var previews: some View {
        let transactionViewModel = TransactionViewModel(repository: TransactionRepository(apiService: MockTransactionApiService(placeOrderResponse: nil, replyItemResponse: nil), accountApiService: MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: nil)), orders: MockTransactionModels.placeOrderResponse)
        
        Group {
            OrderConfirmation(placedOrder: $placedOrder, orderPlacedSuccessfully: $orderPlacedSuccessfully, transactionViewModel: transactionViewModel)
                .onAppear(perform: {
                    transactionViewModel.placeOrder(order: placedOrder ?? Order(acctId: "222", conid: 1, secType: "STK", orderType: "GTC", side: "BUY", tif: "GRE", quantity: 2.53)) {_ in }
                })
                .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            
            OrderConfirmation(placedOrder: $placedOrder, orderPlacedSuccessfully: $orderPlacedSuccessfully, transactionViewModel: transactionViewModel)
                .onAppear(perform: {
                    transactionViewModel.placeOrder(order: placedOrder ?? Order(acctId: "222", conid: 1, secType: "STK", orderType: "GTC", side: "BUY", tif: "GRE", quantity: 2.53)) {_ in }
                })
                .previewDevice(PreviewDevice(rawValue: "iPad Air (4th generation)"))
        }
    }
}
