<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class SubCategoryController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $sub_category = DB::connection('mysql')->select(
            'SELECT sub_category.*, category.category_name FROM sub_category INNER JOIN category ON sub_category.category_id = category.category_id'
        );
        return response()->json($sub_category, 200);
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
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'category_id' => 'integer|required',
            'sub_category_name' => 'string|required|max:255',
            'sub_category_description' => 'string|nullable'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'isError' => true,
                'message' => 'Validation error',
                'errors' => $validator->errors()
            ], 422);
        }

        $saveData = DB::connection('mysql')->insert(
            '
                INSERT INTO sub_category(
                    category_id,
                    sub_category_name,
                    sub_category_description
                    ) VALUES (
                    :category_id,
                    :sub_category_name,
                    :sub_category_description
                    )
            ',
            [
                'category_id' => $request->category_id,
                'sub_category_name' => $request->sub_category_name,
                'sub_category_description' => $request->sub_category_description
            ]
        );
        if ($saveData) {
            return response()->json(['isError' => false, 'message' => 'SubCategory save successful'], 200);
        } else {
            return response()->json(['isError' => true, 'message' => 'SubCategory save failed'], 201);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $sub_category = DB::connection('mysql')->select(
            'SELECT sub_category.*, category.category_name FROM sub_category INNER JOIN category ON sub_category.category.id = category.category.id WHERE sub_category_id =:id ', ['id' => $id]
        );
        if (!empty($category)) {
            return response()->json($category[0], 200);
        } else {
            return response()->json($sub_category, 200);

        }
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'category_id' => 'integer|required',
            'sub_category_name' => 'string|required|max:255',
            'sub_category_description' => 'string|nullable'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'isError' => true,
                'message' => 'Validation error',
                'errors' => $validator->errors()
            ], 422);
        }

        $saveData = DB::connection('mysql')->update(
            '
            UPDATE sub_category 
            SET
            category_id =:category_id,
            sub_category_name =:sub_category_name,
            sub_category_description  =:sub_category_description,
                
            WHERE sub_category_id =:id
            ',
            [
                'category_id' => $request->category_id,
                'sub_category_name' => $request->sub_category_name,
                'sub_category_description' => $request->sub_category_description,
                'id' => $id
            ]
        );
        if ($saveData) {
            return response()->json(['isError' => false, 'message' => 'SubCategory update successful'], 200);
        } else {
            return response()->json(['isError' => true, 'message' => 'SubCategory update failed'], 201);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $delete = DB::connection('mysql')->delete('DELETE FROM sub_category WHERE sub_category_id=:id', ['id' => $id]);
        if ($delete) {
            return response()->json(['isError' => false, 'message' => 'SubCategory delete successful'], 200);
        } else {
            return response()->json(['isError' => true, 'message' => 'SubCategory delete failed'], 201);
        }
    }
}
