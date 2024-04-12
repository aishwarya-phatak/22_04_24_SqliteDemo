//
//  DBHelper.swift
//  22_04_24_SqliteDemo
//
//  Created by Vishal Jagtap on 10/04/24.
//

import Foundation
import SQLite3

class DBHelper{
    let dbPath = "mydatabase.sqlite"
    var db : OpaquePointer?
    static var shared = DBHelper()
    
    private init(){
        db = openDataBase()
        createTable()
    }
    
    func openDataBase() -> OpaquePointer{
        let fileUrl = try! FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil, create: false).appendingPathExtension(dbPath)
        
        print("File Path -- \(fileUrl.path) -- \(db)")
        
        if sqlite3_open(fileUrl.path,&db) == SQLITE_OK{
            print("Database created successfully!")
        } else {
            print("Database creation failed")
        }
        return db!
    }
    
    func createTable(){
        let createQueryString = "CREATE TABLE IF NOT EXISTS Person(Name Text,City Text);"
        var createStatement : OpaquePointer?
        if sqlite3_prepare_v2(
            db,
            createQueryString,
            -1,
            &createStatement,
            nil) == SQLITE_OK{
                print("Statement created successfully")
            if sqlite3_step(createStatement) == SQLITE_DONE{
                print("Person table is created successfullly")
            } else {
                print("Person table not created successfully")
            }
        } else {
            print("Statement creation failed")
        }
        sqlite3_finalize(createStatement)
    }
    
    func insertPersonRecord(name : String, city : String){
        let insertQueryString = "INSERT INTO Person(Name,City) VALUES(?,?);"
        var insertStatement : OpaquePointer?
        if sqlite3_prepare_v2(db,
                              insertQueryString,
                              -1,
                              &insertStatement,
                              nil) == SQLITE_OK{
            print("Insert statement preparation done successfully")

            sqlite3_bind_text(
                insertStatement,
                1,
                (name as NSString).utf8String,
                -1,
                nil)
            
            sqlite3_bind_text(insertStatement,
                              2,
                              (city as NSString).utf8String,
                              -1,
                              nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("insert successful")
            } else {
                print("inserting records failed")
            }
        } else {
            print("Insert statement preparation failed")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func retrivePersonRecords()->[Person]{
        let retriveQueryString = "SELECT * FROM Person;"
        var retriveStatement : OpaquePointer? = nil
        var personArray : [Person] = []
        if sqlite3_prepare_v2(
            db,
            retriveQueryString,
            -1,
            &retriveStatement,
            nil) == SQLITE_OK{
            print("prepared statement successful")
            while sqlite3_step(retriveStatement) == SQLITE_ROW{
                let name = String(describing: String(cString: sqlite3_column_text(retriveStatement, 0)))
                let city = String(describing: String(cString: sqlite3_column_text(retriveStatement, 1)))
                personArray.append(Person(name: name, city: city))
            }
        } else {
            print("prepared statement failed")
        }
        sqlite3_finalize(retriveStatement)
        return personArray
    }
    
    func deletePersonRecords(name : String){
        let deleteQueryString = "DELETE FROM Person where Name = ?;"
        var deleteStatement : OpaquePointer?
        if sqlite3_prepare_v2(db, deleteQueryString, -1, &deleteStatement, nil) == SQLITE_OK{
            print("Delete statement prepared")
            
            sqlite3_bind_text(
                deleteStatement,
                1,
                name,
                -1,
                nil)
            
            if sqlite3_step(deleteStatement) == SQLITE_DONE{
                print("Delete executed")
            } else {
                print("Delete not executed")
            }
        } else {
            print("Delete statement not prepared")
        }
    }
}
