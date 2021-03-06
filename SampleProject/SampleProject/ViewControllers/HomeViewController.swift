import SKTableViewDataSource
import UIKit

class HomeViewController: UIViewController {

    enum Rows: String {
        case singleSection = "Single Section Table View"
        case multiSection = "Multiple Section Table View"
        case editable = "Editable Table View"
    }

    @IBOutlet var tableView: UITableView!

    var dataSource: TableViewDataSource<Rows>?

    override func viewDidLoad() {
        super.viewDidLoad()

        let array: [Rows] = [
            .singleSection,
            .multiSection,
            .editable,
        ]

        dataSource = TableViewDataSource(objects: array, cell: UITableViewCell.self, cellPresenter: { (cell, object) in
            cell.textLabel?.text = object.rawValue
        })

        tableView.dataSource = dataSource
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let object = dataSource?.objectAt(indexPath) else {
            return
        }

        let viewController: UIViewController?

        switch object {
        case .editable:
            viewController = EditableViewController()
        case .multiSection:
            viewController = MultiSectionViewController()
        case .singleSection:
            viewController = SingleSectionViewController()
        }

        if let viewController = viewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
