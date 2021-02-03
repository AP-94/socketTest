//
//  ViewController.swift
//  SocketTest
//
//  Created by Alessandro Pace on 24/10/2020.
//

import UIKit
import SocketIO

class ViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputUserName: UITextField!
    @IBOutlet weak var inputMessage: UITextField!
    
    //Vars
    var messages: [Message] = []
    var firstMessage = Message(message: "Hola :D", user: "Pepe")
    
    
    //Sockets
    var manager = SocketManager(socketURL: URL(string: "http://ec2-18-194-88-69.eu-central-1.compute.amazonaws.com")!, config: [.log(true), .compress])
    var socketIOClient: SocketIOClient!
    
    //Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messages.append(firstMessage)
        tableView.reloadData()
        connectToSocket()
        
    }
    
    //Actions
    
    @IBAction func sendTap(_ sender: Any) {
        sendMessage()
    }
    
    
    //Methods
    
    func sendMessage() {
        let userName = inputUserName.text
        let message = inputMessage.text
        inputMessage.text?.removeAll()
        inputUserName.text?.removeAll()
        socketIOClient.emit("new-message", CustomData(author: userName!, text: message!), completion: {
            print("MENSAJE ENVIADO")
        })
        
    }
    
    func connectToSocket() {
        socketIOClient = manager.defaultSocket
        
        socketIOClient.on("messages") {
            data, ack in
            print(data)
            
            self.messages.removeAll()
            for i in data.first as! [Dictionary<String, AnyObject>] {
                let message = Message(message: "", user: "")
                if let author = i["author"] as? String {
                    message.author = author
                }
                if let text = i["text"] as? String {
                    message.text = text
                }
                self.messages.append(message)
                self.tableView.reloadData()
            }
            
        }
        
        socketIOClient.connect()
    }
    
}

//Extension

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomCell  = tableView.dequeueReusableCell(withIdentifier: "myCell") as! CustomCell
        cell.message = messages[indexPath.row]
        return cell
    }
    
}


