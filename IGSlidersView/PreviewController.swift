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
    

    
    override func viewDidLoad(){
        guard let preview = preview else {return}
        preview.scene = SCNScene.init(named: "PreviewScene.scn")
    
        preview.boxesNode.name = "BoxesNode"
        preview.boxesNode.position = SCNVector3(-1, -1, -1)
        preview.scene?.rootNode.addChildNode(preview.boxesNode)
        
        preview.axesNode.name = "AxesNode"
        preview.axesNode.position = SCNVector3(-1, -1, -1)
        preview.scene?.rootNode.addChildNode(preview.axesNode)
        
        preview.axesNode.name = "SlidersNode"
        preview.axesNode.position = SCNVector3(-1, -1, -1)
        preview.scene?.rootNode.addChildNode(preview.slidersNode)
        
        preview.drawSelectedAxisLines()
 
    }
    
    func redrawPreview(with styles:[(name: String, values: [Double])]) {
        preview?.updateBoxes(with: styles)
        
    }
    
    func redrawSliders(with slidersData:[[[(styleName:String, value:Double)]]]) {
        preview?.drawSliders(slidersData: slidersData)
    }
    
    
    
}
