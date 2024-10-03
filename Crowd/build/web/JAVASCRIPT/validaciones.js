/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 * 
 * @author Ricardo Palomino Bravo
 * Derechos reservados por Novasoft S.A. de C.V.
 */

/*Usuario*/
function ValidarLogin(formu) {
    if (document.getElementById('boleta').value === '') {
        alert("Escribe tu boleta");
        formu.boleta.focus();
        return(false);
    } else {
        if (document.getElementById('contra').value === '') {
            alert("Escribe tu contraseña");
            formu.contra.focus();
            return(false);
        }
    }
}

function ValidarRegistroUsuario(formu) {
    if (document.getElementById('boleta').value === '') {
        alert("Escribe tu boleta");
        formu.boleta.focus();
        return(false);
    } else {
        if (document.getElementById('nombre').value === '') {
            alert("Escribe tu nombre");
            formu.nombre.focus();
            return(false);
        }
        else{
            if (document.getElementById('ape').value === '') {
                alert("Escribe tu apellidos");
                formu.ape.focus();
                return(false);
            }
            else{
                if (document.getElementById('edad').value === '') {
                    alert("Escribe tu edad");
                    formu.edad.focus();
                    return(false);
                }
                else{
                    if (document.getElementById('correo').value === '') {
                        alert("Escribe tu correo");
                        formu.correo.focus();
                        return(false);
                    }
                    else{
                        if (document.getElementById('contra').value === '') {
                            alert("Escribe tu contraseña");
                            formu.contra.focus();
                            return(false);
                        }
                        else{
                            if (document.getElementById('confcontra').value === '') {
                                alert("Confirma tu contraseña");
                                formu.confcontra.focus();
                                return(false);
                            }
                        }
                    }
                }
            }
        }
    }
}
/*Usuario*/

/*Colaborador*/
function ValidaRegistroColaborador(formu){
    if (document.getElementById('carrera').value === '') {
        alert("Escribe tu carrera");
        formu.carrera.focus();
        return(false);
    }
    else{
        if (document.getElementById('recompensas').value === '') {
            alert("Escribe alguna información extra");
            formu.recompensas.focus();
            return(false);
        }
    }
}
/*Colaborador*/

/*Donaciones*/
function ValidaDonaciones(){
    
}
/*Donaciones*/


/*Proyecto*/
function ValidaRegistroProyecto(formu){
    if (document.getElementById('nombre').value === '') {
        alert("Escribe el nombre de tu proyecto");
        formu.nombre.focus();
        return(false);
    } else {
        if (document.getElementById('descripcion').value === '') {
            alert("Escribe una descripción de tu proyecto");
            formu.descripcion.focus();
            return(false);
        } else {
            if (document.getElementById('finan').value === '') {
                alert("Escribe la financiación");
                formu.finan.focus();
                return(false);
            } else {
                if (document.getElementById('plazo').value === '') {
                    alert("Escribe el plazo");
                    formu.plazo.focus();
                    return(false);
                }
                else{
                    if (document.getElementById('recompensas').value === '') {
                        alert("Escribe las recompensas para los donadores");
                        formu.recompensas.focus();
                        return(false);
                    }
                }
            }
        }
    }
}
/*Proyecto*/


/*Paypal*/
function ValidarRegistroPaypal(formu){
    if (document.getElementById('correopp').value === '') {
        alert("Escribe tu correo Paypal");
        formu.correopp.focus();
        return(false);
    } else {
        if (document.getElementById('pswdpp').value === '') {
            alert("Escribe tu contrasela Paypal");
            formu.pswdpp.focus();
            return(false);
        }
    }
}
/*Paypal*/

/*Tarjeta*/
function  ValidarRegistroTarjeta(formu){
    if (document.getElementById('numTarjeta').value === '') {
        alert("Escribe el número de tu tarjeta");
        formu.numTarjeta.focus();
        return(false);
    }
    else{
        if (document.getElementById('codigoSeg').value === '') {
            alert("Escribe el código de seguridad");
            formu.codigoSeg.focus();
            return(false);
        }
        else{
            if (document.getElementById('direccion').value === '') {
                alert("Escribe tu dirección");
                formu.direccion.focus();
                return(false);
            }
        }
    }
}
/*Tarjeta*/

function QuitarScript(){
    var x = event.keyCode;
    
    if(x==60 || x==62){
        event.returnValue = false;
    }
}
function Nosignosint(){
    var x = event.keyCode;
    
    if(x==63 || x==168 || x==182){
        event.returnValue = false;
    }
}
function soloNumeros(){
    var x = event.keyCode;
    
    if(x<48 || x>57){
        event.returnValue = false;
    }
}

