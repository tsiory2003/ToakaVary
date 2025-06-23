<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('departements', function (Blueprint $table) {
            $table->id();
            $table->string('nom')->unique();
            $table->text('description')->nullable();
        });

        Schema::create('employes', function (Blueprint $table) {
            $table->id();
            $table->string('nom');
            $table->string('poste');
            $table->string('email')->unique();
            $table->string('telephone')->nullable();
            $table->unsignedBigInteger('id_departement');
            $table->foreign('id_departement')->references('id')->on('departements');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('employes');
        Schema::dropIfExists('departements');
    }
}; 