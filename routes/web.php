<?php

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

Route::get('/', function () {
    return view('welcome');
});
Route::prefix('product')->group(function () {
    Route::get('/', ['App\Http\Controllers\ProductController', 'index']);
    Route::get('/{id}', ['App\Http\Controllers\ProductController', 'show']);
    Route::get('product_by_category/{category_id}', ['App\Http\Controllers\ProductController', 'product_by_category']);
    Route::post('/', ['App\Http\Controllers\ProductController', 'store']);
    Route::put('/{id}', ['App\Http\Controllers\ProductController', 'update']);
    Route::delete('/{id}', ['App\Http\Controllers\ProductController', 'destroy']);

    //handle wishlist
    Route::prefix('wishlist')->group(function () {
        Route::get('get', ['App\Http\Controllers\ProductController', 'get_user_wishlist']);
        Route::post('add', ['App\Http\Controllers\ProductController', 'like_product']);
        Route::delete('remove/{id}', ['App\Http\Controllers\ProductController', 'unlike_product']);
    });


    //handle orders
    Route::prefix('order')->group(function () {
        Route::get('get', ['App\Http\Controllers\ProductController', 'get_user_orderlist']);
        Route::post('add', ['App\Http\Controllers\ProductController', 'user_add_products_order']);
    });

});