import UIKit


final class ViewController: UIViewController {
    // Players
    private let player1: Player = .init(name: "John Doe", marker: .o)
    private let player2: Player = .init(name: "Joe Smith", marker: .x)

    // UI
    private lazy var playerStackView: UIStackView = UIStackView.build(players: [player1, player2])

    private let titleLabel: UILabel = UILabel.build(font: .systemFont(ofSize: 24, weight: .bold),
                                                    text: "Tic Tac Toe")

    private let currentPlayerLabel: UILabel = UILabel.build(font: .systemFont(ofSize: 16),
                                                            text: "\(String.currentPlayer) John Doe")

    lazy var currentPlayer: Player = { player1 }()

    var moves: [IndexPath] = []

    var tickTackToeBoard: [[Player?]] = []

    let rowCount: Int = 3

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.build(rowCount: rowCount)
        collectionView.backgroundColor = .black
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BoardSpaceCell.self, forCellWithReuseIdentifier: BoardSpaceCell.identifier)
        return collectionView
    }()

    private let undoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.init(systemName: "arrowshape.turn.up.left"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        resetBoard()
        view.backgroundColor = .white
        view.build(
            titleLabel: titleLabel,
            playersStackView: playerStackView,
            currentPlayerLabel: currentPlayerLabel,
            collectionView: collectionView,
            undoButton: undoButton
        )
        undoButton.addTarget(self, action: #selector(tappedUndo), for: .touchUpInside)
    }

    @objc func tappedUndo() {
        guard let lastMove = moves.popLast() else { return }
        tickTackToeBoard[lastMove.section][lastMove.row] = nil
        collectionView.reloadData()
        alternateCurrentPlayer()
    }

    func alternateCurrentPlayer() {
        currentPlayer = currentPlayer == player1 ? player2 : player1
        currentPlayerLabel.text = String.currentPlayer + " " + currentPlayer.name
    }

    func resetBoard() {
        tickTackToeBoard = .emptyTickTackToeBoard(rows: rowCount)
        collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource {
    // MARK: - UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        tickTackToeBoard.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tickTackToeBoard[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoardSpaceCell.identifier, for: indexPath) as? BoardSpaceCell else {
            return .init()
        }
        cell.assign(marker: tickTackToeBoard[indexPath.section][indexPath.row]?.marker)
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard tickTackToeBoard[indexPath.section][indexPath.row] == nil else { return }
        moves.append(indexPath)
        tickTackToeBoard[indexPath.section][indexPath.row] = currentPlayer
        collectionView.reloadData()
        if let winner: Player = tickTackToeBoard.winner {
            showAlert(for: .winner(winner)) { [weak self] _ in
                self?.resetBoard()
            }
        } else if tickTackToeBoard.noNils {
            showAlert(for: .tie) { [weak self] _ in
                self?.resetBoard()
            }
        }
        alternateCurrentPlayer()
    }
}
