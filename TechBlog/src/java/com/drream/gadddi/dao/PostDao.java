
package com.drream.gadddi.dao;

import com.drream.gadddi.entities.Category;
import com.drream.gadddi.entities.Post;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;


public class PostDao {
    
    Connection con ;

    public PostDao(Connection con) {
        this.con = con;
    }
    
    public ArrayList<Category> getAllCategories(){
        ArrayList<Category> list = new ArrayList<>();
        try{
            
            String q = "Select * from categories";
            
            Statement st = this.con.createStatement();
            
            ResultSet set = st.executeQuery(q);
            
            while(set.next()){
                int cid = set.getInt("cid");
                String name = set.getString("name");
                String description = set.getString("description");
                Category c = new Category(cid,name,description);
                list.add(c);
            }
  
        }catch(SQLException e){
            
        }
        
        return list;
    }
    
    public boolean savePost(Post p){
        
        boolean f=false;
        try{
            
            String q = "insert into posts(pTitle,pContent,pCode,pPic,catId,userId) values(?,?,?,?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(q);
            pstmt.setString(1, p.getpTitle());
            pstmt.setString(2, p.getpContent());
            pstmt.setString(3, p.getpCode());
            pstmt.setString(4,p.getpPic());
            pstmt.setInt(5, p.getCatId());
            pstmt.setInt(6,p.getUserId());
            
            pstmt.executeUpdate();
            f=true;
            
        }catch(SQLException e){
            
        }
        
        return f;
        
    }
    
}
