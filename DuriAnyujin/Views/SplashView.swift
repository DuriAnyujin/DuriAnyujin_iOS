//
//  ContentView.swift
//  DuriAnyujin
//
//  Created by mobicom on 2023/10/17.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
            LottieView(jsonName: "lottie-splash")
    }
}

struct SplashView_preview: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
