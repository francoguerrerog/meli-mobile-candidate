import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let apiRepo = ApiSearchItemsRepository()
        let query = QueryFilter(key: "q", value: "moto")
        let category = QueryFilter(key: "category", value: "MLA1055")
        _ = apiRepo.search(filters: [query, category]).subscribe(onSuccess: { (response) in
            print(response)
        })
    }


}

