<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('mouvement_employes', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('id_employe');
            $table->unsignedBigInteger('id_statut_employe');
            $table->dateTime('date_mouvement');
            $table->timestamps();
            $table->foreign('id_employe')->references('id')->on('employes')->onDelete('cascade');
            $table->foreign('id_statut_employe')->references('id')->on('statut_employes')->onDelete('cascade');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('mouvement_employes');
    }
}; 