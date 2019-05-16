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
 
    override func awakeFromNib() {
        print ("PREVIEW awake. scene", scene)
        
        allowsCameraControl = true
    }
    
    func updateBoxes(with styles:[(name:String, values:[Double])]) {

        boxesNode.childNodes.forEach{ $0.removeFromParentNode() }
        
        for style in styles {
            let styleBox = SCNSphere(radius: 0.05)
            let vector = SCNVector3(style.values)
            let color = NSColor(calibratedRed: vector.x, green: vector.y, blue: vector.z, alpha: 1.0)
                //SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
            styleBox.firstMaterial?.diffuse.contents = color
            
            //let name = SCNText(string: style.name, extrusionDepth: 0 )
            //let nameNode = SCNNode(geometry: name)
            //nameNode.scale = SCNVector3(0.01, 0.01, 0.01)
            //nameNode.rotation = SCNVector4(0.0, 0.0, 34.0, 0.5)
            styleBox.name = style.name
            let styleNode = SCNNode(geometry: styleBox)
            //styleNode.addChildNode(nameNode)
            styleNode.position = vector * CGFloat(2.0)
            boxesNode.addChildNode(styleNode)
            //print (styleNode)
        }
        //print (boxesNode)
        //}
    }
    
}
