//
//  GameScene.swift
//  PaperBrawl
//
//  Created by Jonathan Newberry on 7/11/16.
//  Copyright (c) 2016 Thwargle Games. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let playerLeft = SKSpriteNode(imageNamed: "arrowLeft")
    let playerRight = SKSpriteNode(imageNamed: "arrowRight")
    let playerUp = SKSpriteNode(imageNamed: "arrowUp")
    let playerDown = SKSpriteNode(imageNamed: "arrowDown")
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Helvetica Nue")
        myLabel.text = "Paper Brawl"
        myLabel.fontSize = 45
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        self.addChild(myLabel)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject     in touches {
            let location = touch.locationInNode(self)
            if playerUp.containsPoint(location) {
                print("Move up. Location: \(location)")
            }
        }
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
