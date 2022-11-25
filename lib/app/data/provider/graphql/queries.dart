import 'package:flutter/material.dart';

class GraphQLQuery {
  final name;
  final query;

  GraphQLQuery({@required this.name, @required this.query});
}

class GraphQLQueries {
  static final getAllBusinessTypes = new GraphQLQuery(
    name: 'getAllBusinessTypes',
    query: r'''
      query {
        getAllBusinessTypes {
          error
            msg
            data {
              _id
              name
              image
            }
          }
        }
    ''',
  );
  static final customerLoginOrSignUp = new GraphQLQuery(
    name: 'customerLoginOrSignUp',
    query: r'''
      mutation($mobile: String){
        customerLoginOrSignUp(mobile: $mobile){
          token
          streamChatToken
          signup
          bonus
          error
          msg
          data{
            _id
            first_name
            last_name
            mobile
            email
            type
            status
            addresses{
            	_id
            	title
            	address
            	house
            	apartment
            	distance
            	direction_to_reach
            	location{
              	lat
              	lng
            	}
            status
          	}
            stores{
            	_id
            	store{
             _id
              name
              mobile
              businesstype
              address{
                address
                location{
                  lat
                  lng
                }
              }
              
            }
            	earned_cashback
            	welcome_offer
            	welcome_offer_amount
              recently_visited
              visited_at
              name
          	}
            balance
            logo
            date_of_birth
            male_or_female
            rank
            }
          }
        }
    ''',
  );
  static final customerLoginOrSignUpWithRefferralCode = new GraphQLQuery(
    name: 'customerLoginOrSignUp',
    query: r'''
    mutation($mobile: String $referID :String){
      customerLoginOrSignUp(mobile: $mobile,referID:$referID){ 
        token
        bonus
        streamChatToken
        signup
        error
        msg
        data{
          _id
          first_name
          last_name
          mobile
          email
          type
          status
          addresses{
           _id
           title
           address
           house
           apartment
           distance
           direction_to_reach
           location{
             lat
             lng
           }
          status
         }
          stores{
           _id
           store{
           _id
            name
            mobile
            businesstype
            address{
              address
              location{
                lat
                lng
              }
            }
            
          }
           earned_cashback
           welcome_offer
           welcome_offer_amount
            recently_visited
            visited_at
            name
         }
          balance
          logo
          date_of_birth
          male_or_female
          rank
          }
        }
      }
  ''',
  );
  static final verifyUserToken = new GraphQLQuery(
    name: 'verifyCustomerToken',
    query: r'''
      query($token: String){
        verifyCustomerToken(token: $token){
          streamChatToken
          signup
          bonus
          error
          msg
          data{
            _id
            first_name
            last_name
            mobile
            email
            type
            status
            addresses{
            	_id
            	title
            	address
            	house
            	apartment
            	distance
            	direction_to_reach
            	location{
              	lat
              	lng
            	}
            status
          	}
            stores{
            	_id
            	store{
             _id
              name
              mobile
              businesstype
              address{
                address
                location{
                  lat
                  lng
                }
              }
              
            }
            	earned_cashback
            	welcome_offer
            	welcome_offer_amount
              recently_visited
              visited_at
              name
          	}
            balance
            logo
            date_of_birth
            male_or_female
            rank
            }
          }
        }
    ''',
  );
  static final updateRiderInformation = new GraphQLQuery(
    name: 'updateRiderInformation',
    query: r'''
      mutation($rider: RiderInformationInput){
        updateRiderInformation(rider_information: $rider){
          error
          msg
        }
      }
    ''',
  );
  static final addRiderAddress = new GraphQLQuery(
    name: 'addRiderAddress',
    query: r'''
      mutation($address: RiderAddress ){
        addRiderAddress(address: $address){
          error
          msg
       }
     }
    ''',
  );
  static final changeRiderAddress = new GraphQLQuery(
    name: 'changeRiderAddress',
    query: r'''
      mutation($_id: ID){
        changeRiderAddress(_id: $_id){
          error
          msg
        }
      }
    ''',
  );
  static final deleteRiderAddress = new GraphQLQuery(
    name: 'deleteRiderAddress',
    query: r'''
      mutation($_id: ID){
        deleteRiderAddress(_id: $_id){
          error
          msg
        }
      }
    ''',
  );
  static final updateRiderLocationWithAvailability = new GraphQLQuery(
    name: 'updateRiderLocationWithAvailability',
    query: r'''
      mutation($availability: Boolean, $lat: Float, $lng: Float){
        updateRiderLocationWithAvailability(availability: $availability, lat: $lat, lng: $lng){
          error
          msg
        }
      }
    ''',
  );
  static final getCurrentlyAssignedBatchByRider = new GraphQLQuery(
    name: 'getCurrentlyAssignedBatchByRider',
    query: r'''
      query{
        getCurrentlyAssignedBatchByRider{
          error
          msg
          data{
            _id
            store{
             _id
              name
              mobile
              businesstype
              address{
                address
                location{
                  lat
                  lng
                }
              }
              
            }
            status
            orders{
              _id
              order_type
              distance
              products{
                _id
                name
              }
              rawitems{
                _id
                item
              }
              total
              total_cashback
              status
              user{
                _id
                first_name
                last_name
                mobile
              }
              cashback_percentage
              wallet_amount
            }
            updatedAt
          }
        }
      }
    ''',
  );

