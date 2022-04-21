//
//  SearchView.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import SwiftUI
import ActivityIndicatorView

struct SearchView: View {
    @State var searchText: String
    @StateObject private var searchViewModel: SearchViewModel
    
    init (searchViewModel: SearchViewModel?, searchText: String) {
        _searchViewModel = StateObject(wrappedValue: searchViewModel ?? SearchViewModel(repository: nil))
        _searchText = State(wrappedValue: searchText)
    }
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView(showsIndicators: false) {
                    List {
                        ForEach(searchViewModel.tickets, id: \.conid) { ticket in
                            TicketItem(title: ticket.companyName ?? "", exchange: ticket.description ?? "", conid: ticket.conid)
                        }
                    }.padding(.top, 20)
                    .listStyle(.plain)
                    .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic))
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
            .opacity(searchViewModel.isLoading ? 0.5 : 1)
            ActivityIndicatorView(isVisible: $searchViewModel.isLoading, type: .scalingDots)
                .foregroundColor(Color.white)
                .frame(width: 80, height: 50, alignment: .center)
        
        }
    }
}

struct SearchView_Preview: PreviewProvider {
    static var previews: some View {
        let searchViewModel = SearchViewModel(repository: SearchRepository(apiService: MockSearchApiService(searchTicket: nil)))
        
        SearchView(searchViewModel: searchViewModel, searchText: "")
            .environment(\.colorScheme, .dark)
            .background(CustomColor.lightBg)
            .onAppear(perform: {
                searchViewModel.searchForNameSymbol(value: "s")
            })
    }
}
