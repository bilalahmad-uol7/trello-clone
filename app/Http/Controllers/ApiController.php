<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use App\Models\Card;
use Illuminate\Http\Request;
use App\Http\Resources\CardResource;
use Illuminate\Validation\ValidationException;

class ApiController extends Controller
{
    public function listCards(Request $request)
    {

        try{
            request()->validate([
                'access_token' => 'required|exists:personal_access_tokens,token',
            ]);
        }
        catch (ValidationException $th) {
            return $th->validator->errors();
        }

        $cards = Card::query();

        if ($request->has('date') && !empty($request->date)) {
            $cards->whereDate('created_at',Carbon::parse($request->date)->format('Y-m-d'));
        }

        if ($request->has('status') && $request->status != null && $request->status == 0) {
            $cards->onlyTrashed('deleted_at');
        } elseif($request->has('status') && $request->status != null && $request->status == 1)
        {
            $cards->whereNull('deleted_at');
        } else {
            $cards->withTrashed();
        }

        $cards = $cards->orderByDesc('id')->get();

        return response()->json([
            'status' => 'success',
            'data' => $cards,
        ]);
    }
}
