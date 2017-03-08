//
//  ViewController.swift
//  SearchFlickrWithRxSwift
//
//  Created by Marian on 3/8/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SDWebImage

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
//    var provider: RxMoyaProvider<Flickr>!
    var searchViewModel: SearchViewModel!

    var latestkeyword: Observable<String> {
        return searchBar.rx.text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupRx()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupRx() {

        
        // Now we will setup our model
        searchViewModel = SearchViewModel( keywordObservable: latestkeyword)
        
        searchBar.rx.searchButtonClicked.subscribe(onNext: { text in
            if self.searchBar.isFirstResponder == true {
                self.view.endEditing(true)
            }
        }).addDisposableTo(disposeBag)
       
        // And bind issues to table view
        // Here is where the magic happens, with only one binding
        // we have filled up about 3 table view data source methods
        searchViewModel.searchPhotos()
            .bindTo(tableView.rx.items) { (tableView, row, item) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: IndexPath(row: row, section: 0)) as! PhotoTableViewCell

                cell.titleLabel.text = item.title
                cell.photoImageView.sd_setShowActivityIndicatorView(true)
                cell.photoImageView.sd_setIndicatorStyle(.gray)
                cell.photoImageView.sd_setImage(with: URL(string: item.getPhotoThumbnailURL()))
                return cell
            }
            .addDisposableTo(disposeBag)
        

        
    }
    


}

