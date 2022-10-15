<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\Controller;

class AuthController extends Controller
{
    /**
     * Create a new AuthController instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth:api', ['except' => ['login']]);
    }

    /**
     * Get a JWT via given credentials.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function login()
    {
//        $credentials = request(['email', 'password']);

        //input validation
        if (!isset(request(['password'])['password']) && (!isset(request(['email'])['email']) || !isset(request(['phone'])['phone']))) {
            return response()->json(['isError' => true, 'message' => 'Both fields are required, please check input!'], 201);
        }

        if (!empty(request(['email'])['email'])) {
            $credentials = request(['email', 'password']);
        } else {
            $credentials = request(['phone', 'password']);
        }

//        echo '<pre>';
//        print_r($credentials);
//        echo '</pre>';
//        return;

        if (!$token = auth()->attempt($credentials)) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }
        $json = $this->respondWithToken($token)->getData();
        $user = $this->me()->getData();
        $access_token = $json->access_token;
        $result = array();
        $result['access_token'] = $access_token;
//        $result['username'] = $user->username;

        return $this->respondWithToken($token);
    }

    /**
     * Get the authenticated User.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function me()
    {
        return response()->json(auth()->user());
    }

    /**
     * Log the user out (Invalidate the token).
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function logout()
    {
        auth()->logout();

        return response()->json(['message' => 'Successfully logged out']);
    }

    /**
     * Refresh a token.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function refresh()
    {
        return $this->respondWithToken(auth()->refresh());
    }

    /**
     * Get the token array structure.
     *
     * @param string $token
     *
     * @return \Illuminate\Http\JsonResponse
     */
    protected function respondWithToken($token)
    {
        return response()->json([
            'access_token' => $token,
            'token_type' => 'bearer',
            'expires_in' => auth()->factory()->getTTL() * 60
        ]);
    }
}
