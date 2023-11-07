//
//  DuriAnyujinApp.swift
//  DuriAnyujin
//
//  Created by mobicom on 2023/10/17.
//

import SwiftUI

@main
struct DuriAnyujinApp: App {
    @State var isActive: Bool = false
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if isActive {
                    MainPageView() // 실제 메인 페이지
                } else {
                    SplashView() // 스플래시 화면 뷰
                        .onAppear {
                            // 앱이 시작된 후 2초 뒤에 isActive 상태를 변경
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.7) {
                                withAnimation {
                                    self.isActive = true // 이제 메인 페이지로 전환됩니다.
                                }
                            }
                        }
                }
            }
        }
    }
}
