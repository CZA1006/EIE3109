//
//  ContentView.swift
//  Calculator
//
//  Created by 蔡卓昂 on 9/10/2022.
//

import SwiftUI

struct ContentView: View {
    @State var value = "0" //the use of @State????
    @State var isUserEnteringNumber = false
    
    let buttons: [[CalcuButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        ZStack {
            //Color.black to Color.black.edgesIgnoringSafeArea(.all) difference: 黑色变全屏
            //除去.all其他的choice
            //.horizontal: 四角未覆盖黑色
            //.bottom: 上方两角未覆盖黑色
            //.top: 下方两角覆盖黑色
            //.trailing: 四角未覆盖黑色
            //.vertical: 黑色变全屏
            //.leading:四角未覆盖黑色
            Color.black.edgesIgnoringSafeArea(.all)
            VStack{
            HStack{
                Spacer()
                Text(value)
                //字体Sytle
                    .bold()
                    .font(.system(size: 100))
                    .foregroundColor(.white)
            }
            .padding()
            ForEach (buttons, id: \.self){ row in
                HStack (spacing: 12){
                    ForEach(row, id: \.self){ item in
                        Button(action: {
                            didTap(button: item)
                        }, label: {
                            Text(item.rawValue)
                                .font(.system(size: 32))
                                .frame(width: self.buttonWidth(item: item),height: self.buttonHeight())
                                .background(item.buttonColor)
                                .foregroundColor(.white)
                                .cornerRadius(self.buttonHeight()/2)
                        })
                        
                    }
                }
                .padding(.bottom, 3)
            }
        }
    }
}
    func buttonWidth(item: CalcuButton) -> CGFloat{
        let width = (UIScreen.main.bounds.width - (5*12)) / 4
        if UIDevice.current.userInterfaceIdiom == .pad { //判断是否是ipad
            if item == .zero {
                return width
            }
            return width / 2
        }
        else if item == .zero {
            return width * 2 // exercise 1
        }
        
        return width
        
    }
    
    func buttonHeight() -> CGFloat{
        let hight = (UIScreen.main.bounds.width - (5*12)) / 4
        if UIDevice.current.userInterfaceIdiom == .pad { //判断是否是ipad
            return hight / 2
        }
        return hight
    }
    
    func didTap(button: CalcuButton){
        if button.isDigit == true{
            digitPressed(button: button)
        } else{
            operationPressed(button: button)
        }
    }
    
    func digitPressed(button: CalcuButton){
        let number = button.rawValue
        if(isUserEnteringNumber == false){
            self.value = number
        }
        else{
            self.value = "\(self.value)\(number)"}
        isUserEnteringNumber = true
    }
    
    func operationPressed(button: CalcuButton){
        
    }
}

//Calculator elements(bottons)
enum CalcuButton: String{
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case multiply = "x"
    case divide = "÷"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "+/-"
    var buttonColor: Color{
        switch self{
        case .add, .subtract, .multiply, .divide, .equal:
            return .orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
    var isDigit: Bool{
        switch self {
        case .one, .two, .three, .four, .five, .six,
                .seven, .eight, .nine, .zero, .decimal:
            return true
        default:
            return false
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
