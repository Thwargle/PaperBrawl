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
    
    var Count = 0
    
    let sheet = pencilGirlAnimate()
    
    var sequenceStand: SKAction?
    var sequenceRight: SKAction?
    var sequenceLeft: SKAction?
    var sequenceJump: SKAction?
    
    let playerLeft = SKSpriteNode(imageNamed: "arrowLeft")
    let playerRight = SKSpriteNode(imageNamed: "arrowRight")
    let playerUp = SKSpriteNode(imageNamed: "arrowUp")
    let playerDown = SKSpriteNode(imageNamed: "arrowDown")
    
    var isFingerOnPlayerUp = false
    var isFingerOnPlayerDown = false
    var isFingerOnPlayerLeft = false
    var isFingerOnPlayerRight = false
    
    var isFingerMovingOnPlayerUp = false
    var isFingerMovingOnPlayerDown = false
    var isFingerMovingOnPlayerLeft = false
    var isFingerMovingOnPlayerRight = false
    
    
    var frameCount = 0
    var jumpCount = 0
    
    override func didMoveToView(view: SKView) {
        
        let stand = SKAction.animateWithTextures(sheet.pencilManStand(), timePerFrame: 0.066)
        let walk = SKAction.animateWithTextures(sheet.pencilManWalk(), timePerFrame: 0.066)
        let walkAnim = SKAction.repeatAction(walk, count:5)
        let jump = SKAction.animateWithTextures(sheet.pencilManJump(), timePerFrame: 0.066)
        let jumpAnim = SKAction.repeatAction(jump, count:5)
        
        let walkAndMoveRight = SKAction.group([walkAnim])
        let walkAndMoveLeft  = SKAction.group([walkAnim])
        let resetDirection  = SKAction.scaleXTo(childNodeWithName("playerSprite")!.xScale * 1,  y:childNodeWithName("playerSprite")!.yScale, duration:0.0);
        let mirrorDirection = SKAction.scaleXTo(childNodeWithName("playerSprite")!.xScale * -1, y:childNodeWithName("playerSprite")!.yScale, duration:0.0)
        
        //let mirrorDirection = SKAction.flipX
        
        sequenceStand = SKAction.repeatActionForever(SKAction.sequence([stand]));
        sequenceRight = SKAction.repeatActionForever(SKAction.sequence([resetDirection, walkAndMoveRight]));
        sequenceLeft = SKAction.repeatActionForever(SKAction.sequence([mirrorDirection, walkAndMoveLeft]));
        sequenceJump = SKAction.repeatAction(jumpAnim, count: 1)
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
                sprite!.runAction(sequenceJump!, withKey: "jump")
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
//        isFingerMovingOnPlayerLeft = false
//        isFingerMovingOnPlayerRight = false
//        let touch = touches.first
//        let touchLocation = touch!.locationInNode(self)
//        if let body = physicsWorld.bodyAtPoint(touchLocation) {
//            
//            if body.node!.name == "playerLeft" {
//                isFingerMovingOnPlayerLeft = true
//            }
//            if body.node!.name == "playerRight" {
//                isFingerMovingOnPlayerRight = true
//            }
//            
//            Count++
//            print(body.node!.name)
//            print(Count)
//        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let sprite = childNodeWithName("playerSprite")
        let touch = touches.first
        let touchLocation = touch!.locationInNode(self)
        if let body = physicsWorld.bodyAtPoint(touchLocation) {
            if body.node!.name == "playerUp" {
                isFingerOnPlayerUp = false
                sprite!.removeActionForKey("jump")
                print("Ended ", body.node!.name)
            }
            if body.node!.name == "playerDown" {
                isFingerOnPlayerDown = false
                print("Ended ", body.node!.name)
            }
            if body.node!.name == "playerLeft" {
                isFingerOnPlayerLeft = false
                sprite!.removeActionForKey("runLeft")
                sprite!.runAction(sequenceStand!, withKey: "standing")
                print("Ended ", body.node!.name)
            }
            if body.node!.name == "playerRight" {
                isFingerOnPlayerRight = false
                sprite!.removeActionForKey("runRight")
                sprite!.runAction(sequenceStand!, withKey: "standing")
                print("Ended ", body.node!.name)
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        if(isFingerOnPlayerLeft) {
            let player = childNodeWithName("playerSprite") as! SKSpriteNode
            
            let playerX = player.position.x - 10
            
            player.position = CGPoint(x: playerX, y: player.position.y)
        }
        if(isFingerOnPlayerRight) {
            let player = childNodeWithName("playerSprite") as! SKSpriteNode
            
            let playerX = player.position.x + 10
            
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
                        player.physicsBody!.applyImpulse(CGVector(dx: -1, dy: 55.0))
                    }
                    else if(isFingerOnPlayerRight) {
                        player.physicsBody!.applyImpulse(CGVector(dx: 1, dy: 55.0))
                    }
                    else {
                        player.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 55.0))
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
