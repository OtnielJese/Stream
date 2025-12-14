<%@page import="model.Usuario"%>
<%@page import="model.Usuario"%>
<%
    Usuario u = (Usuario) session.getAttribute("usuarioLogueado");
%>
<nav class="bg-black/80 border-b border-white/10 sticky top-0 z-50">
  <div class="max-w-6xl mx-auto px-4 py-3 flex items-center justify-between">
    <div class="flex items-center gap-3">
      <div class="w-8 h-8 rounded bg-red-600 flex items-center justify-center font-bold">C</div>
      <a class="text-white font-semibold" href="<%=request.getContextPath()%>/inicio">CIBERSTREAM</a>
    </div>

    <div class="flex items-center gap-3">
      <a class="text-sm text-white/80 hover:text-white" href="<%=request.getContextPath()%>/inicio">Inicio</a>
      <a class="text-sm text-white/80 hover:text-white" href="<%=request.getContextPath()%>/peliculas">Registro Películas</a>
      <span class="text-sm text-white/60 hidden sm:inline">|</span>
      <span class="text-sm text-white/80 hidden sm:inline">
        <%= (u!=null? u.getUsuario() : "") %>
        <span class="text-white/50">(<%= (u!=null? u.getRol() : "") %>)</span>
      </span>
      <a class="text-sm bg-white/10 hover:bg-white/20 text-white px-3 py-1 rounded"
         href="<%=request.getContextPath()%>/logout">Salir</a>
    </div>
  </div>
</nav>
