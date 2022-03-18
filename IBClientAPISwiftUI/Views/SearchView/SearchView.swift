//
//  SearchView.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import SwiftUI

struct SearchView: View {
    @State var searchText: String
    @StateObject private var searchViewModel = SearchViewModel()
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                List {
                    ForEach(searchViewModel.tickets, id: \.conid) { ticket in
                        TicketItem(title: ticket.companyName ?? "", exchange: ticket.description ?? "", conid: ticket.conid)
                    }
                }
                .listStyle(.plain)
                .searchable(text: $searchText)
                .frame(height: UIScreen.screenHeight, alignment: .center)
                .listRowBackground(CustomColor.lightBg)
                .onChange(of: searchText) { value in
                    if !value.isEmpty {
                        self.searchViewModel.searchForNameSymbol(value: searchText)
                        print(self.searchViewModel.tickets)
                    } else {
                        searchViewModel.tickets.removeAll()
                    }
                }
            }
            .padding(.top, 20)
            .frame(width: UIScreen.screenWidth, alignment: .center)
            .navigationTitle("Bar")
            .background(CustomColor.lightBg)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                SearchNavigationBar(searchText: $searchText)
            }
        }
    }
}
