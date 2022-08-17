<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>


<style>
	body {
	text-align: center;
	}
	h1{
	font-family: "Times New Roman", Times, serif;
  	font-size:50px;
  	font-weight: bold;
	}
	label {
	text-align: center;
  	font-family: "Times New Roman", Times, serif;
  	font-size:25px;
  	font-weight: bold;
	}
	input{
  	font-family: "Times New Roman", Times, serif;
  	font-size:20px;
	}
	button {
	text-align: center;
  	font-family: "Times New Roman", Times, serif;
  	font-size:30px;
  	font-weight: bold;
	}
	div {
	text-align: center;
	}
	
	</style>



<meta charset="UTF-8">
<title>Listing</title>
</head>

<body style="background-color:#DC143C; ">


<%


//attributes of console
String manufacturer = "";
String model="";
String color ="";
String new_or_used= "";
String warranty= "";
String resolution="";
String storage="";
//Nintendo specific 
String oled_or_lcd="";
String screensize="";
String multipleplaymodes="";
//sony xbox specific 
String digital_or_disc="";

//xbox specific 
String ssd_size = "";


String url = "";
String seller_id="";
String start_date = "";
String end_date = "";
//listing specific 
int listingID = 15; //initialize listing new id
int consoleID = 0;
double start_price = 0;
double min_price = 0;
double increment_price=0;
double highest_bid =0;

String uniqueToConsole = "";

try{
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	ResultSet rs;
	String query = "SELECT * FROM listings WHERE listing_id = " + listingID;
	System.out.println(query);
	rs = st.executeQuery(query);
	while (rs.next()) {
		consoleID = Integer.parseInt(rs.getString("consoleID"));
		start_price = Double.parseDouble(rs.getString("start_price"));
		
		try{
		highest_bid = Double.parseDouble(rs.getString("highest_bid"));
		}
		catch(Exception e){
			highest_bid = 0.0;
			
		}
		
		min_price = Double.parseDouble(rs.getString("minimum_price"));
		
		System.out.println("Failed to get data. min price" + min_price);
		increment_price = Double.parseDouble(rs.getString("increment_price"));
		
		System.out.println("Failed to get data." + increment_price);
		seller_id = rs.getString("seller_id");
		System.out.println("Failed to get data." + seller_id);
		start_date = rs.getString("start_date");
		System.out.println("Failed to get data." + start_date);
		end_date = rs.getString("end_date");
		System.out.println("Failed to get data." + end_date);


		
    query = "SELECT * FROM video_game_consoles WHERE console_id = " + consoleID;
    
    System.out.print(query);
    rs = st.executeQuery(query);
    while(rs.next())
    {
         System.out.println("got here");
    	 manufacturer = rs.getString("manufacturer");
    	 model = rs.getString("model");
    	 color = rs.getString("color");
    	 new_or_used = rs.getString("new_or_used");
    	 warranty = rs.getString("warranty");
    	 resolution = rs.getString("resolution");
    	 storage = rs.getString("storage_space");
    }
}
	
	
	
	
	try{
		if(manufacturer.equalsIgnoreCase("sony")){
			
			query = "SELECT * FROM sony_playstation WHERE playstation_id = " + consoleID;
		    rs = st.executeQuery(query);
			
			while(rs.next())
			{
				digital_or_disc= rs.getString("digital_or_disc");
	
			}
			
			uniqueToConsole = "Digital or Disc: " + digital_or_disc;
			url = "https://www.logotaglines.com/wp-content/uploads/2021/06/playstation-Logo-tagline-slogan-motto.jpg";
			

			
			
	   }
		else if(manufacturer.equalsIgnoreCase("microsoft"))	{
			query = "SELECT * FROM microsoft_xbox WHERE xbox_id = " + consoleID;
			
			System.out.println(query);
		    rs = st.executeQuery(query);
			
	
			while(rs.next()){
				digital_or_disc= rs.getString("digital_or_disc");;
				ssd_size = rs.getString("ssd_size");;
				
			}
			
			uniqueToConsole = "Digital or Disc: " + digital_or_disc +  "\n SSD Size: " + ssd_size;
			url = "https://compass-ssl.xbox.com/assets/16/9a/169a7ffe-c2c7-463a-a77c-21239c9ac388.jpg?n=Xbox_Sharing_Xbox-2019-White-on-Green_200x200.jpg";
		    
		}			
		
		else if(manufacturer.equalsIgnoreCase("nintendo"))
		{
			query = "SELECT * FROM nintendo_switch WHERE id = " + consoleID;
		    rs = st.executeQuery(query);
			
			while(rs.next()){
				oled_or_lcd= rs.getString("oled_or_lcd");;
				screensize= rs.getString("screensize");;
				multipleplaymodes= rs.getString("multiple_playmodes");;
				uniqueToConsole = "Screen: " + oled_or_lcd +  "\n Screen Size: " +screensize + "\n Multiple Playmodes: " + multipleplaymodes ;
		}
			url = "https://upload.wikimedia.org/wikipedia/commons/thumb/0/04/Nintendo_Switch_logo%2C_square.png/768px-Nintendo_Switch_logo%2C_square.png";
	}
		
		
		
		
		
}
		
	catch(Exception e)
	{
		
	}
	
	
	
}
catch(Exception e)
{
	System.out.println("Failed to get data.");
}









double minimum_bid = 0;

if(highest_bid < start_price){
	minimum_bid = start_price + increment_price;
}
else{
	minimum_bid = highest_bid + increment_price;
}




%>

    	<br>
        <h1>  <%= manufacturer + " " + model + " " + new_or_used + " in " + color %>  </h1>
		<br>
		
		<img src= <%= url %> alt="consolepix" style="width:200px;height:200px;">
		
		<p> <%= "Manufacturer: " + manufacturer   %>   </p>
		<p> <%= "Model :" + model   %>   </p>
		<p> <%= "New or Used: " + new_or_used   %>   </p>
		<p> <%= "Color: " + color   %>   </p>
		<p> <%= "Storage: " + storage   %>   </p>
		<p> <%= "Seller: " + seller_id   %>   </p>
		<p> <%= "Waranty: " + warranty   %>   </p>
		<p> <%= "Resolution: " + resolution   %>   </p>
		<p> <%= "Start Price: " + start_price   %>   </p>
		<p> <%= "Current bid: " + highest_bid   %>   </p>
		<p> <%= "Start date: " + start_date   %>   </p>
		<p> <%= "End Date: " + end_date   %>   </p>
		

		
		<p> <%=  uniqueToConsole  %>   </p>
		
		

<form method ="post" action = ""> 


		<label for="current_bid">  Bid Amount:
	    
	    <br> 
		<input type="text" id="current_bid"  name="current_bid" value = <%= minimum_bid   %>>
		<br>
		</label>
		
		<label for="upper_bid_limit">  Upper Bid Limit:
	    
	    <br> 
		<input type="text" id="upper_bid_limit"  name="upper_bid_limit" value =<%= minimum_bid   %>  >
		<br>
		</label>

<input type="submit" value="SUBMIT BID" style="font-size:30px;font-weight:bold;text-align:center;color:red;background-color:black">
		
</form>

</body>
</html>