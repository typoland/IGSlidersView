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
        //print ("updateBoxes", boxesNode.parent)
        boxesNode.childNodes.forEach{ $0.removeFromParentNode() }
        
        for style in styles {
            let styleBox = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
            let name = SCNText(string: style.name, extrusionDepth: 0 )
            let nameNode = SCNNode(geometry: name)
            styleBox.name = style.name
            let styleNode = SCNNode(geometry: styleBox)
            styleNode.addChildNode(nameNode)
            styleNode.position = SCNVector3(style.values) * CGFloat(2.0)
            boxesNode.addChildNode(styleNode)
            //print (styleNode)
        }
        //print (boxesNode)
        //}
    }
    
}
