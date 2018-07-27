//
//  StravaActivityOperation.swift
//  StravaBests
//
//  Created by Genevieve Timms on 25/07/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//
import Foundation

class StravaRunDetailsOperation: Operation {
    let run: Run
    let client: StravaClient
    
    init(run: Run, client: StravaClient) {
        self.run = run
        self.client = client
        super.init()
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    private var _finished = false
    override private(set) var isFinished: Bool {
        get {
            return _finished
        }
        
        set {
            willChangeValue(forKey: "isFinished")
            _finished = newValue
            didChangeValue(forKey: "isFinished")
        }
    }
    
    private var _executing = false
    override private(set) var isExecuting: Bool {
        get {
            return _executing
        }
        set {
            willChangeValue(forKey: "isExecuting")
            _executing = newValue
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    override func start() {
        if isCancelled {
            isFinished = true
            return
        }
        
        isExecuting = true
        
        client.fetchRunDetails(for: run) { result in
            switch result {
            case .success(let run):
                self.isExecuting = false
                self.isFinished = true
                self.run.bests = run.bests
            case .failure(let error):
                print(error) //TODO: Handle Error 
                self.isExecuting = false
                self.isFinished = true
            }
        }
        
    }
}

