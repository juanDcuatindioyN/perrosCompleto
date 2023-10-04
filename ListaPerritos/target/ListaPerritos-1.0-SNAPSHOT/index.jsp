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
                    ServletContext servletContext = getServletContext();
                    String perrosBuscar=request.getParameter("buscar");
                    
                    if (perrosBuscar==null){
                        nuPerros = metodos.cargarPerrosDesdeArchivo(servletContext);
                        } else if(perrosBuscar!=null){
                        
                        ArrayList<Perros> perros = metodos.cargarPerrosDesdeArchivo(servletContext);
                        ArrayList<Perros> perrosBuscarr = new ArrayList <>();
                        

                      for (Perros i: perros){
                          if(i.getNombre().equals(perrosBuscar)){
                              perrosBuscarr.add(i);
                              
                          }
                         }
                         nuPerros=perrosBuscarr;
                        }
                    if (nuPerros!= null && !nuPerros.isEmpty()){
                        for(Perros cPerros: nuPerros) {                        
                       
                        %>
                        <tr>
                            <td><%= cPerros .getNombre() %></td>
                            <td><%= cPerros .getRaza() %></td>
                            <td><%= cPerros .getFoto()%></td>
                            <td><%= cPerros .getPuntos() %></td>
                            <td><%= cPerros .getEdad() %></td>                                         
                        <td>  <div class="btn-group me-2" role="group" aria-label="First group">
                                     
                                     <a href="#" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" data-nombre="<%=cPerros.getNombre()%>" ><i class ="fa-solid fa-eye"></i> </a>
                                     
                                     <a href="#" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editModal" data-nombre="<%=cPerros.getNombre()%>" ><i class="fa-solid fa-pen" ></i></a>

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

<script>
    /**
     * Esta función se encarga de eliminar un perro a través de una solicitud AJAX al servidor.
     */
    function deleteDog() {
        // Obtiene el nombre del perro desde una variable previamente definida (nombreP)
        var nombre = nombreP;

        // Registra el nombre del perro en la consola (para fines de depuración)
        console.log(nombre);

        // Realiza una solicitud AJAX al servlet 'SvEliminar' para eliminar el perro
        $.ajax({
            url: 'SvBorrar?nombre=' + nombre, // URL del servlet con el parámetro 'nombre' para la eliminación
            method: 'GET', // Método HTTP utilizado para la solicitud (GET en este caso)
            success: function (data) {
                // En caso de éxito en la solicitud:

                // Cierra el modal de eliminación
                $('#deleteModal').modal('hide');

                // Recarga la página actual para reflejar los cambios
                location.reload();
            },
            error: function () {
                // En caso de error en la solicitud:

                // Registra un mensaje de error en la consola (para fines de depuración)
                console.log('Error al eliminar el perro.');
            }
        });
    }
</script>