  static final getBatchById = new GraphQLQuery(
    name: 'getBatchById',
    query: r'''
      query {
  getBatchById {
    error
    msg 
    data {
      _id
      otp_verified
            store{
             _id
              name
              mobile
              businesstype
              address{
                address
                location{
                  lat
                  lng
                }
              }
              
            }
            status
            orders{
              _id
              order_type
              distance
              products{
                _id
                name
              }
              rawitems{
                _id
                item
              }
              total
              total_cashback
              status
              user{
                _id
                first_name
                last_name
                mobile
              }
              cashback_percentage
              wallet_amount
            }
    }
          
    }
  }
    ''',
  );
  static final updateBatchStatusByRider = new GraphQLQuery(
    name: 'updateBatchStatusByRider',
    query: r'''
      mutation($_id: ID, $status: String){
        updateBatchStatusByRider(_id: $_id, status: $status){
          error
          msg
        }
      }
    ''',
  );
  static final getAllOrdersFromBatchByRider = new GraphQLQuery(
    name: 'getAllOrdersFromBatchByRider',
    query: r'''
      query($_id: ID, $lat: Float, $lng: Float){
        getAllOrdersFromBatchByRider(_id: $_id, lat: $lat, lng: $lng){
          error
          msg
          data{
             _id
            order_type
            distance
            address
            location {
               coordinates
            }
            calculated_distance
            products{
              _id
              name
              quantity
              selling_price
            }
            rawitems{
              _id
              item
              quantity
            }
            total
            total_cashback
            status
            user{
              _id
              first_name
              last_name
              mobile
            }
            cashback_percentage
            wallet_amount
            payment_status
            store{
              _id
              name
              address{
                address
                location{
                  lat
                  lng
                }
              }
            }
          }
        }
      }
    ''',
  );
  static final updateOrderStatusByRider = new GraphQLQuery(
    name: 'updateOrderStatusByRider',
    query: r'''
      mutation($_id: ID, $status: String, $lat: Float, $lng: Float){
        updateOrderStatusByRider(_id: $_id, status: $status, lat: $lat, lng: $lng){
          error
          msg
        }
      }
    ''',
  );
  static final getAllPickedOrSkippedOrdersFromBatchByRider = new GraphQLQuery(
    name: 'getAllPickedOrSkippedOrdersFromBatchByRider',
    query: r'''
      query($_id: ID, $lat: Float, $lng: Float){
        getAllPickedOrSkippedOrdersFromBatchByRider(_id: $_id, lat: $lat, lng: $lng){
          error
          msg
          data{
            _id
            order_type
            distance
            address
            location {
               coordinates
            }
            calculated_distance
            products{
              _id
              name
              quantity
              selling_price
            }
            rawitems{
              _id
              item
              quantity
            }
            total
            total_cashback
            status
            user{
              _id
              first_name
              last_name
              mobile
            }
            cashback_percentage
            wallet_amount
            payment_status
            store{
              _id
              name
              address{
                address
                location{
                  lat
                  lng
                }
              }
            }
          }
        }
      }
    ''',
  );
  static final calculateDistanceBetweenTwoLocation = new GraphQLQuery(
    name: 'calculateDistanceBetweenTwoLocation',
    query: r'''
      query($first_location_lat: Float, $first_location_lng: Float, $second_location_lat: Float, $second_location_lng: Float){
        calculateDistanceBetweenTwoLocation(first_location_lat: $first_location_lat, first_location_lng: $first_location_lng, second_location_lat: $second_location_lat, second_location_lng: $second_location_lng){
          error
          msg
          data{
            distance
            time
          }
        }
      }
    ''',
  );
  static final getStoreCountBasedOnLocation = new GraphQLQuery(
    name: 'getStoreCountBasedOnLocation',
    query: r'''
      query($lat: Float, $lng: Float){
        getStoreCountBasedOnLocation(lat: $lat lng: $lng){
          error
          msg
          data
        }
      }
    ''',
  );
  static final refundByRider = new GraphQLQuery(
    name: 'refundByRider',
    query: r'''
      mutation($_id: ID, $images:[String], $total: Float){
        refundByRider(_id: $_id, images:$images, total: $total){
          error
          msg
        }
      }
    ''',
  );
  static final collectAmountByRider = new GraphQLQuery(
    name: 'collectAmountByRider',
    query: r'''
      mutation($_id: ID){
        collectAmountByRider(_id: $_id){
          error
          msg
        }
      }
    ''',
  );
  static final getAllWalletByCustomer = new GraphQLQuery(
    name: 'getAllWalletByCustomer',
    query: r'''
      query($lat: Float, $lng: Float){
        getAllWalletByCustomer(lat: $lat, lng: $lng){
          error
          msg
          data {
            recently_visited
            _id
            welcome_offer
            welcome_offer_amount
            earned_cashback
            user
            password
            name
            premium
            logo
            default_cashback
            default_welcome_offer
            promotion_cashback
            status
            promotion_welcome_offer_status
            promotion_cashback_status
            flag
            createdAt
            updatedAt
            store_type
            distance
            online
            calculated_distance
            customer_wallet_amount
            lead
            lead_welcome_offer
             address{
              address
            }
          }
        }
      }
    ''',
  );

