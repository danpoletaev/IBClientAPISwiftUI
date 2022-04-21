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
                                .foregroundColor(Color(.secondaryLabel))
                                .font(.system(size: 14))
                            
                            Spacer()
                                
                            Text("**\(placedOrder?.side ?? "SIDE")**")
                                .foregroundColor(Color.white)
                                .font(.system(size: 16))
                        }
                        .padding(.horizontal)
                        HStack {
                            Text("Quantity")
                                .foregroundColor(Color(.secondaryLabel))
                                .font(.system(size: 14))
                            
                            Spacer()
                            
                            Text("**\(placedOrder?.quantity ?? 0)**")
                                .foregroundColor(Color.white)
                                .font(.system(size: 16))
                        }
                        .padding(.horizontal)
                        HStack {
                            Text("Order Type")
                                .foregroundColor(Color(.secondaryLabel))
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
                                .foregroundColor(Color(.secondaryLabel))
                                .font(.system(size: 14))
                            
                            Spacer()
                            
                            Text("**\(placedOrder?.tif ?? "tif")**")
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
//                .frame(width: UIScreen.screenWidth, height: 100, alignment: .center)
                
                Divider()
                    .padding(.vertical)
                
                Button(action: {
                    self.transactionViewModel.confirmOrder(id: self.transactionViewModel.orders[0].id) { replyResponse in
                        print("reply response")
                        print(replyResponse)
                        print("reply response")
                        self.orderPlacedSuccessfully = true
                        dismiss()
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
    }
}
