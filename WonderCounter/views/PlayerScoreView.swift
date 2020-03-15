
import UIKit

protocol ScoreDelegate: GameController {
    func setScore(forPlayer player: WPlayer, _ score: WPlayerScore)
}

class PlayerScoreView: UIView {
    init(withPlayer: WPlayer, scoreType: ScoreType) {
        self.player = withPlayer
        self.scoreType  = scoreType
        super.init(frame: CGRect(origin: .zero, size: .init(Device.width.subtractPadding(.xLarge, multiplier: 2), 65)))
        
        setView()
    }
    var delegate: ScoreDelegate?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setWinner() {
        backgroundColor = Styles.Colors.primaryGreen
        iconLabel.backgroundColor = .white
        nameLabel.textColor = .white
    }
    
    var player: WPlayer
    var scoreType: ScoreType
    var iconLabel = UILabel.title()
    var scoreField = UITextField()
    var nameLabel = UILabel.mediumTitle("", .medium)
    var save = UILabel.body("save", .large)
    
    private func setView() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        backgroundColor = Styles.Colors.offWhite
        
        iconLabel.text = String(describing: player.totalScore)
        iconLabel.frame.size = .init(50)
        iconLabel.layer.cornerRadius = 25
        iconLabel.layer.masksToBounds = true
        iconLabel.backgroundColor = Styles.Colors.lightGray
        iconLabel.left = left.addPadding()
        iconLabel.textAlignment = .center
        iconLabel.center.y  = height / 2
        addSubview(iconLabel)
        
        nameLabel.text = player.name
        nameLabel.sizeToFit()
        nameLabel.left = iconLabel.right.addPadding()
        nameLabel.center.y = iconLabel.center.y
        addSubview(nameLabel)
        
        scoreField.frame.size = .init(50, 30)
        scoreField.center.y = height / 2
        scoreField.center.x = 250
        scoreField.backgroundColor = .white
        scoreField.addBorders(edges: [.bottom])
        scoreField.textAlignment = .center
        addSubview(scoreField)
        
        let scoreLabel = UILabel.body("score:")
        scoreLabel.sizeToFit()
        scoreLabel.right = scoreField.left.subtractPadding(.small)
        scoreLabel.center.y = scoreField.center.y
        addSubview(scoreLabel)
        
        save.sizeToFit()
        save.textColor = Styles.Colors.primaryBlue
        save.right = right.subtractPadding()
        save.center.y = height / 2
        addSubview(save)
        save.addTapGestureRecognizer {
            if let score = Int(self.scoreField.text!) {
                self.delegate?.setScore(forPlayer: self.player, WPlayerScore(scoreType: self.scoreType, score: score))
                self.scoreField.resignFirstResponder()
                self.save.isEnabled = false
                self.save.alpha = 0.4
            }
            
        }
    }
}


class FinalScoreView: UIView {
    init(withPlayer: WPlayer) {
        self.player = withPlayer
        super.init(frame: CGRect(origin: .zero, size: .init(Device.width.subtractPadding(.xLarge, multiplier: 2), 65)))
        setView()
    }
    
    var player: WPlayer
    var iconLabel = UILabel.title()
    var nameLabel = UILabel.mediumTitle()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setWinner() {
        backgroundColor = Styles.Colors.primaryGreen
    }
    
    func setView() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        backgroundColor = Styles.Colors.offWhite
        
        iconLabel.text = String(describing: player.totalScore)
        iconLabel.frame.size = .init(50)
        iconLabel.layer.cornerRadius = 25
        iconLabel.layer.masksToBounds = true
        iconLabel.backgroundColor = Styles.Colors.lightGray
        iconLabel.left = left.addPadding()
        iconLabel.textAlignment = .center
        iconLabel.center.y  = height / 2
        addSubview(iconLabel)
        
        nameLabel.text = player.name
        nameLabel.sizeToFit()
        nameLabel.left = iconLabel.right.addPadding()
        nameLabel.center.y = iconLabel.center.y
        addSubview(nameLabel)
    }
}
