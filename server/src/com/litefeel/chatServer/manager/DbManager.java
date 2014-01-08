package com.litefeel.chatServer.manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DbManager
{
	
	private Connection conn;
	private String[] gmInfo;
	
	public void initManager() throws Exception
	{
		if(conn != null) return;
		
		try{
//            conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/test1?user=root&password=root&useUnicode=true&characterEncoding=UTF-8");
        } catch (Exception ex){
//            ex.printStackTrace();
            System.out.println("连接到MySQL数据库时出错！");
//            throw ex;
        }
        System.out.println("连接成功！");
	}
	
	/**
	 * 获取GM用户名列表
	 * @return
	 * @throws Exception
	 */
	public String[] getGMUserNameList() throws Exception
	{
		if(gmInfo != null) return gmInfo;
		
        //得到MySQL操作流
        Statement stmt = null;
        ResultSet rs = null;
        String sql = "SELECT usernameFROM gm_accounts";
        String[] info = null;
        
        try {
        	stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
            
            if(rs.last())
            {
            	int row = rs.getRow();
            	gmInfo = new String[row];
            	rs.first();
            	int index = 0;
            	while(rs.next())
            	{
            		gmInfo[index] = rs.getString(0);
            		index++;
            	}
            }
         // Now do something with the ResultSet ....
        }catch(Exception ex) {
            ex.printStackTrace();
            System.out.println("在创建MySQL操作流时出错。");
        }
        
        finally{
        	
        	try
			{
				stmt.close();
			} catch (SQLException e)
			{
				e.printStackTrace();
			}
	         try
			{
				rs.close();
			} catch (SQLException e)
			{
				e.printStackTrace();
			}
        }
		return info;
	}
	
	public DbManager() throws Exception
	{
		conn = null;
		//载入MySQL驱动程序
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
        } catch (InstantiationException ex) {
            ex.printStackTrace();
            System.out.println("载入MySQL数据库驱动时出错");
        } catch (ClassNotFoundException ex) {
//            ex.printStackTrace();
            System.out.println("载入MySQL数据库驱动时出错");
        } catch (IllegalAccessException ex) {
            ex.printStackTrace();
            System.out.println("载入MySQL数据库驱动时出错");
        }
        
        //连接到MySQL数据库
        try{
   
        } catch (Exception ex){
            ex.printStackTrace();
            System.out.println("连接到MySQL数据库时出错！");
            throw ex;
        }
	}
	
	/**
	 * 获取用户信息
	 * @param nickName
	 * @return	userName, password, nickName(null, 用户名或者密码错误)
	 */
	public String[] getUserInfo(String userName)
	{
		//得到MySQL操作流
       /** Statement stmt = null;
        ResultSet rs = null;
        String sql = "SELECT username, nickname, password FROM users where username='" + userName + "'";
        String[] info = null;
        
        try {
        	stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
	         // or alternatively, if you don't know ahead of time that
	         // the query will be a SELECT...
	         //if (stmt.execute("SELECT foo FROM bar")) {
	        // rs = stmt.getResultSet();
	         //ResultSetMetaData rsmd = rs.getMetaData();
	         //int numberOfColumns = rsmd.getColumnCount();
	         //boolean b = rsmd.isSearchable(1);
	         //System.out.println(numberOfColumns);
	         if(rs.next())
	         {
	        	 //String[] arr = new String[numberOfColumns];
//	        	 for(int i = 1;i<=numberOfColumns;i++)
//	        	 {
//	        		 arr[i-1] = rs.getString(i);
//	        	 }
	        	// System.out.println(arr[6]);
	        	 info = new String[3];
	        	 info[0] = rs.getString("username");
	        	 info[1] = rs.getString("password");
	        	 info[2] = rs.getString("nickname");
	         }
         //}
         // Now do something with the ResultSet ....
        } catch(Exception ex) {
            ex.printStackTrace();
            System.out.println("在创建MySQL操作流时出错。");
        }
        
        finally{
        	
        	try
			{
				stmt.close();
			} catch (SQLException e)
			{
				e.printStackTrace();
			}
	         try
			{
				rs.close();
			} catch (SQLException e)
			{
				e.printStackTrace();
			}
        }
        */
//		return info;
		String [] tmp = new String[3];
		tmp[0] = userName;
		tmp[1] = userName;
		tmp[2] = userName;
		return tmp;
	}
	
	/**
	 * 获取系统消息
	 * @return
	 */
	public String[] getSystemMessage()
	{
//		得到MySQL操作流
//        Statement stmt = null;
//        ResultSet rs = null;
//        String sql = "SELECT username, nickname, password FROM users where username='" + userName + "'";
//        String[] info = null;
        
        
		return null;
	}
	
	
	public static void main(String[] argv)
	{
        
        try
		{
			new DbManager();
			System.out.println("链接数据库成功!");
		} catch (Exception e)
		{
			e.printStackTrace();
		}
        ////////////////////////////////////////////////////////////////////////
        
        //得到MySQL操作流
//        Statement stmt = null;
//        ResultSet rs = null;
        /*try {
        	stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM chats");
	         // or alternatively, if you don't know ahead of time that
	         // the query will be a SELECT...
	         //if (stmt.execute("SELECT foo FROM bar")) {
	         rs = stmt.getResultSet();
	         ResultSetMetaData rsmd = rs.getMetaData();
	         int numberOfColumns = rsmd.getColumnCount();
	         //boolean b = rsmd.isSearchable(1);
	         System.out.println(numberOfColumns);
	         if(rs.next())
	         {
	        	 String[] arr = new String[numberOfColumns];
	        	 for(int i = 1;i<=numberOfColumns;i++)
	        	 {
	        		 arr[i-1] = rs.getString(i);
	        	 }
	        	 System.out.println(arr[6]);
	         }
	         
         //}
         // Now do something with the ResultSet ....
        } catch(Exception ex) {
            ex.printStackTrace();
            System.out.println("在创建MySQL操作流时出错。");
            System.exit(0);
        }*/
        //////////////////////////////////////////////////////////////////////
        
        
        
        /*//打个数据文件
        java.io.BufferedReader in = null;
        javax.swing.JFileChooser jfc = null;
        java.io.File select_file = null;
        try{
            jfc = new javax.swing.JFileChooser();
            jfc.showOpenDialog(null);
            select_file = jfc.getSelectedFile();
            in = new java.io.BufferedReader(new java.io.InputStreamReader(new java.io.FileInputStream(select_file)));
        } catch(Exception ex){
            ex.printStackTrace();
            System.out.println("打开数据文件时出错！");
            System.exit(0);
        }
        ////////////////////////////////////////////////////////////////////
        
        //处理打开的文件
        String readLine = null;
        try{
            readLine = in.readLine();
            while(readLine != null){
                System.out.println(readLine);
                readLine = in.readLine();
            }
        }catch(Exception ex){
            ex.printStackTrace();
            System.out.println("在处理打开的数据文件时出错。");
            System.exit(0);
        }
        ///////////////////////////////////////////////////////////////////
        
        //关半程序所占用的资源
        try{
            conn.close();
            in.close();
        }catch(Exception ex){
            ex.printStackTrace();
            System.out.println("关闭程序所占用的资源时出错");
            System.exit(0);
        }*/
        ///////////////////////////////////////////////////////////////
    } 
}
