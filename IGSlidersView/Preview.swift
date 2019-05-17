//
//  Preview.swift
//  IGSlidersView
//
//  Created by Łukasz Dziedzic on 13/05/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation
import SceneKit

extension SCNVector3 {
    init (_ doubles:[Double], dim: [Int] = [0,1,2]) {
        var d = doubles
        if doubles.count < 3 {
            d = d + Array(repeating: 0.0, count: 3-doubles.count)
        }
        self.init()
        self.x = CGFloat(d[dim[0]])
        self.y = CGFloat(d[dim[1]])
        self.z = CGFloat(d[dim[2]])
    }
}

class Preview : SCNView {
    
    //var styleBoxes: [SCNNode] = []
    var boxesNode:SCNNode = SCNNode(geometry: nil)
    var axesNode:SCNNode = SCNNode(geometry: nil)
    var slidersNode:SCNNode = SCNNode(geometry: nil)
 
    override func awakeFromNib() {
        print ("PREVIEW awake. scene", scene)
        
        allowsCameraControl = true
    }
    
    func drawSliders(slidersData: [[[(styleName:String, value:Double)]]]) {
        slidersNode.childNodes.forEach({$0.removeFromParentNode()})
        for axisNr in 0..<slidersData.count {
            for edgeNr in 0..<slidersData[axisNr].count {
                print (slidersData[axisNr][edgeNr])
                for sliderNr in 0 ..< slidersData[axisNr][edgeNr].count {
                    let (name, value) = slidersData[axisNr][edgeNr][sliderNr]
                    let slider = SCNBox(width: 0.05, height: 0.05, length: 0.05, chamferRadius: 0)
                    let sliderNode = SCNNode(geometry: slider)
                    var coord = [edgeNr & 1 == 1 ? 1.0 : -1.0, edgeNr & 2 == 2 ? 1.0 : -1.0]
                    if axisNr == 2 {
                        coord.append(value * 2 - 1)
                    } else {
                        coord.insert(value * 2 - 1, at: axisNr)
                    }
                    sliderNode.position = SCNVector3(coord)
                    slidersNode.addChildNode(sliderNode)
                }
            }
            print ()
        }
    }
    
    func drawSelectedAxisLines () {
        axesNode.childNodes.forEach({$0.removeFromParentNode()})
        
        var geometry:SCNGeometry? = nil
        for axisNr in 0...2 {
        switch axisNr {
        case 0: geometry = SCNBox(width: 2, height: 0.005, length: 0.005, chamferRadius: 0)
        case 1: geometry = SCNBox(width: 0.005, height: 2, length: 0.005, chamferRadius: 0)
        case 2: geometry = SCNBox(width: 0.005, height: 0.005, length: 2, chamferRadius: 0)
        default: break
        }
        for i in 0...3 {
            let lineNode = SCNNode(geometry: geometry)
            
            print ( i & 1 , i & 2  )
            var coord = [i & 1 == 1 ? 2.0 : 0, i & 2 == 2 ? 2.0 : 0]
            if axisNr == 2 {
                coord.append(1.0)
            } else {
                coord.insert(1.0, at: axisNr)
            }
            print (coord)
            let vector = SCNVector3(coord)
            lineNode.position = vector
            axesNode.addChildNode(lineNode)
        }
        }
    }
    
    func updateBoxes(with styles:[(name:String, values:[Double])]) {

        boxesNode.childNodes.forEach{ $0.removeFromParentNode() }
        
        for style in styles {
            let styleBox = SCNSphere(radius: 0.05)
            let vector = SCNVector3(style.values)
            let color = NSColor(calibratedRed: vector.x, green: vector.y, blue: vector.z, alpha: 1.0)
                //SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
            styleBox.firstMaterial?.diffuse.contents = color
            let coordsString = style.values.reduce(into: "", {$0 += String(format: " %1.2f,", $1)})
            let name = SCNText(string: style.name + coordsString, extrusionDepth: 0 )
            let nameNode = SCNNode(geometry: name)
            nameNode.scale = SCNVector3(0.0005, 0.0005, 0.0005)
            nameNode.position = SCNVector3(0.1,-0.025, 0)
            //nameNode.rotation = SCNVector4(0.0, 0.0, 34.0, 0.5)
            styleBox.name = style.name
            let styleNode = SCNNode(geometry: styleBox)
            styleNode.addChildNode(nameNode)
            styleNode.position = vector * CGFloat(2.0)
            boxesNode.addChildNode(styleNode)
            //print (styleNode)
        }
        //print (boxesNode)
        //}
    }
    override func mouseDown(with event: NSEvent) {
        let point = convert(event.locationInWindow, to: nil)
        let r = hitTest(point, options: [SCNHitTestOption.firstFoundOnly : true])

        r.forEach {print ( $0.node.geometry?.name ?? "no name", $0.node.position )}
        
    }
    
}
