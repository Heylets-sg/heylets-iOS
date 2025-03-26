////
////  AddCustomModuleCoordinator.swift
////  TimeTableFeature
////
////  Created by 류희재 on 3/26/25.
////  Copyright © 2025 Heylets-iOS. All rights reserved.
////
//
//import Foundation
//
//
//public class AddCustomModuleCoordinator: ObservableObject, TimeTableCoordinator {
//    weak var viewModel: TimeTableViewModel?
//    
//    private let useCase: TimeTableUseCaseType
//    private let cancelBag = CancelBag()
//    
//    @Published var customModule = CustomModuleInfo()
//    @Published var selectedDays: [Week] = []
//    @Published var validationError: String?
//    
//    init(useCase: TimeTableUseCaseType) {
//        self.useCase = useCase
//    }
//    
//    func addCustomModule() {
//        // Validate before adding
//        guard validateModule() else {
//            return
//        }
//        
//        useCase.addCustomModule(customModule)
//            .receive(on: RunLoop.main)
//            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] _ in
//                self?.resetForm()
//                self?.viewModel?.viewType = .main
//            })
//            .store(in: cancelBag)
//    }
//    
//    private func validateModule() -> Bool {
//        // Implement validation logic
//        if customModule.name.isEmpty {
//            validationError = "Module name is required"
//            return false
//        }
//        
//        if selectedDays.isEmpty {
//            validationError = "Please select at least one day"
//            return false
//        }
//        
//        validationError = nil
//        return true
//    }
//    
//    private func resetForm() {
//        customModule = CustomModuleInfo()
//        selectedDays = []
//        validationError = nil
//    }
//    
//    func toggleDay(_ day: Week) {
//        if selectedDays.contains(day) {
//            selectedDays.removeAll { $0 == day }
//        } else {
//            selectedDays.append(day)
//        }
//        
//        // Update the custom module with the selected days
//        customModule.days = selectedDays
//    }
//}
