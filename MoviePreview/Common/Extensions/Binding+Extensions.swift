//
//  Binding+Extensions.swift
//  MoviePreview
//
//  Created by Vinh Nguyen Dinh on R 2/11/09.
//

import SwiftUI

extension Binding where Value == Bool {    
    static prefix func ! (value: Binding<Value>) -> Binding<Value> {
        Binding<Value>(
            get: { !value.wrappedValue },
            set: { value.wrappedValue = !$0 }
        )
    }
}
