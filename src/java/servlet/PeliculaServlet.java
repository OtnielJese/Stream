package servlet;

import dao.CategoriaDAO;
import dao.PeliculaDAO;
import impl.CategoriaDAOImpl;
import impl.PeliculaDAOImpl;
import model.Pelicula;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/peliculas")
public class PeliculaServlet extends HttpServlet {

    private final PeliculaDAO peliculaDAO = new PeliculaDAOImpl();
    private final CategoriaDAO categoriaDAO = new CategoriaDAOImpl();

    private boolean sesionOK(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession s = request.getSession(false);
        if (s == null || s.getAttribute("usuarioLogueado") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return false;
        }
        return true;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!sesionOK(request, response)) return;

        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        if ("editar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            request.setAttribute("peliculaEdit", peliculaDAO.buscarPorId(id));
        } else if ("eliminar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            peliculaDAO.eliminar(id);
            response.sendRedirect(request.getContextPath() + "/peliculas");
            return;
        }

        request.setAttribute("categorias", categoriaDAO.listar());
        request.setAttribute("peliculas", peliculaDAO.listar());
        request.getRequestDispatcher("registraPeliculas.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!sesionOK(request, response)) return;

        String idStr = request.getParameter("id_pelicula");
        String titulo = request.getParameter("titulo");
        String descripcion = request.getParameter("descripcion");
        String anioStr = request.getParameter("anio");
        String imagenUrl = request.getParameter("imagen_url");
        int idCategoria = Integer.parseInt(request.getParameter("id_categoria"));

        Integer anio = null;
        if (anioStr != null && !anioStr.trim().isEmpty()) {
            try { anio = Integer.parseInt(anioStr.trim()); } catch (Exception ignored) {}
        }

        Pelicula p = new Pelicula();
        p.setTitulo(titulo);
        p.setDescripcion(descripcion);
        p.setAnio(anio);
        p.setImagenUrl(imagenUrl);
        p.setIdCategoria(idCategoria);

        if (idStr == null || idStr.trim().isEmpty() || "0".equals(idStr.trim())) {
            peliculaDAO.insertar(p);
        } else {
            p.setIdPelicula(Integer.parseInt(idStr));
            peliculaDAO.actualizar(p);
        }

        response.sendRedirect(request.getContextPath() + "/peliculas");
    }
}
