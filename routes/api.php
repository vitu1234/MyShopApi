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

Route::prefix('homescreen')->group(function () {
    Route::get('/', ['App\Http\Controllers\HomeScreenController', 'index']);
});


Route::prefix('user')->group(function () {
    Route::get('/', ['App\Http\Controllers\UserController', 'index']);
    Route::get('/{id}', ['App\Http\Controllers\UserController', 'show']);
    Route::post('/', ['App\Http\Controllers\UserController', 'store']);
    Route::put('/{id}', ['App\Http\Controllers\UserController', 'update']);
    Route::put('/profile/{id}', ['App\Http\Controllers\UserController', 'remove_profile_picture']);
    Route::put('/verify_email_phone_code/{id}', ['App\Http\Controllers\UserController', 'verify_email_phone_code']);
    Route::delete('/{id}', ['App\Http\Controllers\UserController', 'destroy']);
});

Route::group([

    'middleware' => 'api',
    'prefix' => 'auth'

], function ($router) {

    Route::post('login', 'App\Http\Controllers\AuthController@login');
    Route::post('logout', 'App\Http\Controllers\AuthController@logout');
    Route::post('refresh', 'App\Http\Controllers\AuthController@refresh');
    Route::get('profile', 'App\Http\Controllers\AuthController@me');

});
