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
    var sequence: SKAction?
    
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
        let turn = SKAction.animateWithTextures(sheet.playerTurn(), timePerFrame: 0.033)
        let walkAnim = SKAction.repeatAction(walk, count:5)
        
        let moveRight = SKAction.moveToX(900, duration: walkAnim.duration)
        let moveLeft = SKAction.moveToX(100, duration: walkAnim.duration)
        
        let mirrorDirection = SKAction.scaleXTo(-1, y:1, duration:0.0)
        let resetDirection  = SKAction.scaleXTo(1,  y:1, duration:0.0)
        
        let walkAndMoveRight = SKAction.group([resetDirection,  walkAnim, moveRight]);
        let walkAndMoveLeft  = SKAction.group([mirrorDirection, walkAnim, moveLeft]);
        
        sequence = SKAction.repeatActionForever(SKAction.sequence([walkAndMoveRight, turn, walkAndMoveLeft, turn]));
        
        let borderBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        
        borderBody.friction = 0
        
        self.physicsBody = borderBody
        
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let sprite = SKSpriteNode(texture: sheet.playerFunc0())
        sprite.position = CGPointMake(100.0, CGFloat(rand() % 100) + 200.0)
        
        sprite.runAction(sequence!)
        addChild(sprite)
        
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
            }
            if body.node!.name == "playerRight" {
                isFingerOnPlayerRight = true
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
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
            }
            if body.node!.name == "playerRight" {
                isFingerOnPlayerRight = false
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
