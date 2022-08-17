<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

//Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//    return $request->user();
//});

Route::prefix('category')->group(function () {
    Route::get('/', ['App\Http\Controllers\CategoryController', 'index']);
    Route::get('/limited_categories', ['App\Http\Controllers\CategoryController', 'limited_categories']);
    Route::get('/{id}', ['App\Http\Controllers\CategoryController', 'show']);
    Route::post('/', ['App\Http\Controllers\CategoryController', 'store']);
    Route::put('/{id}', ['App\Http\Controllers\CategoryController', 'update']);
    Route::delete('/{id}', ['App\Http\Controllers\CategoryController', 'destroy']);
});

Route::prefix('product')->group(function () {
    Route::get('/', ['App\Http\Controllers\ProductController', 'index']);
    Route::get('/{id}', ['App\Http\Controllers\ProductController', 'show']);
    Route::get('product_by_category/{category_id}', ['App\Http\Controllers\ProductController', 'product_by_category']);
    Route::post('/', ['App\Http\Controllers\ProductController', 'store']);
    Route::put('/{id}', ['App\Http\Controllers\ProductController', 'update']);
    Route::delete('/{id}', ['App\Http\Controllers\ProductController', 'destroy']);
});
