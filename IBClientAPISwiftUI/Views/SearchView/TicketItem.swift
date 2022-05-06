//
//  TicketItem.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import SwiftUI

struct TicketItem: View {
    var title: String
    var exchange: String
    var conid: Double
    
    var body: some View {
        NavigationLink(destination: {
            TicketView(ticketViewModel: nil, tickerTitle: title, exchange: exchange, conid: Int(conid))
        }, label: {
            VStack {
                HStack{
                    VStack(alignment: .leading){
                        Text(title)
                            .font(.system(size: 16))
                        Text(exchange)
                            .font(.system(size: 20))
                            .foregroundColor(Color(.secondaryLabel))
                    }
                    Spacer()
                }
            }
        })
    }
}

struct TicketItem_Previews: PreviewProvider {
    static var previews: some View {
        
        Group{
            TicketItem(title: "Title", exchange: "Exchange", conid: 21)
                .environment(\.colorScheme, .dark)
                .background(CustomColor.lightBg)
                .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            
            TicketItem(title: "Title", exchange: "Exchange", conid: 21)
                .environment(\.colorScheme, .dark)
                .background(CustomColor.lightBg)
                .previewDevice(PreviewDevice(rawValue: "iPad Air (4th generation)"))
        }
    }
}
