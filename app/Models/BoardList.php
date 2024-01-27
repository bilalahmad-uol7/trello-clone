<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class BoardList extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'title',
    ];

    public function cards(): HasMany
    {
        return $this->hasMany(
            Card::class,
            'board_list_id',
            'id'
        );
    }
}
