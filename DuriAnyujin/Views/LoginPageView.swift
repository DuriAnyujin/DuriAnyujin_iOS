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
                                // 유저의 유니크 ID
                                let userIdentifier = appleIDCredential.user
                                // 유저의 이메일
                                let useremail = appleIDCredential.email
                                // 유저의 전체 이름
                                let fullName = appleIDCredential.fullName
                                
                                // 여기서 인증 정보를 사용하여 앱 내 로그인 처리
                                // 예를 들어, 서버로 인증 정보를 보내 사용자를 인증
                                
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

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}

