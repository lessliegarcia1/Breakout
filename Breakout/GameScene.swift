//
//  GameScene.swift
//  Breakout
//
//  Created by Lesslie Garcia on 3/13/17.
//  Copyright © 2017 Lesslie Garcia. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ball = SKShapeNode()
    var paddle = SKSpriteNode()
    var brick = SKSpriteNode()
    var bricks = [SKSpriteNode]()
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        createBackground()
        makeLoseZone()
        makeBall()
        makePaddle()
        makeBrick()
        
        
    }
    
    func resetGame() {
 
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            paddle.position.x = location.x

    }
}

func didBegin(_ contact: SKPhysicsContact) {
    if contact.bodyA.node?.name == "brick" ||
        contact.bodyB.node?.name == "brick" {
        print("You win!")
        brick.removeFromParent()
        ball.removeFromParent()
    }
    if contact.bodyA.node?.name == "loseZone" ||
        contact.bodyB.node?.name == "loseZone" {
        print("You lose!")
        ball.removeFromParent()
    }
}
override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    for touch in touches {
        let location = touch.location(in: self)
        paddle.position.x = location.x
    }
    
}

func createBackground() {
    let stars = SKTexture(imageNamed: "stars")
    for i in 0...1 {
        let starsBackground = SKSpriteNode(texture: stars)
        starsBackground.zPosition = -1
        starsBackground.position = CGPoint (x: 0, y: starsBackground.size.height * CGFloat(i))
        addChild(starsBackground)
        let moveDown = SKAction.moveBy(x: 0, y:  -starsBackground.size.height, duration: 20)
        let moveReset = SKAction.moveBy(x: 0, y: starsBackground.size.height, duration: 0)
        let moveLoop = SKAction.sequence([moveDown, moveReset])
        let moveForever = SKAction.repeatForever(moveLoop)
        starsBackground.run(moveForever)
    }
}

func makeBall() {
    ball = SKShapeNode(circleOfRadius: 10)
    ball.position = CGPoint(x: frame.midX, y: frame.midY)
    ball.strokeColor = UIColor.black
    ball.fillColor = UIColor.yellow
    ball.name = "ball"
    
    // physics shape matches ball game
    ball.physicsBody = SKPhysicsBody(circleOfRadius: 10)
    // ignores all forces and impulses
    ball.physicsBody?.isDynamic = false
    // use precise collision detection
    ball.physicsBody?.usesPreciseCollisionDetection = true
    // no loss of energy from friction
    ball.physicsBody?.friction = 0
    // gravity is not a factor
    ball.physicsBody?.affectedByGravity = false
    // bounces fully off other objects
    ball.physicsBody?.restitution = 1
    // does not slow down over time
    ball.physicsBody?.linearDamping = 0
    ball.physicsBody?.contactTestBitMask =
        (ball.physicsBody?.collisionBitMask)!
    addChild(ball) // add ball object to the view
    
    ball.physicsBody?.isDynamic = true
    ball.physicsBody?.applyImpulse(CGVector(dx: 5, dy: 3))
    
    
}

func makePaddle() {
    paddle = SKSpriteNode(color: UIColor.white, size: CGSize(width: frame.width/4, height: frame.height/25))
    paddle.position = CGPoint(x: frame.midX, y: frame.minY + 125)
    paddle.name = "paddle"
    paddle.physicsBody = SKPhysicsBody(rectangleOf: paddle.size)
    paddle.physicsBody?.isDynamic = false
    addChild(paddle)
    }
func makeBrick() {
    brick = SKSpriteNode(color: UIColor.blue, size: CGSize(width: frame.width/4, height: frame.height/15))
    brick.texture = SKTexture(imageNamed: "level1")
    brick.position = CGPoint(x: frame.midX, y: frame.maxY - 30)
    brick.name = "brick"
    brick.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
    brick.physicsBody?.isDynamic = false
    addChild(brick)
    bricks.append(brick)
}
    func makeBricks(){
        for brick in bricks {
            if brick.parent != nil {
                brick.removeFromParent()
            }
        }
        bricks.removeAll()
      //  removedBricks = 0
        
        let numberOfBricks = 5
        let top = Int(frame.maxY)
        for x in 0..<numberOfBricks {
            var brick = SKSpriteNode(imageNamed: "level1")
            let x = CGFloat(arc4random() % UInt32(size.width))
            let y = CGFloat(arc4random() % UInt32(size.height))
        //    brick.position = CGPoint(x,y)
            bricks.append(brick)
            
            makeBrick()
        }
    }
func makeLoseZone() {
    let loseZone = SKSpriteNode(color: UIColor.red, size: CGSize(width: frame.width, height: 50))
    loseZone.position = CGPoint(x: frame.midX, y: frame.minY + 25)
    loseZone.name = "loseZone"
    loseZone.physicsBody = SKPhysicsBody(rectangleOf: loseZone.size)
    loseZone.physicsBody?.isDynamic = false
    addChild(loseZone)




}

}


