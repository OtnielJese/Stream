<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login | Netflix Lite</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="min-h-screen bg-gradient-to-b from-black to-zinc-900 text-white">
  <div class="max-w-md mx-auto px-4 py-14">
    <div class="flex items-center gap-3 mb-6">
      <div class="w-10 h-10 rounded bg-red-600 flex items-center justify-center font-bold text-xl">N</div>
      <h1 class="text-2xl font-semibold">Netflix Lite</h1>
    </div>

    <div class="bg-white/5 border border-white/10 rounded-xl p-6">
      <h2 class="text-lg font-semibold mb-4">Iniciar sesión</h2>

      <%
          String msg = (String) request.getAttribute("mensaje");
          if (msg != null) {
      %>
        <div class="mb-4 bg-red-500/20 border border-red-500/40 text-red-100 px-3 py-2 rounded">
          <%= msg %>
        </div>
      <% } %>

      <form action="<%=request.getContextPath()%>/login" method="post" class="space-y-4">
        <div>
          <label class="block text-sm text-white/70 mb-1">Usuario</label>
          <input name="usuario" required
                 class="w-full px-3 py-2 rounded bg-black/40 border border-white/10 focus:outline-none focus:ring-2 focus:ring-red-600"
                 placeholder="admin" />
        </div>

        <div>
          <label class="block text-sm text-white/70 mb-1">Contraseña</label>
          <input type="password" name="password" required
                 class="w-full px-3 py-2 rounded bg-black/40 border border-white/10 focus:outline-none focus:ring-2 focus:ring-red-600"
                 placeholder="admin123" />
        </div>

        <button class="w-full bg-red-600 hover:bg-red-700 px-3 py-2 rounded font-semibold">
          Entrar
        </button>

        <p class="text-xs text-white/50">
          Demo: usuario <b>admin</b> / password <b>admin123</b>
        </p>
      </form>
    </div>
  </div>
</body>
</html>
