//
//  POIVC-KeywordsSearch.swift
//  Guava
//
//  Created by Savage on 2/9/21.
//

extension POIVC: UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) { dismiss(animated: true) }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            
            // reset
            pois = aroundSearchedPOIs
            setAroundSearchFooter()
            tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isBlank else { return }
        keywords = searchText
        
        // reset
        pois.removeAll()
        currentKeywordsPage = 1
        
        setKeywordsSearchFooter()
        
        showLoadHUD()
        makeKeywordsSearch(keywords)
    }
}

extension POIVC: AMapSearchDelegate{
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        
        let poiCount = response.count
        
        hideLoadHUD()
        
        if poiCount > kPOIsOffset{
            pageCount = poiCount / kPOIsOffset + 1
        }else{
            footer.endRefreshingWithNoMoreData()
        }
        
        if poiCount == 0{
            return
        }
        
        print(response.pois.count)
        for poi in response.pois{
            let province = poi.province == poi.city ? "" : poi.province
            let address = poi.address == poi.district ? "" : poi.address
            
            let poi = [poi.name ?? kNoPOIPH, "\(province.unwrapperText)\(poi.city.unwrapperText)\(poi.district.unwrapperText)\(address.unwrapperText)"]
            pois.append(poi)
            if request is AMapPOIAroundSearchRequest{
                aroundSearchedPOIs.append(poi)
            }
        }
        tableView.reloadData()
    }
}

extension POIVC{
    private func makeKeywordsSearch(_ keywords: String, _ page: Int = 1){
        keywordsSearchRequest.keywords = keywords
        keywordsSearchRequest.page = page
        mapSearch?.aMapPOIKeywordsSearch(keywordsSearchRequest)
    }
    
    private func setKeywordsSearchFooter(){
        footer.resetNoMoreData()
        footer.setRefreshingTarget(self, refreshingAction: #selector(keywordsSearchPullToRefresh))
    }
}

extension POIVC{
    @objc func keywordsSearchPullToRefresh(){
        currentKeywordsPage += 1
        makeKeywordsSearch(keywords, currentKeywordsPage)
        endRefreshing(currentKeywordsPage)
    }
}
