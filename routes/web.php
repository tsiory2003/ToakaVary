<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use App\Models\Employe;

Route::get('/', function () {
    return redirect()->route('login');
});

Route::get('/login', function () {
    return view('auth.login');
})->name('login');

Route::post('/login', function (Request $request) {
    $credentials = $request->only('email', 'password');
    $user = User::where('email', $credentials['email'])->first();
    if ($user && Hash::check($credentials['password'], $user->password)) {
        session(['user_id' => $user->id]);
        return redirect('/dashboard');
    }
    return back()->withErrors(['email' => 'Identifiants invalides']);
});

Route::get('/signup', function () {
    $employes = Employe::whereDoesntHave('user')->get();
    return view('auth.signup', compact('employes'));
})->name('signup');

Route::post('/signup', function (Request $request) {
    $request->validate([
        'employe_id' => 'required|exists:employes,id',
        'email' => 'required|email|unique:users,email',
        'password' => 'required|string|min:6',
    ]);
    $employe = Employe::findOrFail($request->employe_id);
    $user = User::create([
        'name' => $employe->nom,
        'email' => $request->email,
        'password' => Hash::make($request->password),
        'employe_id' => $employe->id,
    ]);
    session(['user_id' => $user->id]);
    return redirect('/dashboard');
});

Route::get('/dashboard', function () {
    if (!session('user_id')) {
        return redirect()->route('login');
    }
    return view('dashboard');
})->name('dashboard');

Route::post('/logout', function () {
    session()->forget('user_id');
    return redirect()->route('login');
})->name('logout');
