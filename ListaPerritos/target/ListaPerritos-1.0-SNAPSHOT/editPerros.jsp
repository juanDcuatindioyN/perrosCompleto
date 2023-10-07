<%@page import="com.mycompany.listaperritos.metodos"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.ObjectInputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="com.mycompany.listaperritos.Perros"%>
<%@page import="java.util.ArrayList"%>
<%@include file="templates/header.jsp" %>
<!DOCTYPE html>
<%
    ArrayList<Perros> nuPerros = null;

    String editNombre = request.getParameter("editar");

    ServletContext context = getServletContext();

    Perros perros = null;

    // Verificar si cargarPerrosDesdeArchivo devuelve null
    nuPerros = metodos.cargarPerrosDesdeArchivo(context);
    if (nuPerros == null) {
        // Manejar la situación en la que cargarPerrosDesdeArchivo devuelve null
        // Puedes imprimir un mensaje de error o tomar la acción necesaria
    } else {
        // Iterar sobre la lista solo si cPerros no es null
        for (Perros i : nuPerros) {
            // Verificar si i o i.getNombre() son null antes de usarlos
            if (i != null && i.getNombre() != null && i.getNombre().equals(editNombre)) {
                perros = i;
                break;
            }
        }
    }
%>
 
         <form action="SvPerros" method="POST" enctype="multipart/form-data">

  
                <div class="container text-center">
                 <h1>Aqui puedes editar los datos de tu mascota</h1>
                  </div>
    
                    <div class="input-group mb-3">
                        <span class="input-group-text" id="basic-addon1" >Nombre</span>
  
                        <input type="text" class="form-control" name="nombre" value="<%out.print(perros.getNombre());%>" readonly>
                   </div>
   
                     <div class="input-group mb-3">
                        <span class="input-group-text" id="basic-addon1">Raza</span>
                        <input type="text" class="form-control" name="raza"  value="<%out.print(perros.getRaza());%> ">
                   </div>
     
     
     
                  <div class="input-group mb-3">
                        <span class="input-group-text" id="basic-addon1">Foto</span>                      
                        <input type="file" class="form-control" name="foto" value="<%out.print(perros.getFoto());%>" required="true">
                        
                   </div>
                        
       
     
                    <select class="form-select" aria-label="Default select example" name="punto">
                        
                 
                        <option selected>Puntos</option>
                        <option value="1" <% if (perros.getPuntos() == 1) out.print("selected"); %>>1</option>
                        <option value="2" <% if (perros.getPuntos() == 2) out.print("selected"); %>>2</option>
                        <option value="3" <% if (perros.getPuntos() == 3) out.print("selected"); %>>3</option>
                        <option value="4" <% if (perros.getPuntos() == 4) out.print("selected"); %>>4</option>
                        <option value="5" <% if (perros.getPuntos() == 5) out.print("selected"); %>>5</option>
                        <option value="6" <% if (perros.getPuntos() == 6) out.print("selected"); %>>6</option>
                        <option value="7" <% if (perros.getPuntos() == 7) out.print("selected"); %>>7</option>
                        <option value="8" <% if (perros.getPuntos() == 8) out.print("selected"); %>>8</option>
                        <option value="9" <% if (perros.getPuntos() == 9) out.print("selected"); %>>9</option>
                        <option value="10" <% if (perros.getPuntos() == 10) out.print("selected"); %>>10</option>
                      </select>
                <br>
   
                        <div class="input-group mb-3">
                        <span class="input-group-text" id="basic-addon1">Edad</span>
                      
                        <input type="number" name="edad" class="form-control" min="0" step="1" value="<%out.print(perros.getEdad());%>" required><br>
                        <input type="text" name="editar"  value="si" readonly style="display:none" > 
                        </div> 

     
                 <div class="mb-3">
               
                         <input type="submit" value="Insertar Perro" class="btn btn-primary">
                   </div>
            </form>           
<%@include file="templates/footer.jsp" %>