import SwiftUI

public struct CarouselView<Content: View>: View {
    public typealias PageIndex = Int
    
    let pageCount: Int
    let visibleEdgeSpace: CGFloat // 화면의 양쪽 가장자리에 보일 여백
    let spacing: CGFloat // 두 뷰 사이에 간격
    let content: (PageIndex) -> Content // 페이지마다 어떤 뷰가 들어갈지 정의하는 클로저
    
    @GestureState var dragOffset: CGFloat = 0 // 드래그 중 페이지 이동을 추적하기 위한 상태
    @State var currentIndex: Int = 0 // 현재 표시되고 있는 페이지의 인덱스
    
    public init(
        pageCount: Int,
        visibleEdgeSpace: CGFloat = 0, // 여백 없애기
        spacing: CGFloat = 0, // 간격 없애기
        @ViewBuilder content: @escaping (PageIndex) -> Content
    ) {
        self.pageCount = pageCount
        self.visibleEdgeSpace = visibleEdgeSpace
        self.spacing = spacing
        self.content = content
    }
    
    public var body: some View {
        VStack(alignment: .center) {
            Spacer() // 위쪽 공간 확보
            GeometryReader { proxy in
                // 양쪽 가장자리에 보일 여백 = 두 뷰 사이 간격 + 화면 양쪽 가장자리에 보일 여백
                let baseOffset: CGFloat = spacing + visibleEdgeSpace
                // 각 페이지의 너비 = 전체 너비 - (화면 양쪽 가장자리에 보일 여백 + 두 뷰 사이 간격) * 양쪽(= 2)
                let pageWidth: CGFloat = proxy.size.width - (visibleEdgeSpace + spacing) * 2
                // HStack의 전체 오프셋을 계산하여 페이지 전환을 구현
                let offsetX: CGFloat = baseOffset + CGFloat(currentIndex) * -pageWidth + CGFloat(currentIndex) * -spacing + dragOffset
                
                
                
                // Carousel 뷰
                HStack(spacing: spacing) {
                    ForEach(0..<pageCount, id: \.self) { pageIndex in
                        self.content(pageIndex)
                            .frame(
                                width: pageWidth, // 각 페이지의 너비를 화면 크기에 맞게 설정
                                height: proxy.size.height
                            )
                    }
                    .contentShape(Rectangle())
                }
                .offset(x: offsetX)
                .gesture(
                    DragGesture()
                        .updating($dragOffset) { value, out, _ in
                            out = value.translation.width // 드래그 중에 발생하는 이동을 dragOffset으로 업데이트
                        }
                        .onEnded { value in
                            let offsetX = value.translation.width // 드래그가 끝난 후 이동한 거리를 계산한 값
                            let progress = -offsetX / pageWidth // 페이지의 이동 비율로, -offsetX / pageWidth로 계산
                            let increment = Int(progress.rounded()) // progress를 반올림하여 현재 페이지 인덱스를 결정
                            
                            currentIndex = max(min(currentIndex + increment, pageCount - 1), 0) // 페이지 전환 후 새로운 인덱스를 설정
                        }
                )
            }
            
            Spacer()
                .frame(height: 60)
            
            // 동그라미 페이지 표시
            HStack(spacing: 6) {
                ForEach(0..<pageCount, id: \.self) { index in
                    Circle()
                        .fill(Color.gray.opacity(
                            (index == (currentIndex) % pageCount) ? 0.8 : 0.3
                        ))
                        .frame(width: 6, height: 6) // 동그라미 크기 설정
                }
            }
            .frame(maxWidth: .infinity) // HStack을 화면 너비에 맞춤
            .padding(.bottom, 10) // 화면 아래쪽 여백 설정
        }
    }
}

import SwiftUI

struct ContentView2: View {
    let images: [UIImage] = [.timeTable, .color] // 테스트용 이미지
    
    var body: some View {
        CarouselView(pageCount: images.count, visibleEdgeSpace: 0, spacing: 0) { index in
            Image(uiImage: images[index])
                .resizable()
                .scaledToFit()
        }
        .frame(height: 353) // 전체 Carousel 뷰의 높이 설정
        .padding(.horizontal, 0) // 양쪽 여백을 없애기 위해 horizontal padding 0
    }
}

#Preview {
    ContentView2()
}
