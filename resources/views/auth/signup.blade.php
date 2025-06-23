<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen">
    <div class="w-full max-w-md bg-white border-2 border-black rounded-lg shadow-md p-8">
        <h2 class="text-2xl font-bold mb-6 text-center text-black">Créer un compte</h2>
        <form method="POST" action="{{ route('signup') }}">
            @csrf
            <div class="mb-4">
                <label class="block text-black mb-2" for="employe_id">Employé</label>
                <select class="w-full px-3 py-2 border-2 border-black rounded focus:outline-none focus:ring focus:border-black bg-white text-black" name="employe_id" id="employe_id" required>
                    <option value="">Sélectionnez un employé</option>
                    @foreach(isset($employes) ? $employes : [] as $employe)
                        <option value="{{ $employe->id }}">{{ $employe->nom }} ({{ $employe->email }})</option>
                    @endforeach
                </select>
            </div>
            <div class="mb-4">
                <label class="block text-black mb-2" for="email">Email</label>
                <input class="w-full px-3 py-2 border-2 border-black rounded focus:outline-none focus:ring focus:border-black bg-white text-black" type="email" name="email" id="email" required>
            </div>
            <div class="mb-6">
                <label class="block text-black mb-2" for="password">Mot de passe</label>
                <input class="w-full px-3 py-2 border-2 border-black rounded focus:outline-none focus:ring focus:border-black bg-white text-black" type="password" name="password" id="password" required>
            </div>
            <button class="w-full bg-black text-white py-2 rounded border-2 border-black hover:bg-white hover:text-black transition" type="submit">S'inscrire</button>
        </form>
        <p class="mt-4 text-center text-gray-600">Déjà un compte ? <a href="{{ route('login') }}" class="text-black hover:underline">Se connecter</a></p>
    </div>
</body>
</html> 