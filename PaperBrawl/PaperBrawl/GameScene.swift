//
//  GameScene.swift
//  PaperBrawl
//
//  Created by Jonathan Newberry on 7/11/16.
//  Copyright (c) 2016 Thwargle Games. All rights reserved.
//

import SpriteKit

let movePlayerRightButton = "playerRight"

class GameScene: SKScene {
    
    let sheet = playerAnimate()
    var sequenceRight: SKAction?
    var sequenceLeft: SKAction?
    
    let playerLeft = SKSpriteNode(imageNamed: "arrowLeft")
    let playerRight = SKSpriteNode(imageNamed: "arrowRight")
    let playerUp = SKSpriteNode(imageNamed: "arrowUp")
    let playerDown = SKSpriteNode(imageNamed: "arrowDown")
    
    var isFingerOnPlayerUp = false
    var isFingerOnPlayerDown = false
    var isFingerOnPlayerLeft = false
    var isFingerOnPlayerRight = false
    
    var frameCount = 0
    var jumpCount = 0
    
    override func didMoveToView(view: SKView) {
        
        let walk = SKAction.animateWithTextures(sheet.playerWalk(), timePerFrame: 0.033)
        let walkAnim = SKAction.repeatAction(walk, count:5)
        
        let walkAndMoveRight = SKAction.group([walkAnim])
        let walkAndMoveLeft  = SKAction.group([walkAnim])
        let resetDirection  = SKAction.scaleXTo(childNodeWithName("playerSprite")!.xScale * 1,  y:childNodeWithName("playerSprite")!.yScale, duration:0.0);
        let mirrorDirection = SKAction.scaleXTo(childNodeWithName("playerSprite")!.xScale * -1, y:childNodeWithName("playerSprite")!.yScale, duration:0.0)
        
        //let mirrorDirection = SKAction.flipX
        
        sequenceRight = SKAction.repeatActionForever(SKAction.sequence([resetDirection, walkAndMoveRight]));
        sequenceLeft = SKAction.repeatActionForever(SKAction.sequence([mirrorDirection, walkAndMoveLeft]));
        
        let borderBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        
        borderBody.friction = 0
        
        self.physicsBody = borderBody
        
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let sprite = childNodeWithName("playerSprite")
        
        
        let touch = touches.first
        let touchLocation = touch!.locationInNode(self)
        
        if let body = physicsWorld.bodyAtPoint(touchLocation) {
            if body.node!.name == "playerUp" {
                isFingerOnPlayerUp = true
            }
            if body.node!.name == "playerDown" {
                isFingerOnPlayerDown = true
            }
            if body.node!.name == "playerLeft" {
                isFingerOnPlayerLeft = true
                sprite!.runAction(sequenceLeft!, withKey: "runLeft")
            }
            if body.node!.name == "playerRight" {
                isFingerOnPlayerRight = true
                sprite!.runAction(sequenceRight!, withKey: "runRight")
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let sprite = childNodeWithName("playerSprite")
        let touch = touches.first
        let touchLocation = touch!.locationInNode(self)
//        if let body = physicsWorld.bodyAtPoint(touchLocation) {
//            if body.node!.name == "playerUp" {
//                isFingerOnPlayerUp = false
//            }
//            if body.node!.name == "playerDown" {
//                isFingerOnPlayerDown = false
//            }
//            if body.node!.name == "playerLeft" {
//                isFingerOnPlayerLeft = false
//                sprite!.removeActionForKey("runLeft")
//            }
//            if body.node!.name == "playerRight" {
//                isFingerOnPlayerRight = false
//                sprite!.removeActionForKey("runRight")
//            }
//        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let sprite = childNodeWithName("playerSprite")
        let touch = touches.first
        let touchLocation = touch!.locationInNode(self)
        if let body = physicsWorld.bodyAtPoint(touchLocation) {
            if body.node!.name == "playerUp" {
                isFingerOnPlayerUp = false
            }
            if body.node!.name == "playerDown" {
                isFingerOnPlayerDown = false
            }
            if body.node!.name == "playerLeft" {
                isFingerOnPlayerLeft = false
                sprite!.removeActionForKey("runLeft")
            }
            if body.node!.name == "playerRight" {
                isFingerOnPlayerRight = false
                sprite!.removeActionForKey("runRight")
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        if(isFingerOnPlayerLeft) {
            let player = childNodeWithName("playerSprite") as! SKSpriteNode
            
            let playerX = player.position.x - 15
            
            player.position = CGPoint(x: playerX, y: player.position.y)
        }
        if(isFingerOnPlayerRight) {
            let player = childNodeWithName("playerSprite") as! SKSpriteNode
            
            let playerX = player.position.x + 15
            
            player.position = CGPoint(x: playerX, y: player.position.y)
        }
        if(isFingerOnPlayerUp) {
            let player = childNodeWithName("playerSprite") as! SKSpriteNode
            if(jumpCount == 2)
            {
                isFingerOnPlayerUp = false
            }
            else
            {
                if(frameCount < 8) {
                    if(isFingerOnPlayerLeft) {
                        player.physicsBody!.applyImpulse(CGVector(dx: -1, dy: 40.0))
                    }
                    else if(isFingerOnPlayerRight) {
                        player.physicsBody!.applyImpulse(CGVector(dx: 1, dy: 40.0))
                    }
                    else {
                        player.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 40.0))
                    }
                    frameCount += 1
                }
                else {
                    frameCount = 0
                    isFingerOnPlayerUp = false
                }
            }
        }
    }
}