  static final getAllWalletTransactionByCustomer = GraphQLQuery(
    name: 'getAllWalletTransactionByCustomer',
    query: r'''
            query($store: ID){
    getAllWalletTransactionByCustomer(store:$store){
        error
        msg
        data
       {
          amount
          debit_or_credit
          comment
           createdAt
          store{
           name
            _id
            logo
            address{
              address
            }
                
          }
      
         
        }
      }
    }
    ''',
  );
  static final getRiderOrderHistoryPageData = new GraphQLQuery(
    name: 'getRiderOrderHistoryPageData',
    query: r'''
      query($status: String, ){
          getRiderOrderHistoryPageData( status: $status){
            error
            msg
            data{
               _id
              order_type
              distance
              address
              location{
                type
                coordinates
              }
              calculated_distance
              products{
                _id
                name
                quantity
                selling_price
              }
              rawitems{
                _id
                item
                quantity
              }
              total
              total_cashback
              status
              user{
                _id
                first_name
                last_name
                mobile
              }
              cashback_percentage
              wallet_amount
              store{
                _id
                name
              }
              rider_earnings
              rider_extra_earnings
              rider_reach_time_to_customer
              rider_reach_time{
                time
              }
            }
          }
        }
    ''',
  );
  static final registerFirebase = new GraphQLQuery(
    name: 'registerFirebase',
    query: r'''
mutation ($token: String) {
  registerFirebase(firebase_token: $token) {
    error
    msg
  }
}
    ''',
  );

  static final addFirebaseToken = new GraphQLQuery(
    name: 'addFirebaseTokenToCustomer',
    query: r'''
    mutation($firebase_token: String ){
  addFirebaseTokenToCustomer(firebase_token :$firebase_token){
    msg
    error
  }
}
    ''',
  );

  static final addrestoreIDtoCustomer = new GraphQLQuery(
    name: 'addrestoreIDtoCustomer',
    query: r'''
    mutation($restoreID: String){
      addrestoreIDtoCustomer(restoreID : $restoreID){
      error
      msg
  }
}
    ''',
  );

  static final verifyOtp = new GraphQLQuery(
    name: 'verifyOtp',
    query: r'''
query($id: ID, $otp: String) {
  verifyOtp(_id: $id, otp: $otp) {
    error
    msg
  }
}
    ''',
  );
  static final getLoginHistoryPageData = new GraphQLQuery(
    name: 'getLoginHistoryPageData',
    query: r'''
query($start: String, $end: String) {
  getLoginHistoryPageData(start_date: $start, end_date: $end) {
    error
    msg
    data {
      _id
      hours
    }
  }
}
    ''',
  );
  static final getClaimRewardsPageData = new GraphQLQuery(
    name: 'getClaimRewardsPageData',
    query: r'''
query($lat: Float, $lng: Float) {
  getClaimRewardsPageData(lat: $lat, lng: $lng) {
    error
    msg
    data{
      stores{
        _id
        user
        password
        name
        premium
        online
        store_type
        calculated_distance
        logo
        flag
        distance
        actual_cashback
        default_welcome_offer
        promotion_welcome_offer_status
        promotion_welcome_offer
       
        default_cashback
        promotion_cashback_status
        promotion_cashback
       
        businesstype
        address{
          address
          location{
            lat
            lng
          }
        }
      }
    }
  }
}
    ''',
  );

