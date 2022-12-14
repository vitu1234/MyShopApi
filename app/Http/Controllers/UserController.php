<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Storage;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        $users = DB::connection('mysql')->select(
            'SELECT * FROM user ORDER BY last_name ASC',
        );
        $array = array();
        $array['users'] = $users;

        return response()->json($array, 200);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request)
    {
        $request->validate([
            'first_name' => 'string|required',
            'last_name' => 'string|required',
            'phone' => 'string|required',
            'email' => 'string|nullable',
            'password' => 'string|required',
            'is_admin' => 'integer|nullable',
            'profile_img' => 'image|nullable|max:3000'
        ]);


        //CHECK EMAIL OR PHONE HERE
        $checkUser = DB::connection('mysql')->select('
            SELECT * FROM user
            WHERE
            phone =:phone
            OR email =:email
                     ',
            [
                'phone' => $request->phone,
                'email' => $request->email
            ]);
        if (empty($checkUser)) {
            $is_admin = ($request->is_admin == null) ? 0 : 1;
            $password = app('hash')->make($request->password);

//        echo $is_admin;return;

            //Handle file upload
            if ($request->file('profile_img') != null) {
                // get filename with extension
                $fileNameWithExt = $request->file('profile_img')->getClientOriginalName();

                //get just filename
                $filename = pathinfo($fileNameWithExt, PATHINFO_FILENAME);

                //get just extension
                $extension = $request->file('profile_img')->getClientOriginalExtension();

                //filename to store
                $fileNamToStore = $filename . '_' . time() . '.' . $extension;

                //upload the image
                $path = $request->file('profile_img')->storeAs('public/users', $fileNamToStore);

            } else {
                $fileNamToStore = 'noimage.jpg';
            }

            $saveData = DB::connection('mysql')->insert(
                '
                INSERT INTO user(
                     	first_name,
                        last_name,
                        phone,
                        email,
                        password,
                        is_admin,
                        profile_img
                    ) VALUES (
                        :first_name,
                        :last_name,
                        :phone,
                        :email,
                        :password,
                        :is_admin,
                        :profile_img
                    )
            ',
                [
                    'first_name' => $request->first_name,
                    'last_name' => $request->last_name,
                    'phone' => $request->phone,
                    'email' => $request->email,
                    'password' => $password,
                    'is_admin' => $is_admin,
                    'profile_img' => $fileNamToStore
                ]
            );
            if ($saveData) {
                $code = rand(1000, 9999);
                $checkUser = DB::connection('mysql')->select('
            SELECT * FROM user
            WHERE
            phone =:phone
            OR email =:email
                     ',
                    [
                        'phone' => $request->phone,
                        'email' => $request->email
                    ]);
                $user_id = $checkUser[0]->user_id;
                $expires_at = date("Y-m-d H:i:s", strtotime('+24 hours'));
                DB::connection('mysql')->insert(
                    '
                INSERT INTO user_account_verification(
                     	user_id,
                        code,
                        expires_at
                    ) VALUES (
                        :user_id,
                        :code,
                        :expires_at
                    )
            ',
                    [
                        'user_id' => $user_id,
                        'code' => $code,
                        'expires_at' => $expires_at
                    ]
                );

                if ($request->email != null) {

                    $details = [
                        'code' => $code,
                    ];

                    Mail::to($request->email)->send(new \App\Mail\MailConfig($details));
                }

                return response()->json(['isError' => false, 'message' => 'Account created, we sent you a code to verify your account'], 200);
            } else {
                return response()->json(['isError' => true, 'message' => 'Failed creating user profile'], 201);
            }
        } else {
            return response()->json(['isError' => true, 'message' => 'Failed creating user profile, phone or email is already taken'], 201);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $user = DB::connection('mysql')->select(
            'SELECT * FROM user WHERE user_id =:user_id',
            [
                'user_id' => $id
            ],
        );

        return response()->json($user[0], 200);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $request->validate([
            'first_name' => 'string|required',
            'last_name' => 'string|required',
            'phone' => 'string|required',
            'email' => 'string|nullable',
            'password' => 'string|required',
            'is_admin' => 'integer|nullable',
            'is_active' => 'integer|nullable',
            'profile_img' => 'image|nullable|max:3000'
        ]);
        $password = ($request->password != null) ? app('hash')->make($request->password) : '';

        $checkUser = DB::connection('mysql')->select('SELECT * FROM user WHERE user_id =:user_id', ['user_id' => $id]);
        if (!empty($checkUser)) {
            //Handle file upload
            if ($request->file('profile_img') != null) {
                // get filename with extension
                $fileNameWithExt = $request->file('profile_img')->getClientOriginalName();

                //get just filename
                $filename = pathinfo($fileNameWithExt, PATHINFO_FILENAME);

                //get just extension
                $extension = $request->file('profile_img')->getClientOriginalExtension();

                //filename to store
                $fileNamToStore = $filename . '_' . time() . '.' . $extension;

                //upload the image
                $path = $request->file('profile_img')->storeAs('public/users', $fileNamToStore);

                if ($checkUser[0]->profile_img != 'noimage.jpg') {
                    //delete image
                    Storage::delete('public/users/' . $checkUser[0]->profile_img);
                }

            } else {
                $fileNamToStore = $checkUser[0]->profile_img;
            }

            $saveData = ($request->password != null) ? DB::connection('mysql')->update(
                '
            UPDATE user
            SET
            first_name=:first_name,
             last_name=:last_name,
             phone=:phone,
             email=:email,
             password=:password,
             is_active=:is_active,
             is_admin=:is_admin,
             profile_img=:profile_img
            WHERE user_id =:user_id
            ',
                [
                    'first_name' => $request->first_name,
                    'last_name' => $request->last_name,
                    'phone' => $request->phone,
                    'email' => $request->email,
                    'password' => $password,
                    'is_active' => $request->is_active,
                    'is_admin' => $request->is_admin,
                    'profile_img' => $fileNamToStore,
                    'user_id' => $id
                ]
            ) : DB::connection('mysql')->update(
                '
            UPDATE user
            SET
            first_name=:first_name,
             last_name=:last_name,
             phone=:phone,
             email=:email,
             is_active=:is_active,
             is_admin=:is_admin,
             profile_img=:profile_img
            WHERE user_id =:user_id
            ',
                [
                    'first_name' => $request->first_name,
                    'last_name' => $request->last_name,
                    'phone' => $request->phone,
                    'email' => $request->email,
                    'is_admin' => $request->is_admin,
                    'is_active' => $request->is_active,
                    'profile_img' => $fileNamToStore,
                    'user_id' => $id
                ]
            );
            if ($saveData) {
                return response()->json(['isError' => false, 'message' => 'User profile updated'], 200);
            } else {
                return response()->json(['isError' => true, 'message' => 'Updating user profile failed'], 201);
            }
        } else {
            return response()->json(['isError' => true, 'message' => 'Requested resource not found'], 201);
        }
    }

    public function verify_email_phone_code(Request $request)
    {
        $request->validate([
            'code' => 'integer|required',
            'email' => 'string|nullable',
            'phone' => 'string|required',
        ]);

        $checkUser = DB::connection('mysql')->select('
            SELECT * FROM user
            WHERE
            phone =:phone
            OR email =:email
                     ',
            [
                'phone' => $request->phone,
                'email' => $request->email
            ]);
        if (!empty($checkUser)) {
            $id = $checkUser[0]->user_id;
            $is_verified = $checkUser[0]->is_verified;
            if (!$is_verified) {
                $checkCode = DB::connection('mysql')->select('SELECT * FROM user_account_verification WHERE user_id =:user_id', ['user_id' => $id]);
                if (!empty($checkCode)) {
                    if ($checkCode[0]->code == $request->code) {

                        $expiry = strtotime($checkCode[0]->expires_at);
                        $date_now = strtotime(date("Y-m-d H:i:s"));
                        if ($expiry >= $date_now) {
                            $saveData = DB::connection('mysql')->update(
                                '
                                UPDATE user
                                SET
                                is_verified=:is_verified
                                WHERE user_id =:user_id
                                ',
                                [
                                    'is_verified' => 1,
                                    'user_id' => $id
                                ]
                            );
                            if ($saveData) {
                                DB::connection('mysql')->delete('DELETE FROM user_account_verification WHERE user_id=:user_id', ['user_id' => $id]);
                                return response()->json(['isError' => false, 'message' => 'Your account has been verified!'], 200);
                            } else {
                                return response()->json(['isError' => true, 'message' => 'Verification failed, please try again later!'], 201);
                            }
                        } else {
                            return response()->json(['isError' => true, 'message' => 'Verification failed, the code you entered has expired!'], 201);
                        }

                    } else {
                        return response()->json(['isError' => true, 'message' => 'Verification failed, please enter the correct code!'], 201);
                    }

                } else {
                    return response()->json(['isError' => true, 'message' => 'Failed to verify your email, please click on resend verification code to resend!'], 201);
                }
            } else {
                return response()->json(['isError' => true, 'message' => 'Oops! it seems like you are already verified, please login to continue!'], 201);
            }

        } else {
            return response()->json(['isError' => true, 'message' => 'Requested resource or user not found'], 201);
        }
    }


    /**
     * Remove the specified resource from storage.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $checkUser = DB::connection('mysql')->select('SELECT * FROM user WHERE user_id =:user_id', ['user_id' => $id]);
        if (!empty($checkUser)) {


            $delete = DB::connection('mysql')->delete('DELETE FROM user WHERE user_id=:user_id', ['user_id' => $id]);
            if ($delete) {
                if ($checkUser[0]->profile_img != 'noimage.jpg') {
                    //delete image
                    Storage::delete('public/users/' . $checkUser[0]->profile_img);
                }
                return response()->json(['isError' => false, 'message' => 'User account deleted'], 200);
            } else {
                return response()->json(['isError' => true, 'message' => 'Failed deleting user account'], 201);
            }

        } else {
            return response()->json(['isError' => true, 'message' => 'Requested resource failed'], 201);
        }
    }

    public function remove_profile_picture($id)
    {
        $checkUser = DB::connection('mysql')->select('SELECT * FROM user WHERE user_id =:user_id', ['user_id' => $id]);
        if (!empty($checkUser)) {


            $remove = DB::connection('mysql')->update(
                '
            UPDATE user
            SET
             profile_img=:profile_img
            WHERE user_id =:user_id
            ',
                [
                    'profile_img' => "noimage.jpg",
                    'user_id' => $id
                ]
            );
            if ($remove) {
                if ($checkUser[0]->profile_img != 'noimage.jpg') {
                    //delete image
                    Storage::delete('public/users/' . $checkUser[0]->profile_img);
                }
                return response()->json(['isError' => false, 'message' => 'Profile picture removed'], 200);
            } else {
                return response()->json(['isError' => true, 'message' => 'Failed profile picture'], 201);
            }

        } else {
            return response()->json(['isError' => true, 'message' => 'Requested resource failed'], 201);
        }
    }


}
