//
//  WeatherViewModel.swift
//  OfficeMate
//
//  Created by Happiness Adeboye on 10/05/2025.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var temperatureText: String = "Loading..."
    private var cancellables = Set<AnyCancellable>()

    func fetchWeather() {
        let apiKey = "af0389700a7658a5af466b2c3e0f27fb"
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=-33.8688&lon=151.2093&appid=\(apiKey)&units=metric"

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .map { "\($0.main.temp)°C • \($0.weather.first?.description.capitalized ?? "")" }
            .replaceError(with: "Unable to fetch")
            .receive(on: DispatchQueue.main)
            .assign(to: &$temperatureText)
    }
}