  static final getClaimRewardsPageCount = new GraphQLQuery(
    name: 'getClaimRewardsPageCount',
    query: r'''
query($lat: Float, $lng: Float) {
  getClaimRewardsPageCount(lat: $lat, lng: $lng) {
    error
    msg
    data{
    storesCount
    totalCashBack
    }
  }
}
    ''',
  );
  static final addCustomerAddress = new GraphQLQuery(
    name: 'addCustomerAddress',
    query: r'''
  mutation($address : String $title: String $lat: Float $lng: Float
    $house: String
    $apartment: String
    $direction_to_reach: String){
    addCustomerAddress(address:{
      address: $address
      title: $title
      house: $house
      apartment: $apartment
      direction_to_reach: $direction_to_reach
      location:{
        lat: $lat
        lng: $lng
      }
    }){
      error
      msg
    }
  }
  ''',
  );

  static final addMultipleStoreToWalletNew = new GraphQLQuery(
    name: 'addMultipleStoreToWalletNew',
    query: r'''
 mutation($lat: Float $lng: Float){
  addMultipleStoreToWalletNew(lat: $lat, lng: $lng) {
    error
    msg
  }
}
    ''',
  );

  static final addMultipleStoreToWallet = new GraphQLQuery(
    name: 'addMultipleStoreToWallet',
    query: r'''
 mutation($lat: Float $lng: Float){
  addMultipleStoreToWallet(addMultipleStoresToWallet:$data) {
    error
    msg
  }
} 
    ''',
  );

  static final getHomePageFavoriteShops = new GraphQLQuery(
    name: 'getHomePageFavoriteShops',
    query: r'''query($lat : Float $lng: Float $pageNumber : Int){
    getHomePageFavoriteShops(lat: $lat, lng:$lng , pageNumber:$pageNumber){
      error
      msg
      data{
        _id
        name
        logo
        default_cashback
        calculated_distance
        store_type
        premium
        businesstype
      }
      keywords{
      name
      keyword_helper
      image
      subtitle
      isProductAvailable
      _id
    }
    }
  }''',
  );

  static final homePageRemoteConfigData = new GraphQLQuery(
    name: 'homePageRemoteConfigData',
    query:
        r'''query($_id : ID $keyword:String $product_fetch: Boolean  $lat: Float $lng: Float $pageNumber: Int){
  homePageRemoteConfigData(_id:$_id ,keyword: $keyword, product_fetch:$product_fetch, lat: $lat, lng:$lng , pageNumber:$pageNumber){
    error
    msg
    data{
          _id
        name
        logo
        default_cashback
        calculated_distance
        store_type
        premium
        businesstype
      products{
        _id
       name
       logo
       cashback
      }
    }
  }
}''',
  );

  static final getNearMePageData = new GraphQLQuery(
    name: 'getNearMePageData',
    query: r'''query($query:String $lat: Float $lng: Float ){
    getNearMePageData(query:$query,lat:$lat,lng:$lng){
    error
     msg
      data
{
  products
  {
    name
    _id
    logo
    _id
    store{
       name
    logo
    _id
    businesstype
    }
    catalog
    {
      name
      _id
    }
  }
    inventories
      {
        mrp
        name
        _id
        store{
       name
    logo
    _id
    businesstype
    }
      }
  stores
  {
    name
    logo
    _id
    businesstype
  }
 }
}
}''',
  );
  static final getProductsByName = new GraphQLQuery(
    name: 'getProductsByName',
    query: r'''query($name:String $lat: Float $lng: Float ){
    getProductsByName(name:$name,lat:$lat,lng:$lng){
      error
    msg
    data{
      products{
        _id
        name
        cashback
        store{
        _id
        name
        logo
        default_cashback
        calculated_distance
        store_type
        premium
        }
      }
      inventories{
        _id
        name
        store{
            _id
        name
        logo
        default_cashback
        calculated_distance
        store_type
        premium
        }
      }
    }
}
}''',
  );

