import UIKit
import RxSwift

class ItemDetailsViewController: UIViewController {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var soldCountLabel: UILabel!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    
    private let viewModel: ItemDetailViewModel
    
    init(viewModel: ItemDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindItemFromViewModel()
        
        viewModel.getItemDetails()
    }
    
    private func bindItemFromViewModel() {
        viewModel.output.item
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (item) in
                self?.setupItemInfo(item)
            })
            .disposed(by: disposeBag)
    }

    private func setupItemInfo(_ item: Item) {
        if let url = URL(string: item.thumbnail) {
            itemImage.load(url: url)
        }
        soldCountLabel.text = "\(item.soldQuantity) sold"
        itemTitleLabel.text = item.title
        itemPriceLabel.text = "$ \(item.price)"
        
    }
}
