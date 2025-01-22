//
//  LectureInfo_Stub.swift
//  Domain
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation


extension SectionInfo {
    static public var timetable_stub1: Self {
        .init(
            id: 11214,
            code: "PH1105",
            name: "OPTICS, VIBRATIONS & WAVES",
            schedule: [.stub2_1, .stub2_2],
            professor: "LEC/STUDIO-LE",
            unit: 2,
            backgroundColor: "",
            textColor: ""
        )
    }
    
    static public var timetable_stub2: Self {
        .init(
            id: 11914,
            code: "EE3103",
            name: "ENGINEERING ELECTROMAGNETICS",
            schedule: [.stub1],
            professor: "TUT-EE04",
            unit: 3,
            backgroundColor: "",
            textColor: ""
        )
    }
    
    static public var timetable_stub3: Self {
        .init(
            id: 11215,
            code: "PH1105(Sat)",
            name: "OPTICS, VIBRATIONS & WAVES",
            schedule: [.stub3],
            professor: "LEC/STUDIO-LE",
            unit: 3,
            backgroundColor: "",
            textColor: ""
        )
    }
    
    static public var timetable_stub4: Self {
        .init(
            id: 11216,
            code: "PH1105(Sun)",
            name: "OPTICS, VIBRATIONS & WAVES",
            schedule: [.stub4],
            professor: "LEC/STUDIO-LE",
            unit: 3,
            backgroundColor: "",
            textColor: ""
        )
    }
    
    static public var empty: Self {
        .init(
            id: 0,
            name: "",
            schedule: [],
            professor: "",
            unit: 0,
            backgroundColor: "",
            textColor: ""
        )
    }
}
