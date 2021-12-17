<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Veneen tietojen muokkaaminen</title>
</head>
<body>
<form id="tiedot">
	<table class="table">
		<thead>
			<tr>
				<th colspan="6">Veneiden nettikirjasto - Veneen tietojen muokkaaminen</th>
			</tr>
			<tr>
				<th colspan="6" class="oikealle"><span id="takaisin">Takaisin</span></th>
			</tr>
			<tr>
				<th>Nimi</th>
				<th>Merkkimalli</th>
				<th>Pituus (m)</th>
				<th>Leveys (m)</th>
				<th>Hinta (€)</th>		
				<th>Hallinta</th>
			</tr>
		</thead>
			<tr>
				<td><input type="text" name="nimi" id="nimi"></td>
				<td><input type="text" name="merkkimalli" id="merkkimalli"></td>
				<td><input type="text" name="pituus" id="pituus"></td>
				<td><input type="text" name="leveys" id="leveys"></td>
				<td><input type="text" name="hinta" id="hinta"></td>				
				<td><input type="submit" value="Tallenna" id="tallenna"></td>
			</tr>
		<tbody>
		</tbody>
	</table>
	<input type="hidden" name="tunnus" id="tunnus">
</form>
<span id="ilmo"></span>
</body>
<script>
$(document).ready(function(){
	
	$("#takaisin").click(function(){
		document.location="listaaveneet.jsp";
	});
	
	$("#nimi").focus();//viedään kursori etunimi-kenttään sivun latauksen yhteydessä
	
	//Haetaan muutettavan veneen tiedot. Kutsutaan backin GET-metodia ja välitetään kutsun mukana muutettavan tiedon id
	//GET /veneet/haeyksi/id
	var tunnus = requestURLParam("tunnus"); //Funktio löytyy scripts/main.js 	
	$.ajax({url:"veneet/haeyksi/"+tunnus, type:"GET", dataType:"json", success:function(result){	
		$("#nimi").val(result.nimi);	
		$("#merkkimalli").val(result.merkkimalli);
		$("#pituus").val(result.pituus);
		$("#leveys").val(result.leveys);	
		$("#hinta").val(result.hinta);
		$("#tunnus").val(result.tunnus);		
    }});
	
	$("#tiedot").validate({						
		rules: {
			nimi:  {
				required: true,				
				minlength: 2				
			},	
			merkkimalli:  {
				required: true,				
				minlength: 2				
			},
			pituus:  {
				required: true,
				minlength: 5
			},	
			leveys:  {
				required: true,				
				minlength: 2			
			},
			hinta:  {
				required: true,				
				minlength: 2			
			}
		},
		messages: {
			nimi: {     
				required: "Puuttuu",				
				minlength: "Liian lyhyt"			
			},
			merkkimalli: {
				required: "Puuttuu",				
				minlength: "Liian lyhyt"
			},
			pituus: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			leveys: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			hinta: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			}
		},			
		submitHandler: function(form) {	
			vieTiedot();
		}		
	});   
});

//Funktion tietojen muuttamista varten. Kutsutaan backin PUT-metodia ja välitetään kutsun mukana muutetut tiedot json-stringinä.
//PUT /veneet/
function vieTiedot(){ 
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray()); //muutetaan lomakkeen tiedot json-stringiksi
	$.ajax({url:"veneet", data:formJsonStr, type:"PUT", success:function(result) { //result on joko {"response:1"} tai {"response:0"}		
      if(result.response==0){
      	$("#ilmo").html("Tietojen päivitys epäonnistui.");
      }else if(result.response==1){
      	$("#ilmo").html("Tietojen päivitys onnistui.");
		}
  }});
}
</script>
</html>