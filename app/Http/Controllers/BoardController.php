<?php

namespace App\Http\Controllers;

use App\Models\BoardList;
use App\Models\Card;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Spatie\DbDumper\Databases\MySql;

class BoardController extends Controller
{
    /**
     * index function
     *
     * @param Card|null $card
     * @return \Inertia\Response
     */
    public function index(?Card $card = null): \Inertia\Response
    {
        $lists = BoardList::with(['cards' => function ($qry) {
            $qry->orderBy('position');
        }])->get();

        return Inertia::render('Board', [
            'lists' => $lists,
            'card' => $card,
        ]);
    }

    /**
     * store List function
     *
     * @param Request $request
     * @return \Illuminate\Http\RedirectResponse
     */
    public function storeList(Request $request): \Illuminate\Http\RedirectResponse
    {

        $request->validate([
            'title' => 'required',
        ]);

        $list = BoardList::create([
            'title' => $request->title,
        ]);

        return redirect()->back();
    }

    /**
     * store Card function
     *
     * @param Request $request
     * @return \Illuminate\Http\RedirectResponse
     */
    public function storeCard(Request $request): \Illuminate\Http\RedirectResponse
    {

        $request->validate([
            'title' => 'required',
            'description' => 'nullable',
            'board_list_id' => 'required|exists:board_lists,id',
        ]);

        $list = BoardList::find($request->board_list_id);

        $list->cards()->create([
            'title' => $request->title,
            'description' => $request->description ?? null,
        ]);

        return redirect()->back();
    }

    /**
     * update Card function
     *
     * @param Request $request
     * @param Card $card
     * @return \Illuminate\Http\RedirectResponse
     */
    public function updateCard(Request $request, Card $card): \Illuminate\Http\RedirectResponse
    {

        $request->validate([
            'title' => 'required',
            'description' => 'nullable',
        ]);

        $card->update([
            'title' => $request->title,
            'description' => $request->description ?? null,
        ]);

        if ($request->has('redirectUrl')) {
            return redirect($request->redirectUrl);
        }

        return redirect()->back();
    }

    /**
     * move Card function
     *
     * @param Request $request
     * @param Card $card
     * @return \Illuminate\Http\RedirectResponse
     */
    public function moveCard(Request $request, Card $card): \Illuminate\Http\RedirectResponse
    {
        $request->validate([
            'boardListId' => ['required', 'exists:board_lists,id'],
            'position' => ['required', 'numeric'],
        ]);

        $card->update([
            'board_list_id' => $request->get('boardListId'),
            'position' => round($request->get('position'), 5),
        ]);

        return redirect()->back();
    }

    /**
     * destroy List function
     *
     * @param BoardList $boardList
     * @return \Illuminate\Http\RedirectResponse
     */
    public function destroyList(BoardList $boardList): \Illuminate\Http\RedirectResponse
    {
        $boardList->cards()->delete();

        $boardList->delete();

        return redirect('/');
    }

    /**
     * destroy Card function
     *
     * @param Card $card
     * @return \Illuminate\Http\RedirectResponse
     */
    public function destroyCard(Card $card): \Illuminate\Http\RedirectResponse
    {
        $card->delete();

        return redirect('/');
    }

    /**
     * export DB function
     *
     * @return void
     */
    public function exportDB(): void
    {
        MySql::create()
            ->setDumpBinaryPath(env('MYSQL_DUMP_PATH', null))
            ->setDbName(env('DB_DATABASE', null))
            ->setUserName(env('DB_USERNAME', null))
            ->setPassword(env('DB_PASSWORD', null))
            ->dumpToFile('dump.sql');
    }
}
