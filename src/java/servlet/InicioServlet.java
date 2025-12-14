package servlet;

import dao.CategoriaDAO;
import dao.PeliculaDAO;
import impl.CategoriaDAOImpl;
import impl.PeliculaDAOImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/inicio")
public class InicioServlet extends HttpServlet {

    private final CategoriaDAO categoriaDAO = new CategoriaDAOImpl();
    private final PeliculaDAO peliculaDAO = new PeliculaDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

       // HttpSession s = request.getSession(false);
        //if (s == null || s.getAttribute("usuarioLogueado") == null) {
        //    response.sendRedirect(request.getContextPath() + "/login.jsp");
        //    return;
        //}

        request.setAttribute("categorias", categoriaDAO.listar());
        request.setAttribute("peliculas", peliculaDAO.listar());

        request.getRequestDispatcher("inicio.jsp").forward(request, response);
    }
}