  static final getOrderOnlinePageProductsData = new GraphQLQuery(
    name: 'getOrderOnlinePageProductsData',
    query: r'''query($store: ID){
    getOrderOnlinePageProductsData(store:$store){
      error
    msg
    data{
      store
      {
      _id
      name
        store_type
        color
        default_cashback
        default_welcome_offer
        promotion_cashback
        logo
        delivery_slots
        {
          day
          slots
          {
            start_time
            {
              hour
}
            end_time
            {
              hour
            }
              }
        }
}
wallet_amount
   products
      {
        _id
        name
        products
        {
          _id
          name
          cashback
          logo
}
      }
    }
}
}''',
  );
  static final getcartID = new GraphQLQuery(
    name: 'getcartID',
    query: r'''query($store: ID){
  getcartID(store_id:$store)
    {
       error
    msg
  data
      {
        _id
        total_items_count
        products
        {
          mrp
          _id
          name
          selling_price
          cashback
          quantity
          mrp
          gst_amount
        }
        inventories
      {
        mrp
        name
        _id
        quantity
      }
            rawitems{
            logo
        item
        quantity
        _id
        unit
      }
      }
}
}''',
  );
  static final getAutoCompleteProductsByStore = new GraphQLQuery(
    name: 'getAutoCompleteProductsByStore',
    query: r'''query($store: ID $query : String){
  getAutoCompleteProductsByStore(store:$store,query:$query)
  {
    msg
    error
    data
    {
      products
      {
        mrp
        name
        _id
        cashback
        logo
        store{
        _id
        name
        logo
        default_cashback
        calculated_distance
        store_type
        premium
        }
}
      inventories
      {
               mrp
        name
        _id
        store{
                _id
        name
        logo
        default_cashback
        calculated_distance
        store_type
        premium
        }
      }
    }
  }
}''',
  );
  static final getAllActiveOrders = new GraphQLQuery(
    name: 'getAllActiveOrdersByCustomer',
    query: r'''
    query{
      getAllActiveOrdersByCustomer{
        error
        msg
    data
        {
          _id
          status
          order_type
          address
          createdAt
          delivery_slot
          {
          day
            start_time
            {
              hour
              minute
            }
            end_time{
              hour
              minute
}
}
          total
        location
           {
          type
          coordinates
        }
          rawitems
          {
            item
            quantity
          }
          products
          {
          name
          quantity
          deleted
          modified
          selling_price
          _id
          cashback
          gst_amount
          mrp
          status
          updatelogo
          updatemrp
          updatename
          updatequantity
          updateselling_price
          }
           inventories
          {
            name
          quantity
          deleted
          modified
          selling_price
          _id
          cashback
          gst_amount
          mrp
          status
          updatelogo
          updatemrp
          updatename
          updatequantity
          updateselling_price
          }
             rawitems{
             logo
            item
            _id
            quantity 
            modified
            deleted
            status
            updatelogo
            updatemrp
            updatename
            updatequantity
            updateselling_price
          }
        store
          {
           _id
              mobile
              name
              address{
                address
              }
          }
          rider
          {
            mobile
            _id
            first_name
            last_name
            bank_document_photo
          }
        }
      }
}
    ''',
  );

  static final getAllOrders = new GraphQLQuery(
    name: 'getAllOrdersByCustomer',
    query: r'''
    query{
      getAllOrdersByCustomer{
        error
        msg
    data
        {
          _id
          status
          order_type
          address
          createdAt
          total_cashback
          wallet_amount
          delivery_slot
          {
          day
            start_time
            {
              hour
              minute
            }
            end_time{
              hour
              minute
}
}
          total
        location
          {
          type
          coordinates
        }
          rawitems
          {
            item
            logo
            quantity
          }
          products
          {
            name
            quantity
            deleted
            modified
            selling_price
          }
          inventories
          {
            name
            quantity
            mrp
            status
            selling_price
            gst_amount
          }
             rawitems{
            item
            _id
            quantity
            logo
            modified
          }
        store
          {
           _id
              mobile
              name
              logo
              address{
                address
              }
          }
          rider
          {
            mobile
            _id
            first_name
            last_name
            bank_document_photo
          }
        }
      }
}
    ''',
  );

  static final getAllCartData = new GraphQLQuery(
    name: 'getAllcarts',
    query: r'''query{
getAllcarts{
      error
    msg
    cartItemsTotal
  carts
    {
      _id
      total_items_count
      store
      {
        _id
        name
        store_type
        logo
        businesstype
        earned_cashback
      }
      products{
        _id
        quantity
      }
      rawitems{
        item
        quantity
        logo
        _id
        unit
      }
}
}
}''',
  );

  static final getRedeemCashInStorePageData = new GraphQLQuery(
    name: 'getRedeemCashInStorePageData',
    query: r'''query($lat: Float $lng: Float ){
    getRedeemCashInStorePageData(lat:$lat,lng:$lng){
      error
    msg
        data
    {
      name
      _id
      store_type
      earned_cashback
      updatedAt
      distance
      logo
      businesstype
    }
}
}''',
  );

