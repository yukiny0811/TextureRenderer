//
//  File.swift
//  TextureRenderer
//
//  Created by Yuki Kuwashima on 2024/12/14.
//

import MetalKit
import simd

class TextureRenderer: NSObject, MTKViewDelegate {
    
    let texture: MTLTexture
    var mousePosition: simd_float2?
    let commandQueue: MTLCommandQueue
    
    init(texture: MTLTexture, commaneQueue: MTLCommandQueue) {
        self.texture = texture
        self.commandQueue = commaneQueue
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {}
    
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable else {
            return
        }
        view.drawableSize = CGSize(
            width: view.frame.size.width,
            height: view.frame.size.height
        )
        guard let commandBuffer = self.commandQueue.makeCommandBuffer() else {
            return
        }
        guard let renderPassDesc = view.currentRenderPassDescriptor else {
            return
        }
        render(commandBuffer: commandBuffer, renderPassDesc: renderPassDesc) { encoder in
            encoder.setRenderPipelineState(Library.renderTextureState)
            encoder.setFragmentTexture(self.texture, index: 0)
            encoder.setVertexBytes(
                [
                    simd_float3(-1, -1, 0),
                    simd_float3(1, -1, 0),
                    simd_float3(-1, 1, 0),
                    simd_float3(1, 1, 0),
                ],
                length: MemoryLayout<simd_float3>.stride * 4,
                index: 0
            )
            encoder.setVertexBytes(
                [
                    simd_float2(0, 0),
                    simd_float2(1, 0),
                    simd_float2(0, 1),
                    simd_float2(1, 1),
                ],
                length: MemoryLayout<simd_float2>.stride * 4,
                index: 1
            )
            encoder.drawPrimitives(type: .triangleStrip, vertexStart: 0, vertexCount: 4)
        }
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
    
    private func render(
        commandBuffer: MTLCommandBuffer,
        renderPassDesc: MTLRenderPassDescriptor,
        process: (_ encoder: MTLRenderCommandEncoder) -> ()
    ) {
        guard let encoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDesc) else {
            return
        }
        process(encoder)
        encoder.endEncoding()
    }
}
