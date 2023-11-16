//
//  LoginPage.swift
//  DuriAnyujin
//
//  Created by 길지훈 on 2023/11/08.
//

import SwiftUI
import AuthenticationServices

struct LoginPageView: View {
    
    @State private var textOpacity1 = 0.0
    @State private var textOpacity2 = 0.0
    @State private var btnOpacity = 0.0
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                // Text Group
                Group {
                    Text("로그인을 하고")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, 30)
                        .opacity(textOpacity1)
                    
                    Text("Qouple과 함께하세요.")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, 60)
                        .opacity(textOpacity2)
                }
                // Apple Login 구현부
                SignInWithAppleButton(
                    .signIn,
                    onRequest: { request in
                        request.requestedScopes = [.fullName, .email]
                    },
                    onCompletion: { result in
                        switch result {
                        case .success(let authResults):
                            switch authResults.credential {
                            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                                if let authorizationCodeData = appleIDCredential.authorizationCode,
                                   let authorizationCode = String(data: authorizationCodeData, encoding: .utf8),
                                   let idTokenData = appleIDCredential.identityToken,
                                   let idTokenString = String(data: idTokenData, encoding: .utf8) {
                                    // 서버에 authorizationCode와 idToken을 전송합니다.
                                    sendAuthorizationCodeToServer(authorizationCode, idToken: idTokenString)
                                }
                            default:
                                break
                            }
                        case .failure(let error):
                            // 인증 과정에서 오류 발생
                            print("Authentication failed with error: \(error.localizedDescription)")
                        }
                    }
                )
                .opacity(btnOpacity)
                .signInWithAppleButtonStyle(.whiteOutline)
                .frame(width : UIScreen.main.bounds.width * 0.6, height:50)
                .cornerRadius(5)
                .navigationTitle("로그인 페이지")
                .shadow(radius: 3)
                Spacer()
                Spacer()
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 1.0)) { // 1.5초 동안 천천히 애니메이션 적용
                    textOpacity1 = 1.0
                }
                withAnimation(.easeInOut(duration: 1.5)) {
                    textOpacity2 = 1.0
                }
                withAnimation(.linear(duration: 1.5)) {
                    btnOpacity = 1.0
                }
            }
        }
    }
}

func sendAuthorizationCodeToServer(_ authorizationCode: String, idToken: String) {
    guard let url = URL(string: "https://d58d16dc-927a-4464-aae0-af8ec0ebd302.mock.pstmn.io") else { return }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let body: [String: Any] = [
        "authorizationCode": authorizationCode,
        "idToken": idToken
    ]

    request.httpBody = try? JSONSerialization.data(withJSONObject: body)
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            // 오류 처리
            print("Error sending authorization code: \(error)")
            return
        }
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            // 서버 응답 오류 처리
            print("Invalid response from server")
            return
        }
        
        // 성공적인 응답 처리
        // 예: 서버로부터 받은 토큰을 저장하거나 UI를 업데이트
    }.resume()
}


struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}

