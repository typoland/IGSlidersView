//
//  PreviewController.swift
//  IGSlidersView
//
//  Created by Łukasz Dziedzic on 13/05/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation
import SceneKit
class PreviewController:NSViewController {
    
    var preview : Preview? {
        return view as? Preview
    }
    

    
    override func awakeFromNib() {
        guard let preview = preview else {return}
        preview.scene = SCNScene.init(named: "PreviewScene.scn")
    
        preview.boxesNode.name = "BoxesNode"
        preview.boxesNode.position = SCNVector3(-0.5, -0.5, -0.5)
        preview.scene?.rootNode.addChildNode(preview.boxesNode)
        
 
    }
    
    func redrawPreview(with styles:[(name: String, values: [Double])]) {
        preview?.updateBoxes(with: styles)
    }
}
