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
    
    let playerLeft = SKSpriteNode(imageNamed: "arrowLeft")
    let playerRight = SKSpriteNode(imageNamed: "arrowRight")
    let playerUp = SKSpriteNode(imageNamed: "arrowUp")
    let playerDown = SKSpriteNode(imageNamed: "arrowDown")
    
    var isFingerOnPlayerUp = false
    var isFingerOnPlayerDown = false
    var isFingerOnPlayerLeft = false
    var isFingerOnPlayerRight = false
    
    var frameCount = 0
    
    override func didMoveToView(view: SKView) {
        let borderBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        
        borderBody.friction = 0
        
        self.physicsBody = borderBody
        
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
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
        isFingerOnPlayerUp = false
        isFingerOnPlayerDown = false
        isFingerOnPlayerLeft = false
        isFingerOnPlayerRight = false
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
            if(frameCount < 8) {
                if(isFingerOnPlayerLeft) {
                    player.physicsBody!.applyImpulse(CGVector(dx: -1, dy: 40.0))
                }
                if(isFingerOnPlayerRight) {
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
