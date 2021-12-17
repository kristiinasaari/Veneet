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
<title>Lisää uusi vene</title>
</head>
<body>
<form id="tiedot">
	<table>
	<thead>
		<tr>
			<th colspan="6">Veneiden nettikirjasto - Lisää uusi vene</th>
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
			<th></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><input type="text" name="nimi" id="nimi"></td>
			<td><input type="text" name="merkkimalli" id="merkkimalli"></td>
			<td><input type="text" name="pituus" id="pituus"></td>
			<td><input type="text" name="leveys" id="leveys"></td> 
			<td><input type="text" name="hinta" id="hinta"></td> 
			<td><input type="submit" id="tallenna" value="Lisää"></td>
		</tr>
	</tbody>
</table>
</form>
<span id="ilmo"></span>
<script>
$(document).ready(function(){
	$("#takaisin").click(function(){
		document.location="listaaveneet.jsp";
	});
	//Lomakkeen tietojen tarkistus. Kun lomakkeen kaikki tiedot ovat ok, kutsutaan lisaaTiedot()-funktiota
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
				minlength: 1
			},	
			leveys:  {
				required: true,				
				minlength: 1			
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
			lisaaTiedot();
		}		
	});  
	//Viedään kursori etunimi-kenttään sivun latauksen yhteydessä
	$("#nimi").focus(); 
});
function lisaaTiedot(){
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray()); //muutetaan lomakkeen tiedot json-stringiksi
	console.log(formJsonStr);
	$.ajax({url:"veneet", data:formJsonStr, type:"POST", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}       
		if(result.response==0){
        	$("#ilmo").html("Veneen lisääminen epäonnistui.");
        }else if(result.response==1){			
        	$("#ilmo").html("Veneen lisääminen onnistui.");
        	$("#nimi, #merkkimalli, #pituus, #leveys, #hinta").val("");
		}
    }});	
}
</script>
</body>
</html>