package com.environment.aplication;


import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.PostMapping;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.TimeZone;

@RestController
public class Query {

    static final String DB_URL = "jdbc:oracle:thin:@172.16.0.55:1521:UISA";
    static final String USER = "blockchain";
    static final String PASS = "i4nENMW0R5fXuPLAADfD";
    static final String QUERY = "select SAFRA from pimsprd.vw_uisa_blockchain_colheita";
    
    @PostMapping("/query")
    public String index() {

        System.setProperty("user.timezone", "America/Los_Angeles"); 
        TimeZone timeZone = TimeZone.getTimeZone("America/Los_Angeles");
        TimeZone.setDefault(timeZone);

        try(Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(QUERY);
        ) {		      
            while(rs.next()){
                //Display values
                System.out.print("SAFRA: " + rs.getInt("SAFRA"));

            }
        } catch (SQLException e) {
            e.printStackTrace();
        } 


        return "QUERY";
    }
}
