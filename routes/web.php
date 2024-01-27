<?php

use App\Http\Controllers\BoardController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/{card?}', [BoardController::class, 'index'])->name('board');
Route::post('/board', [BoardController::class, 'storeList'])->name('board.list.store');
Route::get('/board/export', [BoardController::class, 'exportDB'])->name('export.db');
Route::delete('/board/list/{boardList}', [BoardController::class, 'destroyList'])->name('board.list.destroy');
Route::post('/card', [BoardController::class, 'storeCard'])->name('board.card.store');
Route::put('/card/{card}', [BoardController::class, 'updateCard'])->name('board.card.update');
Route::put('/card/{card}/move', [BoardController::class, 'moveCard'])->name('board.card.move');
Route::delete('/card/{card}', [BoardController::class, 'destroyCard'])->name('board.card.destroy');

require __DIR__.'/auth.php';
