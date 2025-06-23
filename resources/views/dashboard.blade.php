<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 text-black min-h-screen">
    <div class="flex min-h-screen">
        <!-- Sidebar -->
        <aside class="w-64 bg-white border-r-2 border-black flex flex-col py-8 px-4 shadow-lg">
            <div class="mb-8 flex items-center justify-center">
                <span class="text-2xl font-bold tracking-wide text-black">ToakaVary</span>
            </div>
            <nav class="flex-1">
                <ul class="space-y-4">
                    <li><a href="#" class="block py-2 px-4 rounded border-2 border-black hover:bg-black hover:text-white transition">Dashboard</a></li>
                    <li><a href="#" class="block py-2 px-4 rounded border-2 border-black hover:bg-black hover:text-white transition">Employés</a></li>
                    <li><a href="#" class="block py-2 px-4 rounded border-2 border-black hover:bg-black hover:text-white transition">Départements</a></li>
                    <li><a href="#" class="block py-2 px-4 rounded border-2 border-black hover:bg-black hover:text-white transition">Statuts</a></li>
                    <li><a href="#" class="block py-2 px-4 rounded border-2 border-black hover:bg-black hover:text-white transition">Mouvements</a></li>
                </ul>
            </nav>
            <form method="POST" action="{{ route('logout') }}" class="mt-8">
                @csrf
                <button class="w-full bg-black text-white py-2 rounded border-2 border-black hover:bg-white hover:text-black transition" type="submit">Déconnexion</button>
            </form>
        </aside>
        <!-- Main content -->
        <main class="flex-1 p-10 bg-white">
            <h1 class="text-3xl font-bold mb-6 text-black">Bienvenue sur le Dashboard</h1>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <div class="bg-white border-2 border-black rounded-lg p-6 shadow">
                    <h2 class="text-xl font-semibold mb-2 text-black">Employés</h2>
                    <p class="text-gray-700">Gestion des employés et de leurs statuts.</p>
                </div>
                <div class="bg-white border-2 border-black rounded-lg p-6 shadow">
                    <h2 class="text-xl font-semibold mb-2 text-black">Départements</h2>
                    <p class="text-gray-700">Organisation par département.</p>
                </div>
                <div class="bg-white border-2 border-black rounded-lg p-6 shadow">
                    <h2 class="text-xl font-semibold mb-2 text-black">Mouvements</h2>
                    <p class="text-gray-700">Historique des mouvements d'employés.</p>
                </div>
            </div>
        </main>
    </div>
</body>
</html> 