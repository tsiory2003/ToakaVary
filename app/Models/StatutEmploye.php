<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class StatutEmploye extends Model
{
    use HasFactory;

    protected $table = 'Statut_Employe';
    protected $fillable = ['nom'];
    public $timestamps = false;

    public function mouvements()
    {
        return $this->hasMany(MouvementEmploye::class, 'id_statut_employe');
    }
} 