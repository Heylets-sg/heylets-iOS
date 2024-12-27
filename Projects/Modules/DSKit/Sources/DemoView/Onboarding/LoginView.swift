//
//  LoginView.swift
//  DSKit
//
//  Created by 류희재 on 12/23/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    let images: [UIImage] = [.timeTable, .color] // 테스트용 이미지
    
    public var body: some View {
        ZStack {
            Color.heyMain.ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 120)
                
                Text("Add a personal schedule to\nyour school timetable")
                    .font(.bold_20)
                    .foregroundColor(.heyWhite)
                    .lineSpacing(3.5)
                    .padding(.bottom, 12)
                    .padding(.leading, 16)
                    .lineLimit(2)
                
                Text("Manage your school-related schedules\nall at once!")
                    .font(.medium_14)
                    .foregroundColor(.heyWhite)
                    .padding(.leading, 16)
                    .lineLimit(2)
                
                Spacer()
                    .frame(height: 52)
                
                CarouselView(pageCount: images.count, visibleEdgeSpace: 0, spacing: 0) { index in
                    Image(uiImage: images[index])
                        .resizable()
                        .scaledToFit()
                }
                .frame(height: 353) // 전체 Carousel 뷰의 높이 설정
                .padding(.horizontal, 0) // 양쪽 여백을 없애기 위해 horizontal padding 0
                
                Spacer()
                
                VStack {
                    Button("Sign up") {
                    }
                    .heyBottomButtonStyle(.white)
                    .padding(.bottom, 16)
                    
                    Button("Log in") {
                    }.heyBottomButtonStyle(.black)
                }
                .padding(.horizontal, 16)
                
                Spacer()
                    .frame(height: 65)
            }
        }
        .ignoresSafeArea(edges: .vertical)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    LoginView()
}
