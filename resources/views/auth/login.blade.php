<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen">
    <div class="w-full max-w-md bg-white border-2 border-black rounded-lg shadow-md p-8">
        <h2 class="text-2xl font-bold mb-6 text-center text-black">Connexion</h2>
        <form method="POST" action="{{ route('login') }}">
            @csrf
            <div class="mb-4">
                <label class="block text-black mb-2" for="email">Email</label>
                <input class="w-full px-3 py-2 border-2 border-black rounded focus:outline-none focus:ring focus:border-black bg-white text-black" type="email" name="email" id="email" required autofocus>
            </div>
            <div class="mb-6">
                <label class="block text-black mb-2" for="password">Mot de passe</label>
                <input class="w-full px-3 py-2 border-2 border-black rounded focus:outline-none focus:ring focus:border-black bg-white text-black" type="password" name="password" id="password" required>
            </div>
            <button class="w-full bg-black text-white py-2 rounded border-2 border-black hover:bg-white hover:text-black transition" type="submit">Se connecter</button>
        </form>
        <p class="mt-4 text-center text-gray-600">Pas de compte ? <a href="{{ route('signup') }}" class="text-black hover:underline">Créer un compte</a></p>
    </div>
</body>
</html> 