<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class HomeScreenController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        $categories = DB::connection('mysql')->select(
            'SELECT * FROM category ORDER BY RAND()',
        );

        //wheather to get products randomly or not
        $products =  DB::connection('mysql')->select(
                    'SELECT product.*,
                            (SELECT COUNT(*) FROM product_like WHERE product_like.product_id = product.product_id) AS likes
                            FROM product ORDER BY RAND() LIMIT 20
                       '
                );

        $categories = DB::connection('mysql')->select(
            'SELECT * FROM category ORDER BY category_name ASC',
        );
        $product_sub_category = DB::connection('mysql')->select(
            'SELECT * FROM sub_category ORDER BY sub_category_name ASC',
        );
        $array = array();

        $new_products = array();

        foreach ($products as $key => $value) {
            $new_product['product_id'] = $value->product_id;
            $new_product['product_name'] = $value->product_name;
            $new_product['likes'] = $value->likes;
            $new_product['cover'] = asset('storage/products/' . $value->cover);
            $new_product['product_description'] = $value->product_description;
            $new_product['created_at'] = $value->created_at;
            $new_product['updated_at'] = $value->updated_at;


            $product_images = DB::connection('mysql')->select(
                'SELECT * FROM product_images WHERE product_id = :product_id',
                ['product_id' => $value->product_id],
            );

            $new_products_images = array();
            foreach ($product_images as $product_image) {
                $product_image_array = array();
                $product_image_array['product_id'] = $value->product_id;
                $product_image_array['product_images_id'] = $product_image->product_images_id;
                $product_image_array['product_id'] = $value->product_id;
                $product_image_array['img_url'] = asset('storage/products/' . $product_image->img_url);
                $product_image_array['created_at'] = $product_image->created_at;
                $product_image_array['updated_at'] = $product_image->updated_at;
                array_push($new_products_images, $product_image_array);
            }

            //retrieve product attributes
            $product_attributes = DB::connection('mysql')->select(
                'SELECT * FROM product_attributes WHERE product_id = :product_id',
                ['product_id' => $value->product_id],
            );

            $new_product_attributes = array();
            foreach ($product_attributes as $product_attribute) {
                $product_attribute_array = array();
                $product_attribute_array['product_id'] = $value->product_id;
                $product_attribute_array['product_attributes_default'] = $product_attribute->product_attributes_default;
                $product_attribute_array['product_attributes_name'] = $product_attribute->product_attributes_name;
                $product_attribute_array['product_attributes_value'] = $product_attribute->product_attributes_value;
                $product_attribute_array['product_attributes_price'] = $product_attribute->product_attributes_price;
                $product_attribute_array['product_attributes_stock_qty'] = $product_attribute->product_attributes_stock_qty;
                $product_attribute_array['product_attributes_summary'] = !empty($product_attribute->product_attributes_summary) ? $product_attribute->product_attributes_summary : NULL;
                $product_attribute_array['created_at'] = $product_attribute->created_at;
                $product_attribute_array['updated_at'] = $product_attribute->updated_at;
                array_push($new_product_attributes, $product_attribute_array);
            }

            //retrieve product subcategories
            $product_subcategories = DB::connection('mysql')->select(
                'SELECT 
                            product_sub_category.product_sub_category_id, 
                            product_sub_category.sub_category_id, 
                            category.category_id, 
                            sub_category.sub_category_name, 
                            sub_category.sub_category_description,
                            category.category_name, 
                            category.category_description
                        FROM 
                            product_sub_category
                            INNER JOIN sub_category 
                                ON product_sub_category.sub_category_id = sub_category.sub_category_id
                            INNER JOIN category 
                                ON sub_category.category_id = category.category_id
                        WHERE 
                            product_sub_category.product_id =:product_id',
                ['product_id' => $value->product_id],
            );

            $new_product_subcategories = array();
            foreach ($product_subcategories as $product_subcategory) {
                $product_subcategory_array = array();
                $product_subcategory_array['product_id'] = $value->product_id;
                $product_subcategory_array['sub_category_id'] = $product_subcategory->sub_category_id;
                $product_subcategory_array['category_id'] = $product_subcategory->category_id;
                $product_subcategory_array['product_id'] = $value->product_id;
                $product_subcategory_array['product_sub_category_id'] = $product_subcategory->product_sub_category_id;
                $product_subcategory_array['sub_category_name'] = $product_subcategory->sub_category_name;
                $product_subcategory_array['category_name'] = $product_subcategory->category_name;
                $product_subcategory_array['sub_category_description'] = !empty($product_subcategory->sub_category_description) ? $product_subcategory->sub_category_description : NULL;
                $product_subcategory_array['category_description'] = !empty($product_subcategory->category_description) ? $product_subcategory->category_description : NULL;

                array_push($new_product_subcategories, $product_subcategory_array);
            }

            $product_like_ = DB::connection('mysql')->select(
                'SELECT * FROM product_like WHERE product_id = :product_id',
                ['product_id' => $value->product_id],
            );
            $likes = count($product_like_);
            $new_product['likes'] = $likes;

            $new_product['product_sub_categories'] = $new_product_subcategories;
            $new_product['product_attributes'] = $new_product_attributes;
            $new_product['product_images'] = $new_products_images;

            array_push($new_products, $new_product);
        }

        $array['products'] = $new_products;
        $array['products'] = $new_products;
        $array['categories'] = $categories;
        $array['sub_categories'] = $product_sub_category;

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
        //
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
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
