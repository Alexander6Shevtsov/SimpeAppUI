//
//  ContentView.swift
//  SimpeAppUI
//
//  Created by Alexander Shevtsov on 16.03.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var sliderValue = Double.random(in: 0...255) // нач знач
    @State private var userName = "" // иниц в TextField
    @State private var displayedName = "" // для валидации данных
    @State private var isPresented = false // состояние AlertController
    
    var body: some View {
        VStack(spacing: 40) { // spacing отступы во всем стеке
            Text("\(lround(sliderValue))") // lround округляет до целых
                .font(.largeTitle)
            
            UserNameView(name: displayedName)
            ColorSliderView(value: $sliderValue) //$свойство делает данные <->
            
            TextField("Enter your name", text: $userName) // плейсхолдер
                .bordered() // и просто вызываем под текстовым полем
            
            
            Button("Done", action: checkUserName) // сразу передаем в параметр
                .alert("Wrong format", isPresented: $isPresented, actions: {}) {
                    Text("Enter your name") // if нужна только кнопка ОК
                }
            
            Text("Welcome to SwiftUI!")
                .font(.system(size: 60)) // если нужен определенный размер
                .bold() // утолщение, можно для system изображений тоже
                .foregroundStyle(.red)
                .background(.blue) // важна последовательность модификаторов
                .padding()
                .background(.red)
                .clipShape(.rect(cornerRadius: 20))
            
            Spacer()
        }
        .padding()
    }
    
    private func checkUserName() { // валидация имени
        if let _ = Double(userName) { // если сможем извлечь число приведением
            userName = "" // стираем поле и выходим
            isPresented.toggle() // меняем значение на противоположное
            return
        }
        // валидация прошла
        displayedName = userName // передаем данные по нажатию
        userName = "" // стираем после нажатия поле ввода
    }
}

#Preview {
    ContentView()
}

struct ColorSliderView: View {
    @Binding var value: Double
    
    var body: some View {
        HStack {
            Text("0").foregroundStyle(.red) // если 1 модификатор в одну стр
            Slider(value: $value, in: 0...255, step: 1) // шаг по 1
            Text("255").foregroundStyle(.red)
        }
    }
}

struct UserNameView: View {
    let name: String
    
    var body: some View {
        HStack { // помещаем в HStack чтоб выровнять в лево
            HStack(alignment: .firstTextBaseline) { // выравнивание по 1 тексту
                Text("USER NAME: ").frame(height: 60)
                Text(name)
                    .font(.largeTitle)
            }
            Spacer() // выравниваем по лев краю
        }
    }
}

struct BorderedViewModifier : ViewModifier { // кастомное текстовое поле
    func body(content: Content) -> some View {
        content
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 4) // прямоугольное скругление
                    .stroke(lineWidth: 2) // ореол
                    .foregroundStyle(.blue)
            )
            .shadow(color: .gray.opacity(0.4), radius: 3, x: 1, y: 2) // тени+
    }
}

extension TextField { // кастом только для TextField
    func bordered() -> some View {
        modifier(BorderedViewModifier())
    }
}
