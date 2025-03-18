<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class CategoryController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $category = DB::connection('mysql')->select(
            'SELECT * FROM category'
        );
        return response()->json($category, 200);
    }

    public function limited_categories()
    {
        $category = DB::connection('mysql')->select(
            'SELECT * FROM category ORDER BY RAND() LIMIT 10 '
        );
        return response()->json($category, 200);
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
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        // $request->validate([
        //     'category_name' => 'string|required|max:255',
        //     'category_description' => 'string|nullable|max:255'
        // ]);

        \Log::info('Store method called with data: ', $request->all());

        $validator = Validator::make($request->all(), [
            'category_name' => 'string|required|max:255',
            'category_icon.*' => 'image|nullable|max:1000',
            'category_description' => 'string|nullable'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'isError' => true,
                'message' => 'Validation error',
                'errors' => $validator->errors()
            ], 422);
        }

        //Handle category_icon photo file upload
        if ($request->file('category_icon') != null) {
            // get filename with extension
            $fileNameWithExt = $request->file('category_icon')->getClientOriginalName();

            //get just Ffilename
            $filename = pathinfo($fileNameWithExt, PATHINFO_FILENAME);

            //get just extension
            $extension = $request->file('category_icon')->getClientOriginalExtension();

            //filename to store
            $fileNamToStore = trim(str_replace(' ', '', $filename . '_' . substr($request->category_name, 0, 10) . '_' . time() . '.' . $extension));

            //upload the image
            $path = $request->file('category_icon')->storeAs('public/category_icon', $fileNamToStore);

        } else {
            $fileNamToStore = NULL;
        }

        $saveData = DB::connection('mysql')->insert(
            '
                INSERT INTO category(
                    category_name,
                    category_description,
                    category_icon
                    ) VALUES (
                    :category_name,
                    :category_description,
                    :category_icon
                    )
            ',
            [
                'category_name' => $request->category_name,
                'category_description' => $request->category_description,
                'category_icon' => $fileNamToStore
            ]
        );
        if ($saveData) {
            return response()->json(['isError' => false, 'message' => 'Category save successful'], 200);
        } else {
            return response()->json(['isError' => true, 'message' => 'Category save failed'], 201);
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
        $category = DB::connection('mysql')->select(
            'SELECT * FROM category WHERE category_id =:id ',
            ['id' => $id]
        );
        if (!empty($category)) {
            return response()->json($category[0], 200);
        } else {
            return response()->json($category, 200);

        }
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
        // $request->validate([
        //     'category_name' => 'string|required|max:255'
        // ]);

        $validator = Validator::make($request->all(), [
            'category_name' => 'string|required|max:255',
            'category_description' => 'string|nullable'
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
            UPDATE category 
            SET
            category_name =:category_name,
            category_description  =:category_description,
                
            WHERE category_id =:id
            ',
            [
                'category_name' => $request->category_name,
                'category_description' => $request->category_description,
                'id' => $id
            ]
        );
        if ($saveData) {
            return response()->json(['isError' => false, 'message' => 'Category update successful'], 200);
        } else {
            return response()->json(['isError' => true, 'message' => 'Category update failed'], 201);
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
        $delete = DB::connection('mysql')->delete('DELETE FROM category WHERE category_id=:id', ['id' => $id]);
        if ($delete) {
            return response()->json(['isError' => false, 'message' => 'Category delete successful'], 200);
        } else {
            return response()->json(['isError' => true, 'message' => 'Category delete failed'], 201);
        }
    }
}
