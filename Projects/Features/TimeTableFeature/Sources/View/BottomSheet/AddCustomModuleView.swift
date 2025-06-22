import SwiftUI
import Domain

public struct AddCustomModuleView: View {
    @ObservedObject var viewModel: AddCustomModuleViewModel
    @State private var showingTimePicker = false
    
    public var body: some View {
        VStack(alignment: .leading) {
            HStack {
                // 요일 선택은 Menu 유지
                HStack {
                    Menu {
                        ForEach(Week.allCases.sorted(by: { $0.index > $1.index}), id: \.self) { day in
                            Button(day.rawValue, action: {
                                viewModel.send(.weekPickerButtonDidTap(day))
                            })
                        }
                    } label: {
                        HStack {
                            Text(viewModel.day.rawValue)
                                .font(.regular_14)
                                .foregroundColor(.common.MainText.default)
                            
                            Image.icDown
                                .resizable()
                                .frame(width: 9, height: 4)
                                .foregroundColor(.heyMain)
                        }
                    }
                }
                .padding(.trailing, 12)
                
                // 시간 선택 버튼 - 하나로 통합
                Button(action: {
                    showingTimePicker = true
                }) {
                    HStack {
                        // Date 객체가 아닌 문자열 형식 그대로 표시
                        Text(viewModel.startTime)
                            .font(.regular_14)
                            .foregroundColor(.common.MainText.default)
                        
                        Text("~")
                            .font(.regular_14)
                            .frame(width: 20)
                            .foregroundColor(.common.MainText.default)
                        
                        Text(viewModel.endTime)
                            .font(.regular_14)
                            .foregroundColor(.common.MainText.default)
                    }
                }
                .frame(height: 50)
            }
            .padding(.bottom, 24)
            
            VStack(spacing: 20) {
                VStack {
                    TextField(
                        "",
                        text: $viewModel.schedule,
                        prompt: Text("Schedule")
                            .font(.regular_14)
                            .foregroundColor(.common.Placeholder.default)
                    )
                    
                    Divider()
                        .foregroundColor(.common.Divider.default)
                }
                
                VStack {
                    TextField(
                        "",
                        text: $viewModel.location,
                        prompt: Text("Location(option)")
                            .font(.regular_14)
                            .foregroundColor(.common.Placeholder.default)
                    )
                    
                    Divider()
                        .foregroundColor(.common.Divider.default)
                }
                
                VStack {
                    TextField(
                        "",
                        text: $viewModel.professor,
                        prompt: Text("Professor(option)")
                            .font(.regular_14)
                            .foregroundColor(.common.Placeholder.default)
                    )
                    
                    Divider()
                        .foregroundColor(.common.Divider.default)
                }
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .background(Color.timeTableMain.bottomSheet)
        
        // 통합 시간 선택기 Sheet
        .sheet(isPresented: $showingTimePicker) {
            CustomTimePickerView(
                startTime: viewModel.startTime,
                endTime: viewModel.endTime,
                onSave: { newStartTime, newEndTime in
                    // 문자열 형식의 시간 값을 뷰모델에 직접 업데이트
                    viewModel.startTime = newStartTime
                    viewModel.endTime = newEndTime
                    showingTimePicker = false
                },
                onDismiss: {
                    showingTimePicker = false
                }
            )
        }
    }
}

// 문자열 기반 시간 선택 뷰
struct CustomTimePickerView: View {
    // 입력받은 문자열 형식 시간
    let startTime: String
    let endTime: String
    let onSave: (String, String) -> Void
    let onDismiss: () -> Void
    
    // 시간과 분 선택을 위한 상태
    @State private var startHour: Int
    @State private var startMinute: Int
    @State private var endHour: Int
    @State private var endMinute: Int
    
    // 시간 옵션
    let hours = Array(0...23)
    let minutes = stride(from: 0, to: 60, by: 10).map { $0 }
    
    // 초기화
    init(startTime: String, endTime: String, onSave: @escaping (String, String) -> Void, onDismiss: @escaping () -> Void) {
        self.startTime = startTime
        self.endTime = endTime
        self.onSave = onSave
        self.onDismiss = onDismiss
        
        // 시간과 분 초기화
        let startHourValue = Int(startTime.split(separator: ":")[0])!
        let startMinuteValue = Int(startTime.split(separator: ":")[1])!
        let endHourValue = Int(endTime.split(separator: ":")[0])!
        let endMinuteValue = Int(endTime.split(separator: ":")[1])!
        
        self._startHour = State(initialValue: startHourValue)
        self._startMinute = State(initialValue: startMinuteValue)
        self._endHour = State(initialValue: endHourValue)
        self._endMinute = State(initialValue: endMinuteValue)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 20) {
                    // 시작 시간 선택
                    VStack {
                        HStack(spacing: 0) {
                            // 시간 선택 (0-23)
                            Picker("", selection: $startHour) {
                                ForEach(hours, id: \.self) { hour in
                                    Text(String(format: "%02d", hour))
                                        .tag(hour)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .clipped()
                            .compositingGroup()
                            
                            Text(":")
                                .font(.title2)
                                .padding(.horizontal, 2)
                            
                            // 분 선택 (0-59)
                            Picker("", selection: $startMinute) {
                                ForEach(minutes, id: \.self) { minute in
                                    Text(String(format: "%02d", minute))
                                        .tag(minute)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .clipped()
                            .compositingGroup()
                        }
                    }
                    
                    // 구분선
                    Divider()
                        .frame(height: 100)
                    
                    // 종료 시간 선택
                    VStack {
                        HStack(spacing: 0) {
                            // 시간 선택 (0-23)
                            Picker("", selection: $endHour) {
                                ForEach(hours, id: \.self) { hour in
                                    Text(String(format: "%02d", hour))
                                        .tag(hour)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .clipped()
                            .compositingGroup()
                            
                            Text(":")
                                .font(.title2)
                                .padding(.horizontal, 2)
                            
                            // 분 선택 (0-59)
                            Picker("", selection: $endMinute) {
                                ForEach(minutes, id: \.self) { minute in
                                    Text(String(format: "%02d", minute))
                                        .tag(minute)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .clipped()
                            .compositingGroup()
                        }
                    }
                }
                
                if !isTimeRangeValid() {
                    Text("The time interval must be at least 30 minutes.")
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.top, 4)
                }
            }
            .navigationBarItems(
                trailing: Button("Confirm") {
                    let newStartTime = String(format: "%02d:%02d", startHour, startMinute)
                    let newEndTime = String(format: "%02d:%02d", endHour, endMinute)
                    onSave(newStartTime, newEndTime)
                }
                .disabled(!isTimeRangeValid())
            )
        }
        .presentationDetents([.height(200)])
    }
    
    // 시간 범위 유효성 검사
    private func isTimeRangeValid() -> Bool {
        let endTotalMinutes = endHour * 60 + endMinute
        let startTotalMinutes = startHour * 60 + startMinute
        
        // 종료 시간이 24:00인 경우 (다음날 00:00) 특별 처리
        if endHour == 0 && endMinute == 0 {
            return true
        }
        
        let diffMinutes = endTotalMinutes - startTotalMinutes
        return diffMinutes >= 30
    }
    
    // 시간 컴포넌트로부터 Date 객체 생성
    private func createDateFromComponents(hour: Int, minute: Int) -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: Date())
        components.hour = hour
        components.minute = minute
        components.second = 0
        return calendar.date(from: components) ?? Date()
    }
}
