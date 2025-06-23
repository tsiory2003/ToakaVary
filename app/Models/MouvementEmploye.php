<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MouvementEmploye extends Model
{
    use HasFactory;

    protected $table = 'Mouvement_Employe';
    protected $fillable = [
        'id_employe', 'id_statut_employe', 'date_mouvement'
    ];
    public $timestamps = false;

    public function employe()
    {
        return $this->belongsTo(Employe::class, 'id_employe');
    }

    public function statut()
    {
        return $this->belongsTo(StatutEmploye::class, 'id_statut_employe');
    }
} 