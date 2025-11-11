//
//  DailyWeatherView.swift
//  Weather
//
//  Created by Sayaka Sasaki on 2025/11/09.
//

import SwiftUI

struct DailyWeatherView: View {
    @ObservedObject var weatherVM: WeatherViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            
            //レスポンスに天気予報の情報があった時のif文
            if let forecastsDay = weatherVM.forecast?.forecastsDay {
                
                HStack {
                    ForEach(forecastsDay,id: \.self) { forecastsDay in
                        //1日分の天気予報のUI
                        VStack(spacing: 5) {
                            //日付
                            Text(forecastsDay.toDisplayDate(forecastsDay.date))
                                .font(.callout) //フォントをコールアウトのスタイルに
                            
                            //天気アイコン画像
                            AsyncImageView(urlStr: "https:\(forecastsDay.day.condition.icon)")
                            
                            //天気の説明
                            Text(forecastsDay.day.condition.text)
                                .font(.headline)
                            
                            //最高気温、最低気温
                            HStack {
                                //最高
                                Text(forecastsDay.day.maxTemp, format: .number)
                                    .foregroundStyle(.red)
                                Text("℃")
                                    .foregroundStyle(.red)
                                
                                Text("/")
                                
                                //最低
                                Text(forecastsDay.day.minTemp, format: .number)
                                    .foregroundStyle(.blue)
                                Text("℃")
                                    .foregroundStyle(.blue)
                            }
                            
                            //降水確率：⚪︎％
                            HStack {
                                Text("降水確率：")
                                Text(forecastsDay.day.dailyChanceOfRain, format: .number)
                                Text("%")
                            }
                            
                            //月の満ち欠け
                            Image(forecastsDay.day.moonPhase.icon)
                            
                            
                            .font(.subheadline)
                        }
                        .padding()
                        .frame(width: ScreenInfo.width / 2, height: ScreenInfo.height / 3)
                        .background(.yellow.opacity(0.2))
                        .clipShape(.rect(cornerRadius: 26))
                    }
                }
                
            } else {
                //データがない時に表示する
                HStack {
                    ForEach(0...2,id: \.self) { _ in
                        VStack(spacing: 5) {
                            Text("____年__月__日")
                            
                            //天気アイコン画像
                            Image(systemName: "cloud.sun")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 64, height: 64)
                            
                            //天気の説明
                            Text("晴れのち曇り")
                            
                            //最高気温、最低気温
                            HStack {
                                Text("最高")//数字が入る
                                Text("℃/")
                                Text("最低")//数字が入る
                                Text("℃")
                            }
                            
                            //降水確率：⚪︎％
                            HStack {
                                Text("降水確率：")
                                Text("〇〇")//数字が入る
                                Text("%")
                            }
                            
                            //月の満ち欠け
                            
                        }
                        .padding()
                        .frame(width: ScreenInfo.width / 2, height: ScreenInfo.height / 3)
                        .background(.yellow.opacity(0.2))
                        .clipShape(.rect(cornerRadius: 26))
                    }
                }
            }
            
        }
    }
}

#Preview {
    //    DailyWeatherView()
    @Previewable @StateObject var weatherVM = WeatherViewModel()
    // 八幡平市大更の緯度・経度
    let lat: Double = 39.91167
    let lon: Double = 141.093459
    
    DailyWeatherView(weatherVM: weatherVM)
        .onAppear {
            weatherVM.request3DaysForecast(lat: lat, lon: lon)
        }
    
}
