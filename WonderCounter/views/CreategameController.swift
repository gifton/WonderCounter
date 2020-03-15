
import UIKit
import CoreData

class CreateGameController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .white
        setView()
    }
        
    var newGame = UILabel.title("7 Wonders", .max)
    var date = UILabel.mediumTitle()
    var newGameIcon = UIImageView(withColor: .red)
    var newPlayer = UILabel.mediumTitle("Add player", .large)
    var newPlayerName = UITextField()
    var playersTitle = UILabel("Players")
    var savePlayeres = UILabel.mediumTitle("save", .large)
    var players: UITableView!
    var createdPlayers: [WPlayer] = [] {
        didSet {
            players.reloadData()
            print("newPlayer:", createdPlayers.last)
        }
    }
    var startGame = UILabel.title("Start game", .xLarge)
    
    func setView() {
        newGame.sizeToFit()
        view.addSubview(newGame)
        newGame.pin(onEdge: .left, withPadding: .large)
        newGame.top = 40
        newGame.textColor = .black
        
        date.getStringFromDate(date: Date(), withStyle: .long)
        date.sizeToFit()
        date.top = newGame.bottom.addPadding(.small)
        date.left = newGame.left
        view.addSubview(date)
        
        newPlayer.sizeToFit()
        newPlayer.top = date.bottom.addPadding(.xXLarge, multiplier: 2)
        newPlayer.left = view.left.addPadding()
        view.addSubview(newPlayer)
        
        newPlayerName.placeholder = "Enter player name"
        newPlayerName.backgroundColor = Styles.Colors.offWhite
        newPlayerName.layer.cornerRadius = 10
        newPlayerName.layer.masksToBounds = true
        newPlayerName.width = 250
        newPlayerName.height = 40
        view.addSubview(newPlayerName)
        newPlayerName.top = newPlayer.bottom.addPadding()
        newPlayerName.left = view.left.addPadding()
        newPlayerName.textAlignment = .center
        
        savePlayeres.layer.cornerRadius = 10
        savePlayeres.layer.masksToBounds = true
        savePlayeres.textColor = .white
        savePlayeres.backgroundColor = Styles.Colors.primaryBlue
        savePlayeres.textAlignment = .center
        savePlayeres.left = newPlayerName.right.addPadding(.small)
        savePlayeres.top = newPlayerName.top
        savePlayeres.height = newPlayerName.height
        savePlayeres.width = view.width - newPlayerName.right.addPadding(.medium, multiplier: 2)
        view.addSubview(savePlayeres)
        savePlayeres.addTapGestureRecognizer {
            if self.newPlayerName.text != nil {
                self.createdPlayers.append(WPlayer(name: self.newPlayerName.text ?? "Not available"))
            }
            self.resignFirstResponder()
            self.newPlayerName.resignFirstResponder()
            
            self.newPlayerName.text = ""
            
        }
        
        setTV()
    }
    
    func setTV() {
        players = UITableView(frame: CGRect(x: view.left.addPadding(), y: savePlayeres.bottom.addPadding(.xXLarge), width: view.width.subtractPadding(.large,  multiplier: 2), height: 400), style: .insetGrouped)
        players.backgroundView = .init(withColor: .white)
        players.delegate = self
        players.dataSource = self
        view.addSubview(players)
        setLower()
    }
    
    func setLower() {
        startGame.backgroundColor = Styles.Colors.primaryGreen
        startGame.textColor = .white
        startGame.textAlignment  = .center
        startGame.layer.cornerRadius = 10
        startGame.layer.masksToBounds = true
        startGame.frame.size = .init(view.width.subtractPadding(.xLarge, multiplier: 2), 65)
        startGame.top = players.bottom.addPadding()
        startGame.center.x = view.center.x
        view.addSubview(startGame)
        
        startGame.addTapGestureRecognizer {
            let vc = GameController(players: self.createdPlayers)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension CreateGameController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = Styles.Colors.offWhite
        cell.textLabel?.text = createdPlayers[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: tableView.width, height: 50))
        header.addBorders(edges: [.bottom])
        let lbl = UILabel.mediumTitle("Current Players", .medium)
        lbl.left = header.left.addPadding(.xLarge)
        lbl.center.y = header.height / 2
        header.addSubview(lbl)
        
        let clear = UILabel.body("clear")
        clear.textColor = .red
        clear.sizeToFit()
        header.addSubview(clear)
        clear.right = header.right.subtractPadding(.xLarge, multiplier: 2)
        clear.center.y = header.height / 2
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return createdPlayers.count
    }
}
