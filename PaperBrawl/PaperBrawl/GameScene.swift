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
    
    var isFingerOnPlayerLeft = false
    var isFingerOnPlayerRight = false
    var isFingerOnPlayerUp = false
    var isFingerOnPlayerDown = false
    
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
        
        let touch = touches.first
        
        HandleTouchStart(touch!)
    }
    
    func HandleTouchStart(touch: UITouch) {
        
        let sprite = childNodeWithName("playerSprite")
        
        
        let touchLocation = touch.locationInNode(self)
        
        if let body = physicsWorld.bodyAtPoint(touchLocation) {
            if body.node!.name == "playerUp" {
                isFingerOnPlayerUp = true
                sprite!.runAction(sequenceJump!, withKey: "jump")
                print("HandleTouchStart caught up")
            }
            if body.node!.name == "playerDown" {
                isFingerOnPlayerDown = true
            }
            if body.node!.name == "playerLeft" {
                isFingerOnPlayerLeft = true
                sprite!.runAction(sequenceLeft!, withKey: "runLeft")
                print("HandleTouchStart caught left")
            }
            if body.node!.name == "playerRight" {
                isFingerOnPlayerRight = true
                sprite!.runAction(sequenceRight!, withKey: "runRight")
                print("HandleTouchStart caught right")
            }
        }
    }
    
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        isFingerMovingOnPlayerLeft = false
        isFingerMovingOnPlayerRight = false
        isFingerMovingOnPlayerUp = false
        isFingerMovingOnPlayerDown = false
        
        let touch = touches.first
        let touchLocation = touch!.locationInNode(self)
        if let body = physicsWorld.bodyAtPoint(touchLocation) {
            
            if body.node!.name == "playerLeft" {
                isFingerMovingOnPlayerLeft = true
            }
            if body.node!.name == "playerRight" {
                isFingerMovingOnPlayerRight = true
            }
            if body.node!.name == "playerUp" {
                isFingerMovingOnPlayerUp = true
            }
            if body.node!.name == "playerDown" {
                isFingerMovingOnPlayerDown = true
            }
            
            Count += 1
            print("body.node!.name: ", body.node!.name)
            print("Count: ", Count)

            if (isFingerOnPlayerLeft != isFingerMovingOnPlayerLeft) {
                if (isFingerMovingOnPlayerLeft) {
                    HandleTouchStart(touch!)
                    print("Move detected left start")
                } else {
                    let button = childNodeWithName("playerLeft") as! SKSpriteNode
                    HandleTouchEnd(button)
                    print("Move detected left end")
                }
            }

            if (isFingerOnPlayerRight != isFingerMovingOnPlayerRight) {
                if (isFingerMovingOnPlayerRight) {
                    HandleTouchStart(touch!)
                    print("Move detected right start")
                } else {
                    let button = childNodeWithName("playerRight") as! SKSpriteNode
                    HandleTouchEnd(button)
                    print("Move detected right end")
                }
            }
            
            
        
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let touch = touches.first

        
        let touchLocation = touch!.locationInNode(self)
        if let body = physicsWorld.bodyAtPoint(touchLocation) {
            HandleTouchEnd(body.node!)
        }
        
    }
    
    func HandleTouchEnd(node: SKNode) {
        let sprite = childNodeWithName("playerSprite")
        
        if node.name == "playerUp" {
            isFingerOnPlayerUp = false
            sprite!.removeActionForKey("jump")
            print("HandleTouchEnd Up Ended ", node.name)
        }
        if node.name == "playerDown" {
            isFingerOnPlayerDown = false
            print("HandleTouchEnd Down Ended ", node.name)
        }
        if node.name == "playerLeft" {
            isFingerOnPlayerLeft = false
            sprite!.removeActionForKey("runLeft")
            sprite!.runAction(sequenceStand!, withKey: "standing")
            print("HandleTouchEnd Left Ended ", node.name)
        }
        if node.name == "playerRight" {
            isFingerOnPlayerRight = false
            sprite!.removeActionForKey("runRight")
            sprite!.runAction(sequenceStand!, withKey: "standing")
            print("HandleTouchEnd Right Ended ", node.name)
        }
    }

    override func update(currentTime: CFTimeInterval) {
        //let isFingerOnPlayerLeft = ( NSDate().timeIntervalSinceDate(pushedLeftTime) < 2 )
        //let isFingerOnPlayerRight = ( NSDate().timeIntervalSinceDate(pushedRightTime) < 2 )

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
