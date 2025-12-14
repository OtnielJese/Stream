<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="model.*"%>
<%
    if (session.getAttribute("usuarioLogueado") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Categoria> categorias = (List<Categoria>) request.getAttribute("categorias");
    List<Pelicula> peliculas = (List<Pelicula>) request.getAttribute("peliculas");
    Pelicula edit = (Pelicula) request.getAttribute("peliculaEdit");

    if (categorias == null) categorias = new ArrayList<>();
    if (peliculas == null) peliculas = new ArrayList<>();

    boolean modoEditar = (edit != null);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registro Películas | Netflix Lite</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="min-h-screen bg-zinc-950 text-white">
<jsp:include page="includes/navbar.jsp" />

<main class="max-w-6xl mx-auto px-4 py-8">
  <div class="flex items-end justify-between gap-4 flex-wrap">
    <div>
      <h1 class="text-2xl font-bold">Registrar Películas</h1>
      <p class="text-white/70 mt-1">Crear, editar y eliminar películas. Al crear, se debe asociar una categoría.</p>
    </div>
    <a href="<%=request.getContextPath()%>/peliculas"
       class="bg-white/10 hover:bg-white/20 px-4 py-2 rounded font-semibold">
       Refrescar lista
    </a>
  </div>

  <div class="mt-6 bg-white/5 border border-white/10 rounded-2xl p-6">
    <h2 class="text-lg font-semibold mb-4"><%= modoEditar ? "Editar película" : "Nueva película" %></h2>

    <form action="<%=request.getContextPath()%>/peliculas" method="post" class="grid grid-cols-1 md:grid-cols-2 gap-4">
      <input type="hidden" name="id_pelicula" value="<%= modoEditar ? edit.getIdPelicula() : 0 %>"/>

      <div>
        <label class="block text-sm text-white/70 mb-1">Título</label>
        <input name="titulo" required
               value="<%= modoEditar ? edit.getTitulo() : "" %>"
               class="w-full px-3 py-2 rounded bg-black/40 border border-white/10 focus:outline-none focus:ring-2 focus:ring-red-600"/>
      </div>

      <div>
        <label class="block text-sm text-white/70 mb-1">Categoría</label>
        <select name="id_categoria" required
                class="w-full px-3 py-2 rounded bg-black/40 border border-white/10 focus:outline-none focus:ring-2 focus:ring-red-600">
          <option value="">-- Seleccione --</option>
          <% for (Categoria c : categorias) { %>
            <option value="<%=c.getIdCategoria()%>"
              <%= (modoEditar && edit.getIdCategoria() == c.getIdCategoria()) ? "selected" : "" %>>
              <%=c.getNombre()%>
            </option>
          <% } %>
        </select>
      </div>

      <div class="md:col-span-2">
        <label class="block text-sm text-white/70 mb-1">Descripción</label>
        <textarea name="descripcion" required rows="3"
                  class="w-full px-3 py-2 rounded bg-black/40 border border-white/10 focus:outline-none focus:ring-2 focus:ring-red-600"><%= modoEditar ? edit.getDescripcion() : "" %></textarea>
      </div>

      <div>
        <label class="block text-sm text-white/70 mb-1">Año (opcional)</label>
        <input name="anio" type="number" min="1900" max="2100"
               value="<%= (modoEditar && edit.getAnio()!=null) ? edit.getAnio() : "" %>"
               class="w-full px-3 py-2 rounded bg-black/40 border border-white/10 focus:outline-none focus:ring-2 focus:ring-red-600"/>
      </div>

      <div>
        <label class="block text-sm text-white/70 mb-1">URL Imagen (opcional)</label>
        <input name="imagen_url"
               value="<%= modoEditar ? (edit.getImagenUrl()!=null?edit.getImagenUrl():"") : "" %>"
               class="w-full px-3 py-2 rounded bg-black/40 border border-white/10 focus:outline-none focus:ring-2 focus:ring-red-600"
               placeholder="https://..."/>
      </div>

      <div class="md:col-span-2 flex gap-3">
        <button class="bg-red-600 hover:bg-red-700 px-4 py-2 rounded font-semibold">
          <%= modoEditar ? "Actualizar" : "Guardar" %>
        </button>

        <% if (modoEditar) { %>
          <a href="<%=request.getContextPath()%>/peliculas"
             class="bg-white/10 hover:bg-white/20 px-4 py-2 rounded font-semibold">
            Cancelar
          </a>
        <% } %>
      </div>
    </form>
  </div>

  <div class="mt-8">
    <h2 class="text-lg font-semibold mb-3">Listado de películas</h2>

    <div class="overflow-x-auto bg-white/5 border border-white/10 rounded-2xl">
      <table class="w-full text-sm">
        <thead class="text-white/70">
          <tr class="border-b border-white/10">
            <th class="text-left p-3">ID</th>
            <th class="text-left p-3">Título</th>
            <th class="text-left p-3">Categoría</th>
            <th class="text-left p-3">Año</th>
            <th class="text-left p-3">Imagen</th>
            <th class="text-left p-3">Acciones</th>
          </tr>
        </thead>
        <tbody>
          <% if (peliculas.isEmpty()) { %>
            <tr>
              <td colspan="6" class="p-4 text-white/50">No hay películas registradas.</td>
            </tr>
          <% } %>

          <% for (Pelicula p : peliculas) { %>
            <tr class="border-b border-white/5 hover:bg-white/5">
              <td class="p-3"><%= p.getIdPelicula() %></td>
              <td class="p-3">
                <div class="font-semibold"><%= p.getTitulo() %></div>
                <div class="text-xs text-white/60"><%= p.getDescripcion() %></div>
              </td>
              <td class="p-3"><%= p.getNombreCategoria() %></td>
              <td class="p-3"><%= (p.getAnio()!=null? p.getAnio() : "") %></td>
              <td class="p-3">
                <% if (p.getImagenUrl() != null && !p.getImagenUrl().isEmpty()) { %>
                  <a class="text-red-300 hover:text-red-200 underline" target="_blank" href="<%=p.getImagenUrl()%>">ver</a>
                <% } else { %>
                  <span class="text-white/40">-</span>
                <% } %>
              </td>
              <td class="p-3">
                <div class="flex gap-2">
                  <a class="bg-white/10 hover:bg-white/20 px-3 py-1 rounded"
                     href="<%=request.getContextPath()%>/peliculas?accion=editar&id=<%=p.getIdPelicula()%>">Editar</a>

                  <a class="bg-red-600/80 hover:bg-red-600 px-3 py-1 rounded"
                     href="<%=request.getContextPath()%>/peliculas?accion=eliminar&id=<%=p.getIdPelicula()%>"
                     onclick="return confirm('¿Eliminar película?');">Eliminar</a>
                </div>
              </td>
            </tr>
          <% } %>
        </tbody>
      </table>
    </div>
  </div>
</main>

<jsp:include page="includes/footer.jsp" />
</body>
</html>
