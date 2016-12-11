import SpriteKit

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (point: CGPoint, scalar: CGPoint) -> CGPoint {
    return CGPoint(x: point.x * scalar.x, y: point.y * scalar.y)
}

func / (point: CGPoint, scalar: CGPoint) -> CGPoint {
    return CGPoint(x: point.x / scalar.x, y: point.y / scalar.y)
}


enum Tile: Int {
    
    case Ground //0
    case Wall_n //1
    case Wall_ne //2
    case Wall_e //3
    case Wall_se //4
    case Wall_s //5
    case Wall_sw //6
    case Wall_w //7
    case Wall_nw //8
    case Droid_n
    case Droid_ne
    case Droid_e
    case Droid_se
    case Droid_s
    case Droid_sw
    case Droid_w
    case Droid_nw
    
    var description:String {
        switch self {
        case .Ground:
            return "Ground"
        case .Wall_n:
            return "Wall North"
        case .Wall_ne:
            return "Wall North East"
        case .Wall_e:
            return "Wall East"
        case .Wall_se:
            return "Wall South East"
        case .Wall_s:
            return "Wall South"
        case .Wall_sw:
            return "Wall South West"
        case .Wall_w:
            return "Wall West"
        case .Wall_nw:
            return "Wall North West"
        case .Droid_n:
            return "Droid North"
        case .Droid_ne:
            return "Droid North East"
        case .Droid_e:
            return "Droid East"
        case .Droid_se:
            return "Droid South East"
        case .Droid_s:
            return "Droid South"
        case .Droid_sw:
            return "Droid South West"
        case .Droid_w:
            return "Droid West"
        case .Droid_nw:
            return "Droid North West"
        }
    }
    
    var image:String {
        switch self {
        case .Ground:
            return "ground"
        case .Wall_n:
            return "wall_n"
        case .Wall_ne:
            return "wall_ne"
        case .Wall_e:
            return "wall_e"
        case .Wall_se:
            return "wall_se"
        case .Wall_s:
            return "wall_s"
        case .Wall_sw:
            return "wall_sw"
        case .Wall_w:
            return "wall_w"
        case .Wall_nw:
            return "wall_nw"
        case .Droid_n:
            return "droid_n"
        case .Droid_ne:
            return "droid_ne"
        case .Droid_e:
            return "droid_e"
        case .Droid_se:
            return "droid_se"
        case .Droid_s:
            return "droid_s"
        case .Droid_sw:
            return "droid_sw"
        case .Droid_w:
            return "droid_w"
        case .Droid_nw:
            return "droid_nw"
        }
    } 
}

class GameScene: SKScene {
    
    //1
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //2
    let view2D:SKSpriteNode
    let viewIso:SKSpriteNode
    
    //3
    let tiles = [
        [8, 1, 1, 1, 1, 2, 1, 1, 1, 2],
        [7 ,0, 0, 0, 0, 3, 0, 0, 0, 3],
        [7 ,0, 0, 0, 0, 3, 0, 0, 0, 3],
        [7 ,0, 0, 0, 0, 3, 0, 0, 0, 3],
        [7 ,0, 12, 0, 0, 3, 0 ,0 ,0, 3],
        [6, 5, 5, 5, 5, 4, 5, 5, 5, 4]
    ]
    
    let tileSize = (width:20, height:20)
    
    //4
    override init(size: CGSize) {
        
        view2D = SKSpriteNode()
        viewIso = SKSpriteNode()
        
        super.init(size: size)
        self.anchorPoint = CGPoint(x:0.5, y:0.5)
    }
    
    //5
    override func didMove(to view: SKView) {
        
        let deviceScale = self.size.width/667
        
        view2D.position = CGPoint(x:-self.size.width*0.45, y:self.size.height*0.17)
        view2D.xScale = deviceScale
        view2D.yScale = deviceScale
        addChild(view2D)
        
        viewIso.position = CGPoint(x:self.size.width*0.12, y:self.size.height*0.12)
        viewIso.xScale = deviceScale
        viewIso.yScale = deviceScale
        addChild(viewIso)
        
        //placeAllTiles2D()
        placeAllTilesIso()
    }
    
    func placeTile2D(image:String, withPosition:CGPoint) {
        
        let tileSprite = SKSpriteNode(imageNamed: image)
        
        tileSprite.size = CGSize(width:tileSize.width, height:tileSize.height)
        
        tileSprite.position = withPosition
        
        tileSprite.anchorPoint = CGPoint(x:0, y:0)
        
        view2D.addChild(tileSprite)
        

        
    }
    
    func placeAllTiles2D() {
        
        for i in 0..<tiles.count {
            
            let row = tiles[i];
            
            for j in 0..<row.count {
                let tileInt = row[j]
                
                //1
                let tile = Tile(rawValue: tileInt)!
                
                //2
                var point = CGPoint(x: (j*tileSize.width), y: -(i*tileSize.height))
                
                self.placeTile2D(image: tile.image, withPosition:point)
            }
            
        }
        
    }
    
    func placeTileIso(image:String, withPosition:CGPoint, withZposition:CGFloat) {
        
        let texture = SKTexture(imageNamed: image)
        
        let tileSprite = SKSpriteNode(texture: texture, size: CGSize(width:tileSize.width*2, height:tileSize.height*2))
        
        //tileSprite.size = CGSize(width:16, height:16)
        tileSprite.zPosition = withZposition
        
        tileSprite.position = withPosition
        
        tileSprite.anchorPoint = CGPoint(x:0, y:0)
        
        viewIso.addChild(tileSprite)
    }
    
    func placeAllTilesIso() {
        
        for i in 0..<tiles.count {
            
            let row = tiles[i];
            
            for j in 0..<row.count {
                let tileInt = row[j]
                
                let tile = Tile(rawValue: tileInt)!
                
                //1
                var point = point2DToIso(p: CGPoint(x: (j*tileSize.width), y: -(i*tileSize.height)))
                
                //2
                placeTileIso(image: ("iso_3d_"+tile.image), withPosition:point, withZposition: CGFloat(i+j))
                
            }
        }
    }
    
    func point2DToIso(p:CGPoint) -> CGPoint {
        
        //invert y pre conversion
        var point = p * CGPoint(x:1, y:-1)
        
        //convert using algorithm
        point = CGPoint(x:(point.x - point.y), y: ((point.x + point.y) / 2))
        
        //invert y post conversion
        point = point * CGPoint(x:1, y:-1)
        
        return point
        
    }
    func pointIsoTo2D(p:CGPoint) -> CGPoint {
        
        //invert y pre conversion
        var point = p * CGPoint(x:1, y:-1)
        
        //convert using algorithm
        point = CGPoint(x:((2 * point.y + point.x) / 2), y: ((2 * point.y - point.x) / 2))
        
        //invert y post conversion
        point = point * CGPoint(x:1, y:-1)
        
        return point
        
    }
}
