
<%@page import="com.mycompany.listaperritos.metodos"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.ObjectInputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="com.mycompany.listaperritos.Perros"%>
<%@page import="java.util.ArrayList"%>
<%@include file="templates/header.jsp" %>

<!-- creamos un container para poner  -->
<div class ="container p-1">     
<form action="SvOpciones" method="POST" >
    <div class="mb-2">
        <label for="busqueda" class="form-label">Buscar perros por nombre:</label>
        <input type="text" class="form-control" name="busqueda">
    </div>
    <button type="submit" class="btn btn-primary">Buscar</button>
</form>

    <div class="row">
        <div class="col-md-4">
            <h2>Ingrese un nuevo perro</h2>
    <form action="SvPerros" method="POST" enctype="multipart/form-data" >
        <div class="mb-2">
        <label for="nombre" class="form-label">Nombre</label>
        <input type="text" class="form-control" name="nombre" aria-describedby="basic-addon1">
        <div id="nombrePerros" class="form-text"></div>
     </div>
     <div class="mb-2">
        <label for="raza" class="form-label">Raza</label>
        <input type="text" class="form-control" name="raza" aria-describedby="basic-addon1">
        <div id="raza" class="form-text"></div>
     </div>
        <div class="mb-2">
        <label for="foto" class="form-label">foto</label>
        <input type="file" class="form-control" name="foto" aria-describedby="basic-addon1">
        <div id="foto" class="form-text"></div>
     </div>
       
            <div class="mb-2">
      <label for="puntos" class="form-label">Puntos</label>
      <select id="disabledSelect" class="form-select" name="puntos">   
            <option selected>seleccionar</option>
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
            <option value="6">6</option>
            <option value="7">7</option>
            <option value="8">8</option>
            <option value="9">9</option>
            <option value="10">10</option>
      </select>
            </div>
        <div class="mb-2">
        <label for="edad" class="form-label">Edad</label>
        <input type="number" class="form-control" name="edad" aria-describedby="basic-addon1">
        <div id="edad" class="form-text"></div>
     </div>         
        <button type="submit" class="btn btn-primary">insertar perro</button>
    </form>
        </div>
       
        <div class="col-md-8 " >
            <table class="table table-striped table-dark ">
              <nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <a class="navbar-brand" href="#"></a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item dropdown">
   <!-- Desplegable organizar por -->
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"> Ordenar por
          </a>
                 <ul class="dropdown-menu">
   <!-- Redirije al index, a la pagina principal -->
            <li><a class="dropdown-item" href="index.jsp?tipo=nombre">Nombre</a></li>
            <li><a class="dropdown-item" href="index.jsp?tipo=edad">edad</a></li>
            <li><a class="dropdown-item" href="index.jsp?tipo=puntos">puntos</a></li>
          </ul>
        </li>
      </ul>
        </li>
      </ul>
    </div>
  </div>
