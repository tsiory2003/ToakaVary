<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Employe extends Model
{
    use HasFactory;

    protected $table = 'employes';
    protected $fillable = [
        'nom', 'poste', 'email', 'telephone', 'id_departement'
    ];
    public $timestamps = false;

    public function departement()
    {
        return $this->belongsTo(Departement::class, 'id_departement');
    }

    public function mouvements()
    {
        return $this->hasMany(MouvementEmploye::class, 'id_employe');
    }

    public function user()
    {
        return $this->hasOne(User::class, 'employe_id');
    }
} 