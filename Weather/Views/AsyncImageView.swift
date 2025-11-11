//
//  AsyncImageView.swift
//  Weather
//
//  Created by Sayaka Sasaki on 2025/11/09.
//

import SwiftUI

struct AsyncImageView: View {
    //画像URLの文字列
    let urlStr: String

    var body: some View {
        // URL型に変換できたらAsyncImageで画像を取得
        if let url = URL(string: urlStr) {
            AsyncImage(url: url) { image in
                image.resizable()
            } placeholder: {
                ProgressView()  
                    .scaledToFit()
            }
        } else {
            Text("No Image")
        }
    }

}

#Preview {
    // AsyncImageView()
    // 八幡平市の市章画像のURL文字列
    let urlStr = "https://www.city.hachimantai.lg.jp/img/common/top_logo.png"
    AsyncImageView(urlStr: urlStr)
}
