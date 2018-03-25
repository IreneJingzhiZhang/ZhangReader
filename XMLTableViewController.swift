//
//  XMLTableViewController.swift
//  ZhangReader
//
//  Created by Jingzhi Zhang on 9/26/17.
//  Copyright © 2017 NIU CS Department. All rights reserved.
//  To use GCD to fetch XML formatted data from provided links on a separate background thread/queue and update the UI with parsed XML formatted data in the main thread/queue..

import UIKit

class XMLTableViewController: UITableViewController, XMLParserDelegate {
    //Markup: variable for class client
    var client = [XMLClient]()
    var eName: String = String()
    var cName = String()
    var cProfession = String()
    var cDob = String()
    var cChildren:String = ""
    var childList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
/*  read xml file from Bundle
        
        if let path = Bundle.main.url(forResource: "client", withExtension: "xml")
        {
            if let parser = XMLParser(contentsOf: path)
            {
                parser.delegate = self
                parser.parse()
            }
        }
        
        
*/
        
        
        fetchXMLData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//  //get xml data from the url
    func fetchXMLData() {
        // Fetching client list.
        
        guard let api_xml_url = URL(string:"http://faculty.cs.niu.edu/~krush/ios/client_list_xml.txt") else{
            print("URL not defined properly")
            return
        }
        
        let api_xml_urlRequest = URLRequest(url:api_xml_url)
        
        
        
        let task = URLSession.shared.dataTask(with: api_xml_urlRequest) {data,response,error in
            // if there is an error, print the error and do not continue
            if error != nil {
                print("Failed to parse")
                return
            }
            
        if let xmlParser = XMLParser(contentsOf:api_xml_url)
        {
                do {
                    xmlParser.delegate = self
                    if !xmlParser.parse(){
                        print("Data error exists: ")
                        let error = xmlParser.parserError!
                        print("Error Description:\(error.localizedDescription)")
                        //print("Error Reason:\(error.localizedFailureReason)")
                        print("Line number:\(xmlParser.lineNumber)")
                    }
                    //refresh the main table view
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
            }}}
            task.resume()
            
            }
        

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return client.count
        
    }
    
    //Asks the data source for a cell to insert in a particular location of the table view.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "XMLCELL", for: indexPath) as! XMLTableViewCell
        
        // Configure the cell...
        let clientRow:XMLClient = self.client[indexPath.row]
        
        cell.clientName.text = clientRow.cname
        cell.clientProfession.text = clientRow.cprofession
        
        return cell
    }
    
    //Sent by a parser object to its delegate when it encounters a start tag for a given element.
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        eName = elementName
        if elementName == "person" {
            childList = [String]()
            let name = attributeDict["name"]
            cName = name!
            
            let profession = attributeDict["profession"]
            cProfession = profession!
            
            let dob = attributeDict["dob"]
            cDob = dob!
            }
            
            else if elementName == "child"
            {
                
                if let child = attributeDict["name"]{
                 //   cChildren = child
                    childList.append(child)
                }
            }

            
        
    }
    
    //Sent by a parser object to its delegate when it encounters an end tag for a specific element.
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "person" {
            
            let currentClient = XMLClient()
            currentClient.cname = cName
            currentClient.cprofession = cProfession
            currentClient.cdob = cDob
            currentClient.cchildren = childList.joined(separator: ",")
            //currentClient.cchildren = cChildren
            client.append(currentClient)

        }
        
    }
    
    //Sent by a parser object to provide its delegate with a string representing all or part of the characters of the current element.
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (!data.isEmpty) {
            
                if eName == "name" {
                    cName += data
                }
                else if eName == "profession" {
                    cProfession += data
                }
                else if eName == "dob" {
                    cDob += data
                }
                else if eName == "children" {
                    //cChildren += data
                    childList.append(data)
                    }
 
                //refresh the main table view
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
            //If an error occurs, display a “Failed to parse!” message.
        
        }
    
    //Sent by a parser object to its delegate when it encounters a fatal error.
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
    
    

    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "XMLdetailView"){
            
            //create a variable to act as the viewcontroller itself
            let detailView = segue.destination as! XMLDetailView
            
            if let indexPath = self.tableView.indexPathForSelectedRow{
                
                let row:XMLClient = self.client[indexPath.row]
                
                //Set all the necessary properities that need to go in the DetailviewController
                //obtain them from the object created to obtain the venues values
                detailView.navigationItem.title = row.cname
                
                detailView.nameString = row.cname
                detailView.professionString = row.cprofession
                detailView.dobString = row.cdob
                detailView.childrenString = row.cchildren
                
            }
        }
        
    }
    
    

}
