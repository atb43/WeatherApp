//
//  HomeView.swift
//  WeatherApp
//
//  Created by hope on 1/13/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            weatherImage
            
            VStack(alignment: .trailing) {
                cityTemperatureRow
                Spacer()
                
                weatherRow
                Spacer()
                
                InfoRow(icon: "sunrise", title: "Sun rise", value: viewModel.weather.sunriseTime)
                Spacer()
                
                InfoRow(icon: "wind", title: "Wind", value: viewModel.weather.wind)
                Spacer()
                
                InfoRow(icon: "humidity", title: "Humidity", value: viewModel.weather.humidity)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            Button {
                Task {
                    await viewModel.getWeather()
                }
            } label: {
                Image(systemName: "goforward")
                    .resizable()
                    .frame(width: 28, height: 28)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .disabled(viewModel.showLoading)
            
            LoaderView(scaleSize: 1.6)
                .visible(viewModel.showLoading)
            
        }
        .task {
            await viewModel.getWeather()
        }
    }
    
    var weatherImage: some View {
        let height: CGFloat = UIScreen.main.bounds.height / 3 * 2
        let width: CGFloat = UIScreen.main.bounds.width
        
        return Image(data: viewModel.weatherImage)
            .resizable()
            .scaledToFill()
            .frame(width: width, height: height)
            .offset(x: -width / 2, y: -60)
    }
    
    var cityTemperatureRow: some View {
        VStack(alignment: .trailing) {
            HStack {
                Image("Image")
                    .iconModifier(size: 24)
                Text(viewModel.weather.cityName)
                    .font(.system(size: 26))
            }
            Text(viewModel.weather.temperatureRange)
                .font(.system(size: 18))
        }
    }
    
    var weatherRow: some View {
        VStack(alignment: .trailing, spacing: 0) {
            HStack {
                Text(viewModel.weather.temperature)
                    .font(.system(size: 72, weight: .bold))
                    .frame(maxHeight: .infinity)
                VStack {
                    Text("o")
                        .font(.system(size: 24))
                        .frame(alignment: .topLeading)
                    Spacer()
                    Text(viewModel.weather.units.temperature.uppercased())
                        .font(.system(size: 24))
                }
                .padding([.top, .bottom], 12)
                .frame(maxHeight: .infinity)
            }
            .fixedSize(horizontal: false, vertical: true)
            
            Text(viewModel.weather.weatherType)
                .font(.system(size: 32))
                .bold()
        }
    }
    
    private func InfoRow(icon: String, title: String, value: String) -> some View {
        VStack(alignment: .trailing) {
            Image(icon)
                .iconModifier()
            Text(title)
                .font(.system(size: 18))
            Text(value)
                .font(.system(size: 24))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
