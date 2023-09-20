//
//  ContentView.swift
//  calculator
//
//  Created by Paul Huynh on 2023-09-19.
//

import SwiftUI

enum CalculatorButton: String {
    case ac, plusminus, percent, divide
    case seven, eight, nine, multiply
    case four, five, six, minue
    case one, two, three, plus
    case zero, period, equal
    

    var title: String {
        switch self {
        case .seven:
           return "7"
        case .eight:
            return "8"
        case .nine:
            return "9"
        case .multiply:
            return "X"
        case .four:
            return "4"
        case .five:
            return  "5"
        case .six:
            return "6"
        case .minue:
            return "-"
        case .one:
            return "1"
        case .two:
            return "2"
        case .three:
            return "3"
        case .plus:
            return "+"
        case .zero:
            return "0"
        case .period:
            return "."
        case .equal:
            return "="
        case .ac:
            return "AC"
        case .plusminus:
            return "+-"
        case .percent:
            return "%"
        case .divide:
            return "/"
        }
    }
    
    var backgroundColour: Color {
        switch self {
        case .ac, .plusminus, .percent:
            return Color(.darkGray)
        case .multiply, .divide, .minue, .plus, .equal:
            return Color(.orange)
        default:
            return Color(.lightGray)
        }
    }
}

//Treat this as a global application state
//Similar to Singleton useful when we have lots of subViews
class GlobalEnvironment: ObservableObject {
    @Published var display = "00"
    
    func receiveInput(calculateButton: CalculatorButton) {
        self.display = calculateButton.title
        
    }
}

struct ContentView: View {
    @EnvironmentObject var env: GlobalEnvironment
    let buttons: [[CalculatorButton]] = [
        [.ac, .plusminus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minue],
        [.one, .two, .three, .plus],
        [.zero, .period, .equal]
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 12) {
                HStack {
                    Spacer()
                    Text(env.display)
                        .foregroundColor(.white)
                        .font(.system(size: 42))
                }.padding()
                ForEach(buttons, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { button in
                            CalculatorButtonView(button: button)
                        }
                    }
                }
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView().environmentObject(GlobalEnvironment())
        }
    }
    
    //This is consider a subview
    struct CalculatorButtonView: View {
        @EnvironmentObject var env: GlobalEnvironment
        var button: CalculatorButton
        
        var body: some View {
            Button(button.title) {
                
                self.env.receiveInput(calculateButton: button)
            }
            .font(.system(size: 32))
            .frame(width: self.buttonWidth(button: button), height: (UIScreen.main.bounds.width - 5 * 12) / 4)
            .foregroundColor(.white)
            .background(button.backgroundColour)
            .cornerRadius(self.buttonWidth(button: button))
        }
        
        private func buttonWidth(button: CalculatorButton) -> CGFloat {
            if button == .zero {
                return (UIScreen.main.bounds.width - 4 * 12) / 4 * 2
            } else {
                //5 gaps between 4 buttons
                return (UIScreen.main.bounds.width - 5 * 12) / 4
            }
        }
    }
    
}
