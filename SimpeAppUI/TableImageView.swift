//
//  TableImageView.swift
//  SimpeAppUI
//
//  Created by Alexander Shevtsov on 17.03.2025.
//

import SwiftUI

struct TableImageView: View {
    let size: CGSize
    
    var body: some View {
        Image(systemName: "table")
            .resizable() // !сбрасываем значения по умолчанию перед модификаторами
//          .frame(width: size.width, height: size.height) // вместо этого ->
//          .modifier(FrameFromSize(size: size)) // пример как работает
            .frame(size: size) // use наш кастомный модификатор
            .background(Color(white : 0.9)) // почти берый фон
            .clipShape(Circle()) // скругление по кругу
            .overlay(Circle().stroke(Color.red, lineWidth: 8)) // ореол
            .foregroundStyle(.red) // красим табл в ред
    }
}
// создаем собственный модификатор!
struct FrameFromSize: ViewModifier { // !подписываем под ViewModifier
    let size: CGSize // определяем свойство для передачи
    
    func body(content: Content) -> some View { // func !body
        content // берем контент
            .frame(width: size.width, height: size.height) // add модификаторов
    }
}

extension View { // расширяем вью
    func frame(size: CGSize) -> some View {
        modifier(FrameFromSize(size: size))
    }
}

#Preview {
    TableImageView(size: CGSize(width: 250, height: 250))
}
