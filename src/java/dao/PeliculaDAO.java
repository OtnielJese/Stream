/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author otnieljese
 */
import java.util.List;
import model.Pelicula;

public interface PeliculaDAO {
    List<Pelicula> listar();
    Pelicula buscarPorId(int id);
    boolean insertar(Pelicula p);
    boolean actualizar(Pelicula p);
    boolean eliminar(int id);
}