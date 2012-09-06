#encoding: utf-8
DEBT_PAY_PACK = [
  {
    "service"=>{
      "ks"=>{
        "service"=>"Центральне опалення",
        "service_code"=>"4",
        "company_code"=>"411      "
      },
      "debt"=>{
        "provider_account_no"=>"26000130262",
        "prepayment"=>"0.0",
        "amount_to_pay"=>"36.44",
        "charge"=>"84.43",
        "debt"=>"477.71",
        "last_paying"=>"525.7"
      },
    "payer"=>{"ls"=>"4110000106052"}
    }, 
    "address"=>"Миколайчука І.,   24                KB.52",
    "bill_identifier"=>"4110000106052",
    "bill_period"=>"2012-08-18 21:07:00",
    "fio"=>"Хащевська Г.Б.                                    "
  },\
 {"service"=>{
    "ks"=>{
      "service"=>"Холодна вода",
      "service_code"=>"2",
      "company_code"=>"411      "
    }, 
    "debt"=>{
      "provider_account_no"=>"26001000005120",
      "prepayment"=>"0.0",
      "amount_to_pay"=>"7.46",
      "charge"=>"20.64",
      "debt"=>"13.18",
      "last_paying"=>"26.36"
    },
    "payer"=>{"ls"=>"4110000106052"}
  },
  "address"=>"Миколайчука І.,   24                KB.52",
  "bill_identifier"=>"4110000106052",
  "bill_period"=>"2012-08-18 21:07:00",
  "fio"=>"Хащевська Г.Б.                                    "
  }, 
  {"service"=>{"ks"=>{"service"=>"Утримання буд. та прибуд. територiй", "service_code"=>"1", "company_code"=>"411      "}, "debt"=>{"provider_account_no"=>"", "prepayment"=>"0.0", "amount_to_pay"=>"0.68", "charge"=>"130.47", "debt"=>"129.79", "last_paying"=>"259.58"}, "payer"=>{"ls"=>"4110000106052"}}, "address"=>"Миколайчука І.,   24                KB.52", "bill_identifier"=>"4110000106052", "bill_period"=>"2012-08-18 21:07:00", "fio"=>"Хащевська Г.Б.                                    "},
  {"service"=>{"ks"=>{"service"=>"Гаряча вода", "service_code"=>"3", "company_code"=>"411      "}, "debt"=>{"provider_account_no"=>"26000130262", "prepayment"=>"0.0", "amount_to_pay"=>"20.16", "charge"=>"40.32", "debt"=>"20.16", "last_paying"=>"40.32"}, "payer"=>{"ls"=>"4110000106052"}}, "address"=>"Миколайчука І.,   24                KB.52", "bill_identifier"=>"4110000106052", "bill_period"=>"2012-08-18 21:07:00", "fio"=>"Хащевська Г.Б.                                    "}
]
REST_RESPONSE = {
  "ResponseDebt"=>{
    "debtPayPack"=> DEBT_PAY_PACK
  }
}
  
