/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.listaperritos;
import java.io.EOFException;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.ArrayList;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author cuati
 */
public class metodos {
     
      ArrayList<Perros> nuPerros = new ArrayList<>(); 

    public void setNuPerros(ArrayList<Perros> nuPerros) {
        this.nuPerros = nuPerros;
    }

    public ArrayList<Perros> getNuPerros() {
        return nuPerros;
    }
      
    
      
      
      public static void guardarDatosDePerrosEnArchivo(ServletContext contexto, ArrayList<Perros> nuPerros) {
         String path= contexto.getRealPath("ser/data.ser");
         File arc= new File (path);
        try {
           
            FileOutputStream fw = new FileOutputStream(path);
            ObjectOutputStream pw =new ObjectOutputStream(fw);
            pw.writeObject(nuPerros);
            pw.close();
            System.out.println("se cargo exitosamente" + path);
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("ha ocurrido un error" + e.getMessage());
        }
    }

    public static ArrayList<Perros> cargarPerrosDesdeArchivo(ServletContext contexto) {
        
        ArrayList<Perros> nuPerros = new ArrayList<>();
        String p="ser/data.ser";
        String path= contexto.getRealPath(p);
        File arc= new File (path);
        System.out.println("El archivo serializado se encuentra en: "+path);
         try {
               FileInputStream fileIn=new FileInputStream(path);
               ObjectInputStream ois=new ObjectInputStream(fileIn);
             
            
             nuPerros = (ArrayList<Perros>) ois.readObject();
             ois.close();
             System.out.println("Se leyo -----");
             System.out.println("buscando en: " + path);
         }catch (FileNotFoundException ex) {
                
                System.out.println("No se encontró el archivo");
            } catch (IOException ex) {
                
                System.out.println("Error al leer el archivo");
            } catch (ClassNotFoundException ex) {
                
                System.out.println("Clase no encontrada al deserializar");
            }
            
       return nuPerros;
    }
     public static Perros BuscarPerroPorNombre(String nombre, ArrayList<Perros> nuPerros){
       
        for( Perros i : nuPerros){
                
            if (i.getNombre().equals(nombre)){
                
                return i; // retorna el perro si se encuentra 
            }
        }
        return null; // retorna null si no se encuentra el perro
    }
public static void BorrarPerro( String borrarNombre, ServletContext context) {
        ArrayList<Perros> nuPerros = cargarPerrosDesdeArchivo (context); 
        // Recorre la lista de perros
        for (int i = 0; i < nuPerros.size(); i++) {
            Perros p = nuPerros.get(i);

            // Comprueba si el nombre del perro coincide con el nombre proporcionado
            if (p.getNombre().equals(borrarNombre)) {

                // Obtiene la ruta relativa de la carpeta de imágenes
                String rutaRelativa = "/fotos/";

                // Obtiene la ruta absoluta en el sistema de archivos
                String rutaAbsoluta = context.getRealPath(rutaRelativa);

                // Crea un objeto File para la carpeta de imágenes
                File archivo = new File(rutaAbsoluta);

                // Crea un objeto File para la imagen a eliminar
                File borrarFoto = new File(archivo + "/" + p.getFoto());

                // Verifica si la imagen existe y la elimina
                if (borrarFoto.exists()) {
                    // Elimina la imagen del sistema de archivos
                    borrarFoto.delete();
                    if (borrarFoto.delete()) {
                        System.out.println("");
                    } else {
                        System.err.println("");
                    }
                } else {
                    System.err.println("");
                }

                // Elimina el perro de la lista
                nuPerros.remove(i);
                i--; // Ajusta el índice después de eliminar el elemento
            }
        }
        guardarDatosDePerrosEnArchivo(context,nuPerros );
    }
}        



