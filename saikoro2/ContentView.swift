import SwiftUI

struct ContentView: View {
    @State private var randomValue = "Who!"
    @State private var isRolling = false
    @State private var isButtonHidden = false // ボタンの表示非表示を制御するプロパティ
    @State private var sliderValue:Double = 8.0 // デフォルトのスライダーの値

    
    var body: some View {
            
                VStack {
                    Text(randomValue)
                        .font(.largeTitle)
                        .padding(20)
                    
                    Button(action: {
                        isRolling = true
                        isButtonHidden = true // ボタンを非表示にする
                        rollDice()

                        // 1秒後にボタンを再表示
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            isButtonHidden = false
                        }
                    })
                    {
                        Text("Start")
                            .foregroundColor(.black)
                    }
                    .opacity(isButtonHidden ? 0 : 0.8) // ボタンを非表示にする
                    Text("1-\(Int(sliderValue))")
                    
                    Slider(
                        value: $sliderValue,
                        in: 1...10
                    )
                    .tint(.green)//green
                        .padding(10)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
    }

    func rollDice() {
        let maxRolls = Int(1 / 0.05) // 3秒間で0.05秒ごとに更新する回数

        var currentRoll = 0
        let timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            if currentRoll < maxRolls {
                let random = Int.random(in: 1...Int(sliderValue))
                randomValue = String(random)
                currentRoll += 1
            } else {
                timer.invalidate() // 1秒経過後にタイマーを停止
                isRolling = false
            }
        }
        RunLoop.current.add(timer, forMode: .common)
    }
}
