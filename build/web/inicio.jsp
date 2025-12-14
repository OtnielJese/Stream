<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="model.Categoria"%>
<%@page import="model.Pelicula"%>

<%
  List<Categoria> categorias = (List<Categoria>) request.getAttribute("categorias");
  List<Pelicula> peliculas = (List<Pelicula>) request.getAttribute("peliculas");
  if (categorias == null) categorias = new ArrayList<>();
  if (peliculas == null) peliculas = new ArrayList<>();

  // agrupar películas por id_categoria
  Map<Integer, List<Pelicula>> porCategoria = new HashMap<>();
  for (Pelicula p : peliculas) {
    porCategoria.computeIfAbsent(p.getIdCategoria(), k -> new ArrayList<>()).add(p);
  }
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Inicio</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="min-h-screen bg-zinc-950 text-white">
  <jsp:include page="includes/navbar.jsp" />

  <!-- HERO -->
<!-- HERO con imagen de fondo -->
<section class="relative">
  <div class="relative max-w-6xl mx-auto px-4 pt-8 pb-8">

    <div class="relative overflow-hidden rounded-2xl border border-white/10 bg-black/40 backdrop-blur p-6">

      <!-- IMAGEN DE FONDO (dentro del card) -->
      <div class="absolute inset-0 bg-center bg-cover opacity-30"
           style="background-image:url('https://p4.wallpaperbetter.com/wallpaper/916/339/783/movies-2560x1440-batman-cover-wallpaper-preview.jpg');">
      </div>

      <!-- OSCURECER + GRADIENTE para que el texto se lea -->
      <div class="absolute inset-0 bg-gradient-to-r from-black/80 via-black/50 to-transparent"></div>

      <!-- CONTENIDO -->
      <div class="relative">
        <h1 class="text-3xl md:text-4xl font-bold">Bienvenido a CIBERSTREAM</h1>

        <div class="mt-4 flex gap-2">
          <!-- <a class="px-4 py-2 rounded-lg bg-red-600 hover:bg-red-500 font-semibold"
             href="<%=request.getContextPath()%>/registraPeliculas.jsp">Administrar Películas</a>

          <a class="px-4 py-2 rounded-lg bg-white/10 hover:bg-white/15"
             href="<%=request.getContextPath()%>/logout">Salir</a> -->
        </div>
      </div>

    </div>
  </div>
</section>


  <!-- FILAS POR CATEGORÍA -->
  <main class="max-w-6xl mx-auto px-4 pb-12">
    <% if (categorias.isEmpty()) { %>
      <div class="mt-6 p-4 rounded-lg bg-white/5 border border-white/10 text-white/80">
        No hay categorías cargadas.
      </div>
    <% } %>

    <% for (Categoria c : categorias) {
         List<Pelicula> lista = porCategoria.getOrDefault(c.getIdCategoria(), new ArrayList<>());
         if (lista.isEmpty()) continue;
    %>

      <section class="mt-8">
        <div class="flex items-end justify-between">
          <h2 class="text-xl font-bold"><%=c.getNombre()%></h2>
          <span class="text-sm text-white/60"><%=lista.size()%> títulos</span>
        </div>

        <!-- carrusel horizontal -->
<!-- carrusel horizontal estilo Netflix -->
<div class="mt-3 flex flex-nowrap gap-4 overflow-x-auto pb-4">
  <% for (Pelicula p : lista) {
       String img = p.getImagenUrl();
       if (img == null || img.trim().isEmpty()) img = "https://placehold.co/600x900?text=Sin+Imagen";
  %>

    <a href="#" class="group block shrink-0">
      <div class="relative rounded-lg overflow-hidden bg-white/5 border border-white/10
                  w-[180px] md:w-[220px] lg:w-[260px]">
        <img
          src="<%=img%>"
          alt="<%=p.getTitulo()%>"
          class="w-full aspect-[2/3] object-cover group-hover:scale-105 transition duration-300"
        />

        <div class="absolute inset-0 bg-gradient-to-t from-black/80 via-black/10 to-transparent"></div>

        <div class="absolute bottom-0 left-0 right-0 p-3">
          <div class="font-semibold text-sm md:text-base leading-tight line-clamp-2">
            <%=p.getTitulo()%>
          </div>
          <div class="text-xs text-white/70">
            <%= (p.getAnio() == null ? "" : p.getAnio()) %>
          </div>
        </div>
      </div>

      <p class="mt-2 text-xs md:text-sm text-white/70 line-clamp-2 max-w-[260px]">
        <%=p.getDescripcion()%>
      </p>
    </a>

  <% } %>
</div>

      </section>

    <% } %>
  </main>

  <jsp:include page="includes/footer.jsp" />
</body>
</html>
