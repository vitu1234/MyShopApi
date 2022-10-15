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

        if (!$token = auth()->attempt($credentials)) {
            return response()->json(['isError' => true, 'message' => "Wrong username or password!"], 401);
        }
        $json = $this->respondWithToken($token)->getData();
        $user = $this->me()->getData();
        $access_token = $json->access_token;
        $result = array();

        $result['access_token'] = $access_token;
        $result['user_id'] = $user->user_id;
        $result['first_name'] = $user->first_name;
        $result['last_name'] = $user->last_name;
        $result['phone'] = $user->phone;
        $result['email'] = $user->email;
        $result['profile_img'] = $user->profile_img;
        $result['is_active'] = $user->is_active;
        $result['is_verified'] = $user->is_verified;

        if ($user->is_active != 1) {
            return response()->json(['isError' => true, 'message' => "Your account is in an inactive state, contact admin!"], 201);
        }

        if ($user->is_verified != 1) {
            return response()->json(['isError' => true, 'message' => "Verify your account first to proceed, if message persists, contact admin !"], 201);
        }

        return response()->json(['isError' => false, 'message' => "Login successful!", "user_data" => $result], 200);


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