  static final getScanReceiptPageNearMeStoresData = new GraphQLQuery(
    name: 'getScanReceiptPageNearMeStoresData',
    query: r'''query($lat: Float $lng: Float ){
    getScanReceiptPageNearMeStoresData(lat:$lat,lng:$lng){
      error
    msg
        data
    {
      name
      _id
      store_type
      earned_cashback
      updatedAt
      distance
      logo
      businesstype
    }
}
}''',
  );

  static final redeemBalance = new GraphQLQuery(
    name: 'redeemBalance',
    query: r'''mutation($store: ID $amount: Float ){
    redeemBalance(store:$store,amount:$amount){
      error
    msg
    expBalance
    actBalance
}
}''',
  );

  static final placeOrder = new GraphQLQuery(
    name: 'placeOrder',
    query: r'''
    mutation($image: String $total: Float $lat: Float $lng: Float $address: String){
      placeOrder(orderInput:{
        order_type: "receipt"
        receipt: $image
        total: $total
        lat: $lat
        lng: $lng
        address: $address
      }){
        error
        msg
      }
    }
    ''',
  );
  static final placeOrderWithStore = new GraphQLQuery(
    name: 'placeOrder',
    query: r'''
    mutation($image: String $storeId: ID $products: [OrderProduct] $total: Float $cashback: Float $lat: Float $lng: Float){
      placeOrder(orderInput:{
        order_type: "receipt"
        receipt: $image
        store: $storeId
        products: $products
        total: $total
        cashback_percentage: $cashback
        lat: $lat
        lng: $lng
      }){
        error
        msg
      }
    }
    ''',
  );
  static final changeCustomerAddress = new GraphQLQuery(
    name: 'changeCustomerAddress',
    query: r'''
    mutation($id: ID){
  changeCustomerAddress(_id:$id){
    error
    msg
  }
}
''',
  );

  static final reviewCart = new GraphQLQuery(
    name: 'cart',
    query: r'''
    mutation($cart_id: ID){
  cart(cartInput: {flag: "reviewCart" cart_id: $cart_id}){
    error
    msg
data{
      total
      total_items_count
      storeDoc{
        actual_welcome_offer
        actual_cashback
        bill_discount_offer_status
        bill_discount_offer_amount
      }
      products{
        _id
        name
        status
        gst_amount
        selling_price
        quantity
        cashback
      }
    rawitems
      {
        item
        quantity
        logo
      }
              inventories
      {
        mrp
        name
        _id
        quantity
        status
      }
    }
  }
}
    ''',
  );

  static final getCartPageInformation = new GraphQLQuery(
    name: 'getCartPageInformation',
    query: r'''
  query($store_id: ID){
  getCartPageInformation(store_id: $store_id){
    error
    msg
    data{
      bill_discount_offer_status
      bill_discount_offer_target
      bill_discount_offer_amount
      wallet_amount
      delivery_slots{
        _id
        day
      
        slots{
          _id
          cut_off_time{
            hour
            minute
          }
          start_time{
            hour
            minute
          }
          end_time{
            hour
            minute
          }
        }
      }
    }
  }
}
    ''',
  );

  static final getOrderConfirmPageData = new GraphQLQuery(
    name: 'getOrderConfirmPageData',
    query: r'''
    query($store: ID  $products: [OrderProduct] $distance: Int $wallet_amount :Int $inventories: [OrderInventory]){
      getOrderConfirmPageData(
        store: $store
        products: $products
        distance: $distance
        wallet_amount: $wallet_amount
        inventories: $inventories
      ){
        error
        msg
         data {
      previous_total_amount
      total_gst_amount
      used_wallet_amount
      total
      gst_and_packaging
      packaging_fee
      delivery_fee
      delivery_slots {
        day
        slots {
          _id
          start_time {
            hour
            minute
          }
          cut_off_time{
            hour
            minute
          }
          end_time {
            hour
            minute
          }
          status
        }
        status
      }
      wallet_amount
      bill_discount_offer_amount
      bill_discount_offer_status
      bill_discount_offer_target
     
    }
      }
    }
    ''',
  );
  static final addToCartWithId = new GraphQLQuery(
    name: 'cart',
    query: r'''
      mutation($store_id: ID $product: CartProductInput $increment:Boolean $index: Int $cart_id: ID){
  cart(cartInput: {  
        flag: "addToCart"
        raw_or_product: "product"
        product: $product
        store_id: $store_id
        increment: $increment
        index: $index
        cart_id: $cart_id}){
    error
    msg
       data {
      _id
      total_items_count
      store
      products
        {
          mrp
          _id
          name
          selling_price
          cashback
          quantity
          mrp
          gst_amount
        }
        inventories
      {
        mrp
        name
        _id
        quantity
      }
            rawitems{
            logo
        item
        quantity
        _id
        unit
      }
}
  }
}
    ''',
  );

