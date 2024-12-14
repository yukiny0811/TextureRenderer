//
//  MTLTextureView.swift
//  TextureRenderer
//
//  Created by Yuki Kuwashima on 2024/12/14.
//

import MetalKit
import SwiftUI
import AppKit

public struct TextureView: NSViewRepresentable {
    
    let texture: MTLTexture
    let commandQueue: MTLCommandQueue
    
    public init(texture: MTLTexture, commandQueue: MTLCommandQueue) {
        self.texture = texture
        self.commandQueue = commandQueue
    }
    
    public func makeNSView(context: Context) -> MTKView {
        let mtkView = ShaderMTKView(texture: texture, commandQueue: commandQueue)
        return mtkView
    }
    
    public func updateNSView(_ nsView: MTKView, context: Context) {}
}