</nav>   
                <thead> 
                    <tr>
                        <th>Nombre</th>
                        <th>Raza</th>
                        <th>Foto</th>
                        <th>Puntos</th>
                        <th>Edad</th>
                        <th>Acciones</th>
                    </tr>   
                </thead>
                <tbody>
                    <% 
                    ArrayList<Perros> nuPerros = new ArrayList<>();
                    
                    
                    String perrosBuscar=request.getParameter("buscar");
                    String tipo= request.getParameter("tipo");
                    System.out.println(tipo);
                    ServletContext servletContext = getServletContext();
                    if (perrosBuscar==null && tipo==null){
                        nuPerros = metodos.cargarPerrosDesdeArchivo(servletContext);
                        } else if(perrosBuscar!=null && tipo==null){
                        
                        ArrayList<Perros> perros = metodos.cargarPerrosDesdeArchivo(servletContext);
                        ArrayList<Perros> perrosBuscarr = new ArrayList <>();
                        

                      for (Perros i: perros){
                          if(i.getNombre().equals(perrosBuscar)){
                              perrosBuscarr.add(i);
                              
                          }
                         }
                         nuPerros=perrosBuscarr;
                        }else if(tipo!=null ){
            
            nuPerros = metodos.ordenarPerro(tipo, servletContext);                  }
                    if (nuPerros!= null && !nuPerros.isEmpty()){
                        for(Perros cPerros: nuPerros) {                        
                       
                        %>
                        <tr>
                            <td><%= cPerros .getNombre() %></td>
                            <td><%= cPerros .getRaza() %></td>
                            <td><%= cPerros .getFoto()%></td>
                            <td><%= cPerros .getPuntos() %></td>
                            <td><%= cPerros .getEdad() %></td>                                         
                        <td>  
                            <div class="btn-group me-2" role="group" aria-label="First group">
                                     
                                     <a href="#" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" data-nombre="<%=cPerros.getNombre()%>" ><i class ="fa-solid fa-eye"></i> </a>
                                     
                                     <a href="editPerros.jsp?editar=<%= cPerros.getNombre()%>" class="btn btn-primary" ><i class="fa-solid fa-pen" ></i></a>

                                    <a href="SvEliminar?nombre=<%= cPerros.getNombre()%>" class="btn btn-primary" ><i class="fa-solid fa-trash" ></i></a>
                                  </div></td>

                        </tr>
                        <%
                            }
                }else{ %>
                        <td><% out.println("No hay perros"); %> </td>
<%}
  %>                 
                </tbody>  
            </table>

        </div>
    </div>
  </div> 
 <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true"> 
         <div class="modal-dialog"> 
             <div class="modal-content"> 
                 <div class="modal-header"> 
                    <h5 class="modal-title" id="exampleModalLabel">Detalles del Perro</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> 
                 </div>
                 <div class="modal-body"> 
                  
                     <div id="perro-details">                   
                </div>
                 </div> 
                 <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button> 
                </div>
             </div> 
         </div> 
     </div>
      <div class="modal fade" id="confModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true"> 
         <div class="modal-dialog"> 
             <div class="modal-content"> 
                 <div class="modal-header"> 
                    <h5 class="modal-title" id="exampleModalLabel">¿Estás seguro de eliminar a </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> 
                 </div>
                 <div class="modal-body"> 
                  <div id="perro-details" style="display: flex; justify-content: center;">
                     <button type="button" id = "confirmar" class="btn btn-primary" data-bs-dismiss="modal"data-bs-target="#deleteModalConfirm" onclick="deleteDog()">Eliminar Definitivamente</button>
                     <button type="button" id = "cancelar" class = "btn btn-danger" data-bs-dismiss="modal" > Cancelar</button>
                </div>
                 </div>
             </div> 
         </div> 
     
  <script src="script.js"></script>
 
<%@include file="templates/footer.jsp" %>
<!-- Ventana emergente muestra datos de los perros -->
<script>
    // funcion para mostrar los datos en la ventana modal
  $('#exampleModal').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget); // Botón que desencadenó el evento
    var nombre = button.data('nombre'); // Obtén el nombre del perro
   
    // Realiza una solicitud AJAX al servlet para obtener los detalles del perro por su nombre
    $.ajax({
      url: 'SvPerros?nombre=' + nombre, // Cambia 'id' por el nombre del parámetro que esperas en tu servlet
      method: 'GET',
      success: function (data) {
        // Actualiza el contenido del modal con los detalles del perro
        $('#perro-details').html(data);
      },
      error: function () {
        // Maneja errores aquí si es necesario
        console.log('Error al cargar los detalles del perro.');
      }
    });
  });

/**
 * BUSCAR PERRO
 */
    /**
     * Variable global utilizada para almacenar temporalmente el nombre del perro
     * que se mostrará en el modal de confirmación antes de eliminarlo.
     */
    var nombreP = "";

    /**
     * Esta función se encarga de mostrar el modal de confirmación antes de eliminar un perro.
     * Se dispara cuando se muestra el modal.
     */
    $('#deleteModalConfirm').on('show.bs.modal', function (event) {
        // Obtiene el botón que desencadenó el evento de mostrar el modal
        var button = $(event.relatedTarget);

        // Obtiene el nombre del perro desde el atributo 'data-nombre' del botón
        var nombrePerro = button.data('nombre');

        // Obtiene el modal actual
        var modal = $(this);

        // Almacena el nombre del perro en la variable global 'nombreP'
        nombreP = nombrePerro;

        // Actualiza el contenido del modal con el nombre del perro
        modal.find('#nombrePerroEnModal').text(nombrePerro);
    });
</script>