  static final addToCart = new GraphQLQuery(
    name: 'cart',
    query: r'''
      mutation($store_id: ID $product: CartProductInput $increment:Boolean $index: Int){
  cart(cartInput: {  
        flag: "addToCart"
        raw_or_product: "product"
        product: $product
        store_id: $store_id
        increment: $increment
        index: $index
      }){
    error
    msg
       data {
      _id
      total_items_count
      store
            products
        {
          mrp
          _id
          name
          selling_price
          cashback
          quantity
          mrp
          gst_amount
        }
        inventories
      {
        mrp
        name
        _id
        quantity
      }
            rawitems{
            logo
        item
        quantity
        _id
        unit
      }
}
  }
}
    ''',
  );

  static final addToCartInventory = new GraphQLQuery(
    name: 'cart',
    query: r'''
      mutation($store_id: ID $inventory: CartInventoryInput){
  cart(cartInput: {
        flag: "addToCart"
        raw_or_product: "Inventory"
        inventory: $inventory
        store_id: $store_id
      }){
    error
    msg
       data {
      _id
      total_items_count
      store
            products
        {
          mrp
          _id
          name
          selling_price
          cashback
          quantity
          mrp
          gst_amount
        }
        inventories
      {
        mrp
        name
        _id
        quantity
      }
            rawitems{
            logo
        item
        quantity
        _id
        unit
      }
}
  }
}
    ''',
  );
  static final addToCartInventoryWithCartID = new GraphQLQuery(
    name: 'cart',
    query: r'''
      mutation($store_id: ID $inventory: CartInventoryInput $cart_id: ID){
  cart(cartInput: {
        flag: "addToCart"
        raw_or_product: "Inventory"
        inventory: $inventory
        store_id: $store_id
        cart_id: $cart_id
      }){
    error
    msg
       data {
      _id
      total_items_count
      store
            products
        {
          mrp
          _id
          name
          selling_price
          cashback
          quantity
          mrp
          gst_amount
        }
        inventories
      {
        mrp
        name
        _id
        quantity
      }
            rawitems{
        item
        quantity
        logo
        _id
        unit
      }
}
  }
}
    ''',
  );

  static final createRazorPayOrder = new GraphQLQuery(
    name: 'createRazorPayOrder',
    query: r'''
    mutation($amount: Int, $store:ID){
      createRazorPayOrder(amount : $amount store_id: $store){
        error
        msg
        data{
          order_id
          amount
        }
      }}''',
  );

  static final finalPlaceOrder = new GraphQLQuery(
    name: 'placeOrder',
    query: r'''
       mutation(
      $storeId: ID 
      $cartID: ID 
      $delivery_slot: SingleDeliverySlotInput
      $products: [OrderProduct] 
      $rawitems: [OrderRawDataInput] 
      $inventories: [OrderInventory]
      $total: Float 
      $cashback: Float 
      $lat: Float 
      $lng: Float 
      $order_type: String
      $address: String
      $razor_order_id: String
      $razor_signature: String
      $razor_payment_id: String
      $packaging_fee: Int
      $delivery_fee: Int
      $wallet_amount: Float){
      placeOrder(orderInput:{
        order_type: $order_type
        store: $storeId
        cartID: $cartID
        products: $products
        rawitems: $rawitems
        inventories: $inventories
        total: $total
        cashback_percentage: $cashback
        wallet_amount: $wallet_amount
        address: $address
        delivery_slot: $delivery_slot
        lat: $lat
        lng: $lng
        razorpay_signature: $razor_signature
        razorpay_order_id: $razor_order_id
        razorpay_payment_id: $razor_payment_id
        packaging_fee: $packaging_fee
        delivery_fee: $delivery_fee
      }){
        error
        msg
        data
        {
          _id
          status
          order_type
          address
          createdAt
          total_cashback
          wallet_amount
          delivery_slot
          {
          day
          cut_off_time{
            hour
            minute
          }
            start_time
            {
              hour
              minute
            }
            end_time{
              hour
              minute
}
}
          total
        location
          {
           type
          coordinates
}
          rawitems
          {
            item
            quantity
          }
          products
          {
            name
            quantity
            deleted
            modified
            selling_price
          }
             rawitems{
            item
            _id
            quantity
            modified
          }
        store
          {
           _id
              mobile
              name
              logo
              address{
                address
              }
          }
          rider
          {
            mobile
            _id
            first_name
            bank_document_photo
          }
        }
      }
    }
    ''',
  );
  static final placeOrderActive = new GraphQLQuery(
    name: 'placeOrder',
    query: r'''
       mutation(
       $_id: ID   
       $razor_order_id: String
      $razor_signature: String
      $razor_payment_id: String){
  placeOrder(orderInput: {
    order_type: "FullPayment"
    _id:$_id
     razorpay_signature: $razor_signature
    razorpay_order_id: $razor_order_id
    razorpay_payment_id: $razor_payment_id
  }){
    error
    msg
    data{
      _id
      status
      order_type
      receipt
      store{
        _id
        name
      }
      store
      {
        _id
      }
      rider
      {
        _id
      }
      total
      products{
        _id
        name
        cashback
      }
      wallet_amount
    }
  }
}
    ''',
  );
//   static final getAllStreamChatChannelById = new GraphQLQuery(
//     name: 'getAllStreamChatChannelById',
//     query: r'''
// query{
//   getAllStreamChatChannelById{
//     msg
//     error
//     data{
//       id
//       name
//   }
// }
// }
//     ''',
//   );

