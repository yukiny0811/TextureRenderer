//
//  File.swift
//  TextureRenderer
//
//  Created by Yuki Kuwashima on 2024/12/14.
//

import Metal

actor ShaderUtils {
    static let device = MTLCreateSystemDefaultDevice()!
    static let library = try! device.makeDefaultLibrary(bundle: .module)
    static let commandQueue = device.makeCommandQueue()!
}
