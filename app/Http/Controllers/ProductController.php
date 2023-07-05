<?php

namespace App\Http\Controllers;

use App\Http\Controllers\AuthController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;


class ProductController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:api', ['except' => ['index', 'product_by_category',]]);
    }

    //===============================================
    //=============PRODUCT===========================
    //===============================================
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        $products = DB::connection('mysql')->select(
            'SELECT product.*, category.category_name,
                    (SELECT COUNT(*) FROM product_like WHERE product_like.product_id = product.product_id) AS likes
                    FROM product
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
            'SELECT product.*, category.category_name
                    (SELECT COUNT(*) FROM product_like WHERE product_like.product_id = product.product_id) AS likes
                    FROM product
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


    //===============================================
    //=============PRODUCT LIKES=====================
    //===============================================
    //products liked by user
    public function get_user_wishlist()
    {
        $auth_instance = new AuthController();
        $user = $auth_instance->me()->getData()->user_data;
        $user_id = $user->user_id;

        $wishlist_products = DB::connection('mysql')->select(
            '
            SELECT
                product_like.prod_like_id,
                product_like.user_id,
                product.*,
                category.category_name
              FROM product_like
            LEFT JOIN product
                ON product_like.product_id = product.product_id
            LEFT JOIN category
                ON product.category_id = category.category_id
            WHERE user_id = :user_id',
            [
                'user_id' => $user_id
            ]
        );

        $array = array();
        $array['wishlist_products'] = $wishlist_products;

        return response()->json($array, 200);
    }

    //like a product | add product to wishlist
    public function like_product(Request $request)
    {
        $request->validate([
//            'user_id' => 'integer|required',
            'product_id' => 'integer|required',
        ]);
        $auth_instance = new AuthController();
        $user = $auth_instance->me()->getData()->user_data;
        $user_id = $user->user_id;

        $saveData = DB::connection('mysql')->insert(
            '
                INSERT INTO product_like(
                    user_id,
                    product_id
                    ) VALUES (
                    :user_id,
                    :product_id
                    )
            ',
            [
                'user_id' => $user_id,
                'product_id' => $request->product_id
            ]
        );
        if ($saveData) {
            return response()->json(['isError' => false, 'message' => 'Product added to WishList'], 200);
        } else {
            return response()->json(['isError' => true, 'message' => 'Failed to add product to WishList'], 201);
        }
    }

    //unlike a product | remove product from wishlist
    public function unlike_product($prod_like_id)
    {


        $saveData = DB::connection('mysql')->insert(
            '
                DELETE FROM product_like where prod_like_id =:prod_like_id
            ',
            [
                'prod_like_id' => $prod_like_id
            ]
        );
        if ($saveData) {
            return response()->json(['isError' => false, 'message' => 'Product remove from WishList'], 200);
        } else {
            return response()->json(['isError' => true, 'message' => 'Failed to remove product from WishList'], 201);
        }
    }


    //===============================================
    //=============PRODUCT ORDERS====================
    //===============================================
    public function user_add_products_order(Request $request)
    {
        $request->validate([
            'product_order' => 'required|array',
            'product_order.*' => 'required|array',
            "product_order.*.product_id" => "integer|required",
            "product_order.*.prod_order_user_id" => "integer|required",
            "product_order.*.prod_order_qty" => "integer|required",
            "product_order.*.prod_order_amount" => "required|regex:/^\d+(\.\d{1,2})?$/",

            'order_qty' => 'integer|required',
            'total_amount' => 'required|regex:/^\d+(\.\d{1,2})?$/',
        ]);


        $data = $request->all();

        $auth_instance = new AuthController();
        $user = $auth_instance->me()->getData()->user_data;
        $user_id = $user->user_id;

        $saveData = DB::connection('mysql')->insert(
            '
                INSERT INTO product_order_user(
                    user_id,
                    order_qty,
                    total_amount
                    ) VALUES (
                    :user_id,
                    :order_qty,
                    :total_amount
                    )
            ',
            [
                'user_id' => $user_id,
                'order_qty' => $request->order_qty,
                'total_amount' => $request->total_amount
            ]
        );

        //get the inserted record
        $getInsertedRecord = DB::select('
            SELECT *FROM product_order_user
            WHERE user_id =:user_id
              AND order_qty=:order_qty
              AND total_amount =:total_amount
            ORDER BY created_at DESC LIMIT 1',
            [
                'user_id' => $user_id,
                'order_qty' => $request->order_qty,
                'total_amount' => $request->total_amount,
            ]
        );

        $prod_order_user_id = $getInsertedRecord[0]->prod_order_user_id;

        if ($saveData) {

            foreach ($data['product_order'] as $product_order) {
                $product_id = $product_order['product_id'];
                $prod_order_qty = $product_order['prod_order_qty'];
                $prod_order_amount = $product_order['prod_order_amount'];
                DB::connection('mysql')->insert(
                    '
                INSERT INTO product_order_product(
                    product_id,
                    prod_order_user_id,
                    prod_order_qty,
                    prod_order_amount
                    ) VALUES (
                    :product_id,
                    :prod_order_user_id,
                    :prod_order_qty,
                    :prod_order_amount
                    )
            ',
                    [
                        'product_id' => $product_id,
                        'prod_order_user_id' => $prod_order_user_id,
                        'prod_order_qty' => $prod_order_qty,
                        'prod_order_amount' => $prod_order_amount,
                    ]
                );
            }


            return response()->json(['isError' => false, 'message' => 'Your order has been received'], 200);
        } else {
            return response()->json(['isError' => true, 'message' => 'Failed to save your order'], 201);
        }
    }

    //products ordered by user
    public function get_user_orderlist()
    {
        $auth_instance = new AuthController();
        $user = $auth_instance->me()->getData()->user_data;
        $user_id = $user->user_id;
//echo $user_id;return;
        $orderlist = DB::connection('mysql')->select(
            '
            SELECT
                product_order_product.prod_order_product_id,
                product_order_product.prod_order_user_id,
                product_order_product.prod_order_qty,
                product_order_product.prod_order_amount,
                product_order_product.created_at AS order_created_at,
                product.*,
                category.category_name
              FROM product_order_product
            LEFT JOIN product_order_user
                ON product_order_product.prod_order_user_id = product_order_user.prod_order_user_id
                AND product_order_user.user_id = :user_id
            LEFT JOIN product
                ON product_order_product.product_id = product.product_id
            LEFT JOIN category
                ON product.category_id = category.category_id
            WHERE product_order_product.prod_order_user_id = :prod_order_user_id',
            [
                'user_id' => $user_id,
                'prod_order_user_id' => $user_id
            ]
        );

        $array = array();
        $array['orderlist'] = $orderlist;

        return response()->json($array, 200);
    }
}
