//
//  ContentView.swift
//  Scribd Take Home
//
//  Created by Kenny Barone on 3/5/24.
//

import SwiftUI
import UIKit

struct HomeContentView: View {
    @StateObject var viewModel: HomeViewModel
    @State private var isFiltersPresented = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color(color: .PrimaryBackground).ignoresSafeArea()
                if viewModel.isLoading {
                    VStack {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color(color: .PrimaryText)))
                            .scaleEffect(1.5)
                            .padding(.top, 40)
                        Spacer()
                    }

                } else {
                    ScrollView {
                        LazyVStack(alignment:.leading) {
                            Rectangle()
                                .foregroundStyle(.secondaryText.opacity(0.2))
                                .frame(width: .none, height: 1)

                            Text("The most popular books and audiobooks generating buzz from critics, the NYT, and more.")
                                .font(TextStyle.subheader.font)
                                .foregroundStyle(Color(color: .SecondaryText))
                                .padding([.leading, .trailing], 16)
                                .padding([.top, .bottom], 8)


                            Button(action: {
                                isFiltersPresented = true
                                HapticGenerator.shared.play(.soft)
                            }) {
                                HStack {
                                    Text(
                                        viewModel.activeFilter == nil ?
                                        "Format" :
                                            "\(viewModel.activeFilter!.bookFormat.rawValue)s"
                                    )
                                    .font(TextStyle.smallButton.font)
                                    .foregroundStyle(
                                        viewModel.activeFilter == nil ?
                                        Color(color: .PrimaryText) :
                                            Color(color: .PrimaryBackground)

                                    )
                                    Image(symbol: .DownCarat)
                                        .imageScale(.small)
                                        .frame(width: 10, height: 10)
                                        .foregroundStyle(
                                            viewModel.activeFilter == nil ?
                                            Color(color: .PrimaryText) :
                                                Color(color: .PrimaryBackground)
                                        )
                                }

                                .padding([.leading, .trailing], 16)
                                .padding([.top, .bottom], 8)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .strokeBorder(Color(color: .SecondaryText), lineWidth: 1)
                                        .fill(                                 viewModel.activeFilter == nil ? Color.clear :
                                                                                Color(color: .PrimaryText)
                                             )
                                )
                            }
                            .sheet(isPresented: $isFiltersPresented) {
                                FilterView(viewModel: viewModel)
                                    .presentationDetents([.fraction(0.34)])
                                    .presentationDragIndicator(.visible)
                            }
                            .frame(maxWidth: .none, alignment: .leading)
                            .padding(.leading, 16)

                            ForEach(Array(viewModel.books.enumerated()), id: \.element.id) { index, book in
                                BookCardView(viewModel: viewModel, book: book, index: index)
                            }
                            .padding(EdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 16))
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Top Charts")
                        .font(TextStyle.header.font)
                        .foregroundStyle(Color(color: .PrimaryText))
                }
            }
            .toolbarBackground(
                Color(color: .PrimaryBackground),
                for: .navigationBar)
        }
        .onAppear {
            viewModel.requestBooks()
        }
    }
}

#Preview {
    HomeContentView(viewModel: HomeViewModel(serviceContainer: ServiceContainer.shared))
}
