//
//  BookCardView.swift
//  Scribd Take Home
//
//  Created by Kenny Barone on 3/5/24.
//

import SwiftUI

struct BookCardView: View {
    @ObservedObject var viewModel: HomeViewModel
    let book: Book
    let index: Int
    let buttonConfig = UIImage.SymbolConfiguration(pointSize: TextStyle.paragraph.uiFont.pointSize, weight: .regular)

    var body: some View {
        HStack(alignment: .top, content: {
            Text("\(index + 1).")
                .font(TextStyle.bookAuthor.font)
                .foregroundStyle(Color(color: .PrimaryText))
                .padding(.leading, 8)
                .padding(.top, 4)
            if let imageData = book.imageData {
                Image(uiImage: imageData)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 150)
            } else {
                Image(symbol: .DefaultBook)
                    .imageScale(.large)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 150)
                    .background(.secondaryText)
            }

            VStack(alignment: .leading, content: {
                Text(book.title)
                    .font(TextStyle.bookTitle.font)
                    .foregroundStyle(Color(color: .PrimaryText))
                    .lineLimit(2)
                    .padding([.bottom], 1)
                Text(book.author)
                    .font(TextStyle.bookAuthor.font)
                    .foregroundStyle(Color(color: .PrimaryText))
                    .minimumScaleFactor(0.7)
                    .lineLimit(1)
                    .padding([.bottom], 2)
                StarView(rating: book.rating)
                    .padding([.leading], 4)
            })
            .padding(.leading, 8)
            .padding(.top, 4)

            Spacer()

            Button(action: {
                viewModel.toggleBookmark(forBookID: book.id)
                HapticGenerator.shared.play(.light)
            }) {
                Image(symbol: book.bookmarked ? .BookmarkFill : .Bookmark)
                    .resizable() // Make the image resizable
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 16, height: 16)
                    .foregroundStyle(Color.white)
            }
            .padding([.top], 12)
            .padding([.bottom, .trailing], 8)
        })

        .background(Color(color: .PrimaryBackground))
        .padding(.zero)
    }
}

struct StarView: View {
    let rating: Double
    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { number in
                Image(symbol:
                        CGFloat(number) <= rating ? .StarFill :
                        CGFloat(number) - 0.7 < rating ? .StarHalfFill :
                        .Star)
                .foregroundStyle(Color(color: .PrimaryText))
                    .imageScale(.small)
                    .frame(width: 10, height: 10)
            }
        }
    }
}

#Preview {
    BookCardView(viewModel: HomeViewModel(serviceContainer: ServiceContainer.shared), book: Book(title: "Sample", author: "Sample", rating: 4, format: .Audiobook), index: 1)
}

