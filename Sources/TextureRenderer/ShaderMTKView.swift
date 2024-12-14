//
//  ShaderMTKView.swift
//  TextureRenderer
//
//  Created by Yuki Kuwashima on 2024/12/14.
//

import MetalKit
import SwiftUI
import AppKit

class ShaderMTKView: MTKView {
    let renderer: TextureRenderer
    
    init(texture: MTLTexture) {
        self.renderer = TextureRenderer(texture: texture)
        super.init(frame: .zero, device: ShaderUtils.device)
        
        self.frame = .zero
        self.delegate = self.renderer
        self.enableSetNeedsDisplay = false
        self.isPaused = false
        self.colorPixelFormat = .bgra8Unorm
        self.framebufferOnly = false
        self.preferredFramesPerSecond = 60
        self.autoResizeDrawable = true
        self.clearColor = .init(red: 0, green: 0, blue: 0, alpha: 0)
        self.sampleCount = 1
        self.clearDepth = 1.0
        self.layer?.isOpaque = false
        
        let options: NSTrackingArea.Options = [
            .mouseMoved,
            .activeAlways,
            .inVisibleRect,
        ]
        let trackingArea = NSTrackingArea(rect: bounds, options: options, owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func mouseMoved(with event: NSEvent) {
        let mousePos = mousePos(event: event, viewFrame: self.superview!.frame)
        renderer.mousePosition = mousePos
    }
    
    override func mouseExited(with event: NSEvent) {
        renderer.mousePosition = nil
    }
    
    func mousePos(event: NSEvent, viewFrame: NSRect) -> simd_float2 {
        var location = event.locationInWindow
        location.y = event.window!.contentRect(
            forFrameRect: event.window!.frame
        ).height - location.y
        location.x -= viewFrame.minX
        location.y -= viewFrame.minY
        return simd_float2(Float(location.x), Float(location.y))
    }
}
