<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class ProductController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        $products = DB::connection('mysql')->select(
            'SELECT product.*, category.category_name FROM product
                    LEFT JOIN category
                    ON product.category_id = category.category_id
               '
        );
        $categories = DB::connection('mysql')->select(
            'SELECT * FROM category ORDER BY category_name ASC',
        );
        $array = array();
        $array['categories'] = $categories;
        $array['products'] = $products;

        return response()->json($array, 200);
    }

    public function product_by_category($category_id)
    {

        $products = DB::connection('mysql')->select(
            'SELECT product.*, category.category_name FROM product
                    LEFT JOIN category
                    ON product.category_id = category.category_id
                WHERE product.category_id = :category_id
               ',
            [
                'category_id' => $category_id
            ]
        );
        $categories = DB::connection('mysql')->select(
            'SELECT *FROM category ORDER BY (category_id <> :category_id) ASC,category_id; '
            ,
            [
                'category_id' => $category_id
            ]
        );
        $array = array();
        $array['categories'] = $categories;
        $array['products'] = $products;

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
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $request->validate([
            'category_id' => 'integer|required',
            'product_name' => 'string|required',
            'product_description' => 'string|nullable',
            'qty' => 'integer|required',
            'price' => 'numeric|required',
            'img_url' => 'image|required|max:3000'
        ]);

        //Handle file upload
        if ($request->file('img_url') != null) {
            // get filename with extension
            $fileNameWithExt = $request->file('img_url')->getClientOriginalName();

            //get just filename
            $filename = pathinfo($fileNameWithExt, PATHINFO_FILENAME);

            //get just extension
            $extension = $request->file('img_url')->getClientOriginalExtension();

            //filename to store
            $fileNamToStore = $filename . '_' . time() . '.' . $extension;

            //upload the image
            $path = $request->file('img_url')->storeAs('public/products', $fileNamToStore);

        } else {
            $fileNamToStore = 'noimage.jpg';
        }


        $saveData = DB::connection('mysql')->insert(
            '
                INSERT INTO product(
                    category_id,
                    product_name,
                    qty,
                    price,
                    product_description,
                    img_url
                    ) VALUES (
                    :category_id,
                    :product_name,
                    :qty,
                    :price,
                    :product_description,
                    :img_url
                    )
            ',
            [
                'category_id' => $request->category_id,
                'product_name' => $request->product_name,
                'qty' => $request->qty,
                'price' => $request->price,
                'product_description' => $request->product_description,
                'img_url' => $fileNamToStore
            ]
        );
        if ($saveData) {
            return response()->json(['isError' => false, 'message' => 'Product save successful'], 200);
        } else {
            return response()->json(['isError' => true, 'message' => 'Product save failed'], 201);
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
        //
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
            'category_id' => 'integer|required',
            'product_name' => 'string|required',
            'product_description' => 'string|nullable',
            'qty' => 'integer|required',
            'price' => 'numeric|required',
            'img_url' => 'image|required|max:3000'
        ]);

        $checkProduct = DB::connection('mysql')->select('SELECT * FROM product WHERE product_id =:product_id', ['product_id' => $id]);
        if (!empty($checkProduct)) {
            //Handle file upload
            if ($request->file('img_url') != null) {
                // get filename with extension
                $fileNameWithExt = $request->file('img_url')->getClientOriginalName();

                //get just filename
                $filename = pathinfo($fileNameWithExt, PATHINFO_FILENAME);

                //get just extension
                $extension = $request->file('img_url')->getClientOriginalExtension();

                //filename to store
                $fileNamToStore = $filename . '_' . time() . '.' . $extension;

                //upload the image
                $path = $request->file('img_url')->storeAs('public/products', $fileNamToStore);

                if ($checkProduct[0]->img_url != 'noimage.jpg') {
                    //delete image
                    Storage::delete('public/products/' . $checkProduct[0]->img_url);
                }

            } else {
                $fileNamToStore = $checkProduct[0]->img_url;
            }

            $saveData = DB::connection('mysql')->update(
                '
            UPDATE product
            SET
            img_url =:img_url,
            category_id  =:category_id,
            product_name  =:product_name,
            qty  =:qty,
            product_description  =:product_description,
            price  =:price
            WHERE product_id =:product_id
            ',
                [
                    'category_id' => $request->category_id,
                    'product_name' => $request->product_name,
                    'qty' => $request->qty,
                    'price' => $request->price,
                    'product_description' => $request->product_description,
                    'img_url' => $fileNamToStore,
                    'product_id' => $id
                ]
            );
            if ($saveData) {
                return response()->json(['isError' => false, 'message' => 'Product save successful'], 200);
            } else {
                return response()->json(['isError' => true, 'message' => 'Product save failed'], 201);
            }
        } else {
            return response()->json(['isError' => true, 'message' => 'Requested resource not found'], 201);
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
        $checkProduct = DB::connection('mysql')->select('SELECT * FROM product WHERE product_id =:product_id', ['product_id' => $id]);
        if (!empty($checkProduct)) {


            $delete = DB::connection('mysql')->delete('DELETE FROM product WHERE product_id=:product_id', ['product_id' => $id]);
            if ($delete) {
                if ($checkProduct[0]->img_url != 'noimage.jpg') {
                    //delete image
                    Storage::delete('public/products/' . $checkProduct[0]->img_url);
                }
                return response()->json(['isError' => false, 'message' => 'Product delete successful'], 200);
            } else {
                return response()->json(['isError' => true, 'message' => 'Product delete failed'], 201);
            }

        } else {
            return response()->json(['isError' => true, 'message' => 'Requested resource failed'], 201);
        }
    }
}
