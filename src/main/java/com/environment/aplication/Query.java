package com.environment.aplication;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.TimeZone;
import java.util.Map;

import com.google.gson.Gson;

@RestController
public class Query {

    static final String DB_URL = "jdbc:oracle:thin:@172.16.0.55:1521:UISA?-Doracle.sessionTimeZone=UTC";
    static final String USER = "blockchain";
    static final String PASS = "i4nENMW0R5fXuPLAADfD";
    static final String QUERY = "select SAFRA from pimsprd.vw_uisa_blockchain_colheita";
    
    @PostMapping("/query")
    public String index(@RequestBody String body) {


        Gson gson = new Gson();
        Map map = gson.fromJson(body, Map.class);

        try(
            Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(map.get("query").toString());
        ) {	
            
            while(rs.next()){
                System.out.println("SAFRA: " + rs.getString("NOME_SEMIACABADO"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } 

        return body;
    }
}
