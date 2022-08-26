package com.drream.gadddi.dao;

import com.drream.gadddi.entities.User;
import java.sql.*;

public class UserDao {

    private Connection con;

    public UserDao(Connection con) {
        this.con = con;
    }

    // method to insert user to data base
    public boolean saveUser(User user) {
        boolean f = false;
        try {

            // user ===> database
            String query = "insert into user(name,email,password,gender,about)values(?,?,?,?,?)";

            PreparedStatement pstmt = this.con.prepareStatement(query);

            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getGender());
            pstmt.setString(5, user.getAbout());

            pstmt.executeUpdate();
            f = true;

        } catch (SQLException e) {

        }
        return f;

    }
    
    // get user by useremail and userpassword
    public User getUserByEmainAndPassword(String email,String password){
        User user=null;
        
        try{
            String query = "select * from user where email=? and password=?";
            
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1,email);
            pstmt.setString(2,password);
            
            ResultSet set = pstmt.executeQuery();
            if(set.next()){
                user = new User();
                String name = set.getString("name");
                user.setName(name);
                user.setId(set.getInt("id"));
                user.setEmail(set.getString("email"));
                user.setPassword(set.getString("password"));
                user.setGender(set.getString("gender"));
                user.setAbout(set.getString("about"));
                user.setDateTime(set.getTimestamp("rdate"));
                user.setProfile(set.getString("profile"));
            }
            
        }catch(SQLException e){
            
        }
        return user;
    }
    
    public boolean updateUser(User user){
        
        boolean f = false;
        
        try{
            String query = "update user set name = ?, email = ?,password=?,About=?,gender=?,profile=? where id=?";

            PreparedStatement p = con.prepareStatement(query);
            p.setString(1,user.getName());
            p.setString(2,user.getEmail());
            p.setString(3,user.getPassword());
            p.setString(4,user.getAbout());
            p.setString(5,user.getGender());
            p.setString(6,user.getProfile());
            p.setInt(7,user.getId());
            
            p.executeUpdate();
            
            f = true;
            
        }catch(SQLException e){
            
        }
            return f;
    }

}
