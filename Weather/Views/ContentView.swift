//
//  ContentView.swift
//  Weather
//
//  Created by Sayaka Sasaki on 2025/11/09.
//

import SwiftUI

struct ContentView: View {
    //APIへリクエスト、レスポンスの値を保持するプロジェクト
    @StateObject private var weatherVM = WeatherViewModel()
    
    //⚪︎県⚪︎市⚪︎⚪︎の緯度・経度
    var lat: Double = 39.91167
    var lon: Double = 141.093459
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            weatherVM.request3DaysForecast(lat: lat, lon: lon)
        }
    }
}

#Preview {
    ContentView()
}
