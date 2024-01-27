<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

class Card extends Model
{
    use HasFactory, SoftDeletes;

    const POSITION_GAP = 60000;

    const POSITION_MIN = 0.2;

    protected $fillable = [
        'title',
        'description',
        'board_list_id',
        'position',
    ];

    public function boardList(): BelongsTo
    {
        return $this->belongsTo(
            BoardList::class,
            'board_list_id',
            'id',
            'boardList',
        );
    }
}
