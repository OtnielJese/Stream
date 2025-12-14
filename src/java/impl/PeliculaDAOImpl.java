package impl;

import dao.PeliculaDAO;
import model.Pelicula;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PeliculaDAOImpl implements PeliculaDAO {

    @Override
    public List<Pelicula> listar() {
        List<Pelicula> lista = new ArrayList<>();
        String sql = "SELECT p.id_pelicula, p.titulo, p.descripcion, p.anio, p.imagen_url, " +
                     "p.id_categoria, c.nombre AS nombre_categoria " +
                     "FROM tb_pelicula p INNER JOIN tb_categoria c ON p.id_categoria=c.id_categoria " +
                     "ORDER BY c.nombre, p.titulo";
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Pelicula p = new Pelicula();
                p.setIdPelicula(rs.getInt("id_pelicula"));
                p.setTitulo(rs.getString("titulo"));
                p.setDescripcion(rs.getString("descripcion"));
                int anio = rs.getInt("anio");
                p.setAnio(rs.wasNull() ? null : anio);
                p.setImagenUrl(rs.getString("imagen_url"));
                p.setIdCategoria(rs.getInt("id_categoria"));
                p.setNombreCategoria(rs.getString("nombre_categoria"));
                lista.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    @Override
    public Pelicula buscarPorId(int id) {
        String sql = "SELECT id_pelicula, titulo, descripcion, anio, imagen_url, id_categoria FROM tb_pelicula WHERE id_pelicula=?";
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Pelicula p = new Pelicula();
                    p.setIdPelicula(rs.getInt("id_pelicula"));
                    p.setTitulo(rs.getString("titulo"));
                    p.setDescripcion(rs.getString("descripcion"));
                    int anio = rs.getInt("anio");
                    p.setAnio(rs.wasNull() ? null : anio);
                    p.setImagenUrl(rs.getString("imagen_url"));
                    p.setIdCategoria(rs.getInt("id_categoria"));
                    return p;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean insertar(Pelicula p) {
        String sql = "INSERT INTO tb_pelicula(titulo, descripcion, anio, imagen_url, id_categoria) VALUES(?,?,?,?,?)";
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, p.getTitulo());
            ps.setString(2, p.getDescripcion());
            if (p.getAnio() == null) ps.setNull(3, java.sql.Types.INTEGER);
            else ps.setInt(3, p.getAnio());
            ps.setString(4, p.getImagenUrl());
            ps.setInt(5, p.getIdCategoria());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean actualizar(Pelicula p) {
        String sql = "UPDATE tb_pelicula SET titulo=?, descripcion=?, anio=?, imagen_url=?, id_categoria=? WHERE id_pelicula=?";
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, p.getTitulo());
            ps.setString(2, p.getDescripcion());
            if (p.getAnio() == null) ps.setNull(3, java.sql.Types.INTEGER);
            else ps.setInt(3, p.getAnio());
            ps.setString(4, p.getImagenUrl());
            ps.setInt(5, p.getIdCategoria());
            ps.setInt(6, p.getIdPelicula());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean eliminar(int id) {
        String sql = "DELETE FROM tb_pelicula WHERE id_pelicula=?";
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
