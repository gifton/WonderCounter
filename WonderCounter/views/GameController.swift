

import UIKit


class GameController: UIViewController {
    
    init(players: [WPlayer]) {
        game = NewGame(players)
        super.init(nibName: nil, bundle: nil)
        let sv = UIScrollView()
        sv.frame = view.frame
        sv.contentSize = .init(Device.width, Device.height)
        sv.backgroundColor = UIColor(hex: ScoreColor.ordered.first!.rawValue)
        view = sv
        
        setView()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var game: NewGame
    var currentScoreType: ScoreType = ScoreType.ordered.first!
    
    // UI objects
    let titleLabel = UILabel.title("7 wonders", .xXLarge)
    let counterIdentifier = UILabel.mediumTitle("Counting: Military")
    var continuelabel = UILabel.title("next", .xLarge)
    var playerObjects = [UIView]()
}

private extension GameController {
    
    func setView() {
        titleLabel.sizeToFit()
        titleLabel.left = view.left.addPadding()
        titleLabel.textColor = view.backgroundColor?.inverse() ?? .black
        titleLabel.top = view.top.addPadding(.xXLarge)
        
        view.addSubview(titleLabel)
        counterIdentifier.sizeToFit()
        counterIdentifier.top = titleLabel.bottom.addPadding()
        counterIdentifier.left = titleLabel.left
        view.addSubview(counterIdentifier)
        
        addPlayers()
        
        continuelabel.backgroundColor = Styles.Colors.primaryGreen
        continuelabel.textColor = .white
        continuelabel.textAlignment  = .center
        continuelabel.layer.cornerRadius = 10
        continuelabel.layer.masksToBounds = true
        continuelabel.frame.size = .init(view.width.subtractPadding(.xLarge, multiplier: 2), 65)
        continuelabel.bottom = view.bottom.subtractPadding(.xLarge)
        continuelabel.center.x = view.center.x
        continuelabel.addTapGestureRecognizer(action: next)
        view.addSubview(continuelabel)
        
    }
    
    func next() {
        playerObjects.forEach { $0.removeFromSuperview() }
        if !(currentScoreType == ScoreType.ordered.last!)  {
            currentScoreType = ScoreType.next(currentScoreType)
            if currentScoreType == ScoreType.ordered.last! {
                continuelabel.text = "show final scores"
            }
            addPlayers()
            counterIdentifier.text = "Scoring: \(currentScoreType)"
            
            if let color = ScoreType.ordered.firstIndex(of: currentScoreType) {
                UIView.animate(withDuration: 0.2) {
                    self.view.backgroundColor = UIColor(hex: ScoreColor.ordered[color].rawValue)
                    self.titleLabel.textColor = self.view.backgroundColor?.inverse() ?? .black
                    self.counterIdentifier.textColor = self.view.backgroundColor?.inverse() ?? .black
                }
            }
            
            counterIdentifier.sizeToFit()
            
        } else { showScores() }
    }
    
    func showScores()  {
        var startY: CGFloat = counterIdentifier.bottom.addPadding()
        let winner = game.getWinner()
        
        for player in game.players {
            
            let score = FinalScoreView(withPlayer: player)
            score.top = startY
            score.left = view.left.addPadding()
            view.addSubview(score)
            startY = score.bottom.addPadding(.medium)
            if player == winner {
                score.setWinner()
            }
        }
        continuelabel.alpha = 0.4
    }
    
    func addPlayers() {
        
        var startY: CGFloat = counterIdentifier.bottom.addPadding()
        for player in game.players {
            let counterView = PlayerScoreView(withPlayer: player, scoreType: currentScoreType)
            counterView.delegate = self
            counterView.top = startY
            counterView.center.x = view.center.x
            view.addSubview(counterView)
            startY = counterView.bottom.addPadding(.small)
            
            playerObjects.append(counterView)
        }
        
    }
}


extension GameController: ScoreDelegate {
    func setScore(forPlayer player: WPlayer, _ score: WPlayerScore) {
        game.addScore(score: score, player: player)
    }
}
