//
//  ViewModel.swift
//  Aibar100
//
//  Created by Swift on 06.02.2023.
//

import Foundation




class WeatherViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var descriptionText: String = ""
    @Published var temp: String = ""
    @Published var timezone: String = ""
    
    init() {
        fethWeather()
    }
    func fethWeather() {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?exclude=hourly,daily,minutely&lat=42.361145&lon=-71.057083&units=imperil&appid=6adb3d1c71528ff60683e4cfa24c72ed") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let model = try JSONDecoder().decode(WeatherModel.self, from: data)
                DispatchQueue.main.async {
                    self.title = model.current.weather.first?.main ?? "no title"
                    self.descriptionText = model.current.weather.first?.description ?? "no description"
                    self.temp = "\(model.current.temp) f"
                    self.timezone = model.timezone
                }
            }
            catch {
                print("error")
            }
        }
        task.resume()
    }
}
