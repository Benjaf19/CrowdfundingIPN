/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 * 
 * @author Benjamin Jesus Campos Flores
 * Derechos reservados por Novasoft S.A. de C.V.
 */

function deshabilitacampos(){
    document.getElementById("nombre").disabled = false;
    document.getElementById("ape").disabled = false;
    document.getElementById("escuela").disabled = false;
    document.getElementById("edad").disabled = false;
    document.getElementById("correo").disabled = true;
    document.getElementById("contra").disabled = false;
    document.getElementById("confcontra").disabled = false;
    document.getElementById("guardacambios").disabled = false;
    document.getElementById("modifica").disabled = true;
    document.getElementById("cancelar").disabled = false;
}
function cancela(){
    document.getElementById("nombre").disabled = true;
    document.getElementById("ape").disabled = true;
    document.getElementById("escuela").disabled = true;
    document.getElementById("edad").disabled = true;
    document.getElementById("correo").disabled = true;
    document.getElementById("contra").disabled = true;
    document.getElementById("confcontra").disabled = true;
    document.getElementById("guardacambios").disabled = true;
    document.getElementById("modifica").disabled = false;
    document.getElementById("cancelar").disabled = true;
}
function noMas16(){
    
    document.getElementById("numTarjeta");
}
//aperecer div de registro
var clic=1;

function divAparece(){
    if(clic === 1){
        document.getElementById("caja").style.display="block";
        document.getElementById("caja").style.height="500px";
        document.getElementById("caja").style.transition="height .10s";
        clic=clic+1;
    }else{
        document.getElementById("caja").style.display="none";
        document.getElementById("caja").style.height="0px";
        clic=1;
    }
    
}
function eliminaProyecto() {
    var idP = document.getElementById("idProyecto").value;
    var r = confirm("¿Estas seguro de eliminar este proyecto?");
    if (r == true) {
        window.location = 'eliminaProyecto.jsp?idProyecto='+idP+'';
    } else {
        
    }
    
}
