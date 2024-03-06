//
//  FilterView.swift
//  Scribd Take Home
//
//  Created by Kenny Barone on 3/5/24.
//

import Foundation
import SwiftUI

struct FilterView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: HomeViewModel
    @State private var localFilters: [FilterOption]

    init(viewModel: HomeViewModel) {
        self._viewModel = ObservedObject(initialValue: viewModel)
        self._localFilters = State(initialValue: viewModel.filters)
    }

    init(viewModel: HomeViewModel, localFilters: [FilterOption]) {
        self._viewModel = ObservedObject(initialValue: viewModel)
        self._localFilters = State(initialValue: localFilters)
    }

    var body: some View {
        ZStack {
            Color(color: .PrimaryBackground).ignoresSafeArea()
            VStack(alignment: .leading) {
                HStack {
                    Text("Formats")
                        .font(TextStyle.bookTitle.font)
                        .foregroundStyle(Color(color: .PrimaryText))
                        .padding([.bottom], 4)
                    Spacer()
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                        HapticGenerator.shared.play(.soft)

                    }) {
                        Image(symbol: .XCircle)
                            .resizable()
                            .frame(width: 36, height: 36)
                            .background(Circle().foregroundStyle(Color(color: .SecondaryText)))
                            .foregroundStyle(.black)
                            .overlay(
                                Circle().stroke(Color.black, lineWidth: 2) 
                            )
                    }
                }

                Button(action: {
                    clearFilters()
                    HapticGenerator.shared.play(.light)
                }) {
                    Text("Clear all")
                        .font(TextStyle.subheader.font)
                        .foregroundStyle(Color(color: .SecondaryText))
                        .padding([.bottom], 8)
                }

                LazyVStack(alignment: .leading) {
                    ForEach($localFilters, id: \.id) { $filterOption in
                        FilterSelectView(filterOption: $filterOption, toggleAction: {
                            toggleFilter(forBookFormat: filterOption.bookFormat, selected: !filterOption.selected)
                        })
                    }
                }
                Spacer()
                Button(action: {
                    viewModel.applyFilters(localFilters)
                    HapticGenerator.shared.play(.soft)
                    self.presentationMode.wrappedValue.dismiss()

                }) {
                    Text("Apply")
                        .font(TextStyle.largeButton.font)
                        .foregroundStyle(Color(color: .PrimaryBackground))
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 18)
                        .padding()
                }
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(color: .PrimaryText))
                )

            }
            .padding([.leading, .top, .trailing], 16)
        }
    }

    private func toggleFilter(forBookFormat format: BookFormat, selected: Bool) {
        if selected {
            for i in 0..<localFilters.count {
                if localFilters[i].selected {
                    localFilters[i].selected = false
                } else if localFilters[i].bookFormat == format {
                    localFilters[i].selected = true
                }
            }
        } else {
            if let i = localFilters.firstIndex(where: { $0.bookFormat == format }) {
                localFilters[i].selected = false
            }
        }
        localFilters = localFilters.map { $0 }
    }

    private func clearFilters() {
        for i in 0..<localFilters.count {
            localFilters[i].selected = false
        }
    }
}

struct FilterSelectView: View {
    @Binding var filterOption: FilterOption
    var toggleAction: () -> Void

    var body: some View {
        Button(action: {
            HapticGenerator.shared.play(.light)
            toggleAction()
        }) {
            Text("\(filterOption.bookFormat.rawValue)s")
                .font(TextStyle.subheader.font)
                .foregroundStyle(Color(color: .PrimaryText))
                .padding(.bottom, 8)
                .padding(.top, 4)

            Spacer()
            Image(symbol: filterOption.selected ? .CheckedBox : .Box)
                .resizable() // Make the image resizable
                .aspectRatio(contentMode: .fill)
                .imageScale(.medium)
                .frame(width: 24, height: 24)
                .foregroundStyle(Color.white)
        }
    }
}

#Preview {
    FilterView(viewModel: HomeViewModel(serviceContainer: ServiceContainer.shared), localFilters: [FilterOption(bookFormat: .Audiobook), FilterOption(bookFormat: .EBook)])
}
