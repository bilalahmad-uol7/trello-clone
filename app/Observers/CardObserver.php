<?php

namespace App\Observers;

use App\Models\Card;
use Illuminate\Support\Facades\DB;

class CardObserver
{
    /**
     * Handle the Card "creating" event.
     */
    public function creating(Card $card): void
    {
        $card->position = Card::where('board_list_id', $card->board_list_id)
            ->orderByDesc('position')
            ->first()?->position + Card::POSITION_GAP;
    }

    /**
     * Handle the Card "created" event.
     */
    public function created(Card $card): void
    {
        //
    }

    /**
     * Handle the Card "updated" event.
     */
    public function updated(Card $card): void
    {
        //
    }

    /**
     * Handle the Card "saved" event.
     */
    public function saved(Card $card): void
    {
        if ($card->position < Card::POSITION_MIN) {
            DB::statement('SET @previousPosition := 0');
            DB::statement('
                UPDATE cards
                SET position = (@previousPosition := @previousPosition + ?)
                WHERE card_list_id = ?
                ORDER BY position
            ', [
                Card::POSITION_GAP,
                $card->card_list_id,
            ]
            );
        }
    }

    /**
     * Handle the Card "deleted" event.
     */
    public function deleted(Card $card): void
    {
        //
    }

    /**
     * Handle the Card "restored" event.
     */
    public function restored(Card $card): void
    {
        //
    }

    /**
     * Handle the Card "force deleted" event.
     */
    public function forceDeleted(Card $card): void
    {
        //
    }
}