  static final updateCustomerInformation = new GraphQLQuery(
    name: 'updateCustomerInformation',
    query: r'''
     mutation($first_name :String $last_name :String $email : String){
  updateCustomerInformation(customerInput:{
    first_name:$first_name
    last_name:$last_name
    email:$email
  })
  {
    msg
    error
  }}
    ''',
  );
  static final deleteCustomerAddress = new GraphQLQuery(
    name: 'deleteCustomerAddress',
    query: r'''
mutation($id: ID){
  deleteCustomerAddress(_id: $id){
    error
    msg
  }
}
  ''',
  );

  static final generateReferCode = new GraphQLQuery(
    name: 'generateReferCode',
    query: r'''
mutation{
  generateReferCode{
    error
    msg
    data
  }
}
  ''',
  );

  static final replaceCustomerAddress = new GraphQLQuery(
    name: 'replaceCustomerAddress',
    query: r'''
  mutation($id: ID, $address : String $title: String $lat: Float $lng: Float
    $house: String
    $apartment: String
    $direction_to_reach: String
  ){
    replaceCustomerAddress(_id: $id, address:{
      address: $address
      title: $title
      house: $house
      apartment: $apartment
      direction_to_reach: $direction_to_reach
      location:{
        lat: $lat
        lng: $lng
      }
    }){
      error
      msg
    }
  }
  ''',
  );

  static final getCartLocation = new GraphQLQuery(
    name: 'cartLocation',
    query: r'''
     query($cart_id:ID $store_id :ID ){
  cartLocation(flag:"get",cart_id:$cart_id,store_id:$store_id)
  {
    msg
    error
   addresses
    {
                 title
     house
     apartment
     direction_to_reach
     address
     distance
     selected
     _id
        location{
          lat
          lng
        }
        selected
    }
    storeAddress
    {
                   title
     house
     apartment
     direction_to_reach
     address
     distance
     _id
     selected
        location{
          lat
          lng
        }
        selected
    }
  }
}
    ''',
  );

  static final selectCartLocation = new GraphQLQuery(
    name: 'cartLocation',
    query: r'''
     query($cart_id :ID $address : CartAddressInput){
  cartLocation(flag:"select",cart_id:$cart_id,address:$address)
  {
    msg
   addresses
    {
                  title
     house
     apartment
     direction_to_reach
     address
     distance
     selected
        location{
          lat
          lng
        }
        selected
    }
    storeAddress
    {
                   title
     house
     apartment
     direction_to_reach
     address
     distance
     selected
        location{
          lat
          lng
        }
        selected
    }
  }
}
    ''',
  );

  static final addToCartNewRawItem = new GraphQLQuery(
    name: 'cart',
    query: r'''
 mutation($cart_id :ID $raw_item : CartRawItemInput){
  cart(cartInput: {
    flag: "addToCart",
    raw_or_product: "raw",
    cart_id:$cart_id,
    raw_item: $raw_item
    }
    )
    {
    error
    msg
    data
    {
  total_items_count
      rawitems
      {
        item
        quantity
        unit
        logo
      }
    }
  }}
  ''',
  );
  static final addToCartEditRawItem = new GraphQLQuery(
    name: 'cart',
    query: r'''
 mutation($cart_id :ID $raw_item : CartRawItemInput $newValueItem :String ){
  cart(cartInput: {
    flag: "addToCart",
    raw_or_product: "raw",
    updateRawItem:true
    newValueItem:$newValueItem
    cart_id:$cart_id,
    raw_item:$raw_item
    }
    )
    {
    error
    msg
    data
    {
  total_items_count
      rawitems
      {
        item
        quantity
        unit
        logo
      }
    }
  }}
  ''',
  );
}
