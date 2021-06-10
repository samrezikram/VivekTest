//
//  File.swift
//  NYTimesHeadlines
//
//  Created by Samrez Ikram on 02/05/2021.
//

import UIKit

public class NYTNewsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    @IBOutlet weak var pulbisheddate: UILabel!
    
    var news : Result? {
        didSet {
            newsTitleLabel.text = news?.title
            bylineLabel.text = news?.byline
            pulbisheddate.text = news?.publishedDate
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
