//
//  ContentView.swift
//  SimpeAppUI
//
//  Created by Alexander Shevtsov on 16.03.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var sliderValue = Double.random(in: 0...255) // нач знач
    
    var body: some View {
        VStack {   // lround округляет до целых
            Text("\(lround(sliderValue))") // в текст передаем свойство
                .font(.largeTitle)
            ColorSliderView(value: $sliderValue)//$свойство делает данные <->
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

struct ColorSliderView: View {
    @Binding var value: Double
    
    var body: some View {
        HStack {
            Text("0").foregroundStyle(.red) // 1 модификатор в одну стр
            Slider(value: $value, in: 0...255, step: 1)// шаг по 1
            Text("255").foregroundStyle(.red)
        }
    }
}
