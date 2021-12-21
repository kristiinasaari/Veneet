<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Veneiden haku</title>
</head>
<body>
	<table id="listaus">
		<thead>	
			<tr>
				<th colspan="6">Veneiden nettikirjasto</th>
			</tr>
			<tr>
				<th colspan="6" class="oikealle"><span id="uusiVene">Lisää uusi vene</span></th>
			</tr>
			<tr>
				<th colspan="4" class="oikealle">Hakusana:</th>
				<th><input type="text" id="hakusana"></th>
				<th><input type="button" id="hae" value="Hae"></th>
			</tr>		
			<tr>
				<th>Nimi</th>
				<th>Merkkimalli</th>
				<th>Pituus (m)</th>
				<th>Leveys (m)</th>
				<th>Hinta (€)</th>
				<th>&nbsp;</th>				
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
<script>
$(document).ready(function(){
	
	$("#uusiVene").click(function(){
		document.location="lisaavene.jsp";
	});
	
	$(document.body).on("keydown", function(event){
		  if(event.which==13){ //Enteriä painettu, ajetaan haku
			  haeTiedot();
		  }
	});	
	$("#hae").click(function(){	
		haeTiedot();
	});
	$("#hakusana").focus();//viedään kursori hakusana-kenttään sivun latauksen yhteydessä
	haeTiedot();
});

function haeTiedot(){	
	$("#listaus tbody").empty();
	$.getJSON({url:"veneet/"+$("#hakusana").val(), type:"GET", dataType:"json", success:function(result){	
		$.each(result.veneet, function(i, field){  
        	var htmlStr;
        	htmlStr+="<tr id='rivi_"+field.tunnus+"'>";
        	htmlStr+="<td>"+field.nimi+"</td>";
        	htmlStr+="<td>"+field.merkkimalli+"</td>";
        	htmlStr+="<td>"+field.pituus+"</td>";
        	htmlStr+="<td>"+field.leveys+"</td>"; 
        	htmlStr+="<td>"+field.hinta+"</td>";
        	htmlStr+="<td><a href='muutavene.jsp?tunnus="+field.tunnus+"'>Muuta</a>&nbsp;";
        	htmlStr+="<span class='poista'&nbsp;onclick=poista("+field.tunnus+",'"+field.nimi+"','"+field.merkkimalli+"')>Poista</span></td>"; 
        	htmlStr+="</tr>";
        	$("#listaus tbody").append(htmlStr);
        });
    }});	
}

//POSTMANIN KAUTTA SAADAAN VASTAUS {"response:1"}, nappi ei kuitenkaan toimi?
function poista(tunnus, nimi, merkkimalli){
	if(confirm("Poista vene " + nimi +" "+ merkkimalli +"?")){	
		$.ajax({url:"veneet/"+tunnus, type:"DELETE", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}
	        if(result.response==0){
	        	$("#ilmo").html("Veneen poisto epäonnistui.");
	        }else if(result.response==1){
	        	$("#rivi_"+tunnus).css("background-color", "red"); //Värjätään poistetun asiakkaan rivi
	        	alert("Veneen " + nimi +" "+ merkkimalli +" poisto onnistui.");
				haeTiedot();        	
			}
	    }});
	}
}

</script>
</body>
</html>
