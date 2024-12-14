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
    
    public init(texture: MTLTexture) {
        self.texture = texture
    }
    
    public func makeNSView(context: Context) -> MTKView {
        let mtkView = ShaderMTKView(texture: texture)
        return mtkView
    }
    
    public func updateNSView(_ nsView: MTKView, context: Context) {}
}
