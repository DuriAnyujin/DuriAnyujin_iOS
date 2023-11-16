//
//  MainPageView.swift
//  DuriAnyujin
//
//  Created by mobicom on 2023/11/07.
//

import SwiftUI

struct MainPageView: View {
    var body: some View {
        NavigationView {
            Text("안녕? 나 메인페이지.")
                .navigationTitle("메인페이지")
        }
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